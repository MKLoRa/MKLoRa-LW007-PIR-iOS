//
//  MKPIRCentralManager.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRCentralManager.h"

#import "MKBLEBaseCentralManager.h"
#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseLogManager.h"

#import "MKPIRPeripheral.h"
#import "MKPIROperation.h"
#import "CBPeripheral+MKPIRAdd.h"


NSString *const mk_pir_peripheralConnectStateChangedNotification = @"mk_pir_peripheralConnectStateChangedNotification";
NSString *const mk_pir_centralManagerStateChangedNotification = @"mk_pir_centralManagerStateChangedNotification";

NSString *const mk_pir_deviceDisconnectTypeNotification = @"mk_pir_deviceDisconnectTypeNotification";

NSString *const mk_pir_pirStatusNotification = @"mk_pir_pirStatusNotification";
NSString *const mk_pir_doorSensorDatasNotification = @"mk_pir_doorSensorDatasNotification";
NSString *const mk_pir_thSensorDatasNotification = @"mk_pir_thSensorDatasNotification";


static MKPIRCentralManager *manager = nil;
static dispatch_once_t onceToken;

@interface NSObject (MKPIRCentralManager)

@end

@implementation NSObject (MKPIRCentralManager)

+ (void)load{
    [MKPIRCentralManager shared];
}

@end

@interface MKPIRCentralManager ()

@property (nonatomic, copy)NSString *password;

@property (nonatomic, copy)void (^sucBlock)(CBPeripheral *peripheral);

@property (nonatomic, copy)void (^failedBlock)(NSError *error);

@property (nonatomic, assign)mk_pir_centralConnectStatus connectStatus;

@end

@implementation MKPIRCentralManager

- (instancetype)init {
    if (self = [super init]) {
        [[MKBLEBaseCentralManager shared] loadDataManager:self];
    }
    return self;
}

+ (MKPIRCentralManager *)shared {
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [MKPIRCentralManager new];
        }
    });
    return manager;
}

+ (void)sharedDealloc {
    [MKBLEBaseCentralManager singleDealloc];
    manager = nil;
    onceToken = 0;
}

+ (void)removeFromCentralList {
    [[MKBLEBaseCentralManager shared] removeDataManager:manager];
    manager = nil;
    onceToken = 0;
}

#pragma mark - MKBLEBaseScanProtocol
- (void)MKBLEBaseCentralManagerDiscoverPeripheral:(CBPeripheral *)peripheral
                                advertisementData:(NSDictionary<NSString *,id> *)advertisementData
                                             RSSI:(NSNumber *)RSSI {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@",advertisementData);
        NSDictionary *dataModel = [self parseModelWithRssi:RSSI advDic:advertisementData peripheral:peripheral];
        if (!MKValidDict(dataModel)) {
            return ;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(mk_pir_receiveDevice:)]) {
                [self.delegate mk_pir_receiveDevice:dataModel];
            }
        });
    });
}

- (void)MKBLEBaseCentralManagerStartScan {
    if ([self.delegate respondsToSelector:@selector(mk_pir_startScan)]) {
        [self.delegate mk_pir_startScan];
    }
}

- (void)MKBLEBaseCentralManagerStopScan {
    if ([self.delegate respondsToSelector:@selector(mk_pir_stopScan)]) {
        [self.delegate mk_pir_stopScan];
    }
}

#pragma mark - MKBLEBaseCentralManagerStateProtocol
- (void)MKBLEBaseCentralManagerStateChanged:(MKCentralManagerState)centralManagerState {
    NSLog(@"蓝牙中心改变");
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_centralManagerStateChangedNotification object:nil];
}

- (void)MKBLEBasePeripheralConnectStateChanged:(MKPeripheralConnectState)connectState {
    //连接成功的判断必须是发送密码成功之后
    if (connectState == MKPeripheralConnectStateUnknow) {
        self.connectStatus = mk_pir_centralConnectStatusUnknow;
    }else if (connectState == MKPeripheralConnectStateConnecting) {
        self.connectStatus = mk_pir_centralConnectStatusConnecting;
    }else if (connectState == MKPeripheralConnectStateConnectedFailed) {
        self.connectStatus = mk_pir_centralConnectStatusConnectedFailed;
    }else if (connectState == MKPeripheralConnectStateDisconnect) {
        self.connectStatus = mk_pir_centralConnectStatusDisconnect;
    }
    NSLog(@"当前连接状态发生改变了:%@",@(connectState));
    [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_peripheralConnectStateChangedNotification object:nil];
}

#pragma mark - MKBLEBaseCentralManagerProtocol
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++接收数据出错");
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        //引起设备断开连接的类型
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_deviceDisconnectTypeNotification
                                                            object:nil
                                                          userInfo:@{@"type":[content substringWithRange:NSMakeRange(8, 2)]}];
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
        //PIR状态
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        BOOL detected = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_pirStatusNotification
                                                            object:nil
                                                          userInfo:@{@"detected":@(detected)}];
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
        //门磁参数
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        
        BOOL open = ([[content substringWithRange:NSMakeRange(8, 2)] isEqualToString:@"01"]);
        NSString *times = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(10, 4)];
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_doorSensorDatasNotification
                                                            object:nil
                                                          userInfo:@{@"open":@(open),
                                                                     @"times":times,
                                                                   }];
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
        //温湿度
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        
        NSInteger temperature = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(8, 4)];
        NSString *tempValue = [NSString stringWithFormat:@"%.1f",(temperature * 0.1 - 30.f)];
        NSInteger humidity = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(12, 4)];
        NSString *humidityValue = [NSString stringWithFormat:@"%.1f",(humidity * 0.1)];
        [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_thSensorDatasNotification
                                                            object:nil
                                                          userInfo:@{@"temperature":tempValue,
                                                                     @"humidity":humidityValue,
                                                                   }];
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA07"]]) {
        //日志
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:characteristic.value];
        if ([self.logDelegate respondsToSelector:@selector(mk_pir_receiveLog:)]) {
            [self.logDelegate mk_pir_receiveLog:content];
        }
        return;
    }
}
- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    if (error) {
        NSLog(@"+++++++++++++++++发送数据出错");
        return;
    }
    
}

#pragma mark - public method
- (CBCentralManager *)centralManager {
    return [MKBLEBaseCentralManager shared].centralManager;
}

- (CBPeripheral *)peripheral {
    return [MKBLEBaseCentralManager shared].peripheral;
}

- (mk_pir_centralManagerStatus )centralStatus {
    return ([MKBLEBaseCentralManager shared].centralStatus == MKCentralManagerStateEnable)
    ? mk_pir_centralManagerStatusEnable
    : mk_pir_centralManagerStatusUnable;
}

- (void)startScan {
    [[MKBLEBaseCentralManager shared] scanForPeripheralsWithServices:@[[CBUUID UUIDWithString:@"AA05"]] options:nil];
}

- (void)stopScan {
    [[MKBLEBaseCentralManager shared] stopScan];
}

- (void)connectPeripheral:(CBPeripheral *)peripheral
                 password:(NSString *)password
                 sucBlock:(void (^)(CBPeripheral * _Nonnull))sucBlock
              failedBlock:(void (^)(NSError * error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    if (password.length != 8 || ![MKBLEBaseSDKAdopter asciiString:password]) {
        [self operationFailedBlockWithMsg:@"The password should be 8 characters." failedBlock:failedBlock];
        return;
    }
    self.password = @"";
    self.password = password;
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)connectPeripheral:(nonnull CBPeripheral *)peripheral
                 sucBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    if (!peripheral) {
        [MKBLEBaseSDKAdopter operationConnectFailedBlock:failedBlock];
        return;
    }
    self.password = @"";
    __weak typeof(self) weakSelf = self;
    [self connectPeripheral:peripheral successBlock:^(CBPeripheral *peripheral) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (sucBlock) {
            sucBlock(peripheral);
        }
    } failedBlock:^(NSError *error) {
        __strong typeof(self) sself = weakSelf;
        sself.sucBlock = nil;
        sself.failedBlock = nil;
        if (failedBlock) {
            failedBlock(error);
        }
    }];
}

- (void)disconnect {
    [[MKBLEBaseCentralManager shared] disconnect];
}

- (void)addTaskWithTaskID:(mk_pir_taskOperationID)operationID
           characteristic:(CBCharacteristic *)characteristic
              commandData:(NSString *)commandData
             successBlock:(void (^)(id returnData))successBlock
             failureBlock:(void (^)(NSError *error))failureBlock {
    MKPIROperation <MKBLEBaseOperationProtocol>*operation = [self generateOperationWithOperationID:operationID
                                                                                   characteristic:characteristic
                                                                                      commandData:commandData
                                                                                     successBlock:successBlock
                                                                                     failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (void)addReadTaskWithTaskID:(mk_pir_taskOperationID)operationID
               characteristic:(CBCharacteristic *)characteristic
                 successBlock:(void (^)(id returnData))successBlock
                 failureBlock:(void (^)(NSError *error))failureBlock {
    MKPIROperation <MKBLEBaseOperationProtocol>*operation = [self generateReadOperationWithOperationID:operationID
                                                                                       characteristic:characteristic
                                                                                         successBlock:successBlock
                                                                                         failureBlock:failureBlock];
    if (!operation) {
        return;
    }
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

- (BOOL)notifyPirSensorData:(BOOL)notify {
    if (self.connectStatus != mk_pir_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.pir_pirSensorData == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.pir_pirSensorData];
    return YES;
}

- (BOOL)notifyDoorSensorData:(BOOL)notify {
    if (self.connectStatus != mk_pir_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.pir_doorSensorData == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.pir_doorSensorData];
    return YES;
}

- (BOOL)notifyTHSensorData:(BOOL)notify {
    if (self.connectStatus != mk_pir_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.pir_thSensorData == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.pir_thSensorData];
    return YES;
}

- (BOOL)notifyLogData:(BOOL)notify {
    if (self.connectStatus != mk_pir_centralConnectStatusConnected || self.peripheral == nil || self.peripheral.pir_log == nil) {
        return NO;
    }
    [self.peripheral setNotifyValue:notify forCharacteristic:self.peripheral.pir_log];
    return YES;
}

#pragma mark - password method
- (void)connectPeripheral:(CBPeripheral *)peripheral
             successBlock:(void (^)(CBPeripheral *peripheral))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock {
    self.sucBlock = nil;
    self.sucBlock = sucBlock;
    self.failedBlock = nil;
    self.failedBlock = failedBlock;
    MKPIRPeripheral *trackerPeripheral = [[MKPIRPeripheral alloc] initWithPeripheral:peripheral];
    [[MKBLEBaseCentralManager shared] connectDevice:trackerPeripheral sucBlock:^(CBPeripheral * _Nonnull peripheral) {
        if (MKValidStr(self.password) && self.password.length == 8) {
            //需要密码登录
            [self sendPasswordToDevice];
            return;
        }
        //免密登录
        MKBLEBase_main_safe(^{
            self.connectStatus = mk_pir_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_peripheralConnectStateChangedNotification object:nil];
            if (self.sucBlock) {
                self.sucBlock(peripheral);
            }
        });
    } failedBlock:failedBlock];
}

- (void)sendPasswordToDevice {
    NSString *commandData = @"ed010108";
    for (NSInteger i = 0; i < self.password.length; i ++) {
        int asciiCode = [self.password characterAtIndex:i];
        commandData = [commandData stringByAppendingString:[NSString stringWithFormat:@"%1lx",(unsigned long)asciiCode]];
    }
    __weak typeof(self) weakSelf = self;
    MKPIROperation *operation = [[MKPIROperation alloc] initOperationWithID:mk_pir_connectPasswordOperation commandBlock:^{
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:[MKBLEBaseCentralManager shared].peripheral.pir_password type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error || !MKValidDict(returnData) || ![returnData[@"state"] isEqualToString:@"01"]) {
            //密码错误
            [sself operationFailedBlockWithMsg:@"Password Error" failedBlock:sself.failedBlock];
            return ;
        }
        //密码正确
        MKBLEBase_main_safe(^{
            sself.connectStatus = mk_pir_centralConnectStatusConnected;
            [[NSNotificationCenter defaultCenter] postNotificationName:mk_pir_peripheralConnectStateChangedNotification object:nil];
            if (sself.sucBlock) {
                sself.sucBlock([MKBLEBaseCentralManager shared].peripheral);
            }
        });
    }];
    [[MKBLEBaseCentralManager shared] addOperation:operation];
}

#pragma mark - task method
- (MKPIROperation <MKBLEBaseOperationProtocol>*)generateOperationWithOperationID:(mk_pir_taskOperationID)operationID
                                                                 characteristic:(CBCharacteristic *)characteristic
                                                                    commandData:(NSString *)commandData
                                                                   successBlock:(void (^)(id returnData))successBlock
                                                                   failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!MKValidStr(commandData)) {
        [self operationFailedBlockWithMsg:@"The data sent to the device cannot be empty" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKPIROperation <MKBLEBaseOperationProtocol>*operation = [[MKPIROperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared] sendDataToPeripheral:commandData characteristic:characteristic type:CBCharacteristicWriteWithResponse];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

- (MKPIROperation <MKBLEBaseOperationProtocol>*)generateReadOperationWithOperationID:(mk_pir_taskOperationID)operationID
                                                                     characteristic:(CBCharacteristic *)characteristic
                                                                       successBlock:(void (^)(id returnData))successBlock
                                                                       failureBlock:(void (^)(NSError *error))failureBlock{
    if (![[MKBLEBaseCentralManager shared] readyToCommunication]) {
        [self operationFailedBlockWithMsg:@"The current connection device is in disconnect" failedBlock:failureBlock];
        return nil;
    }
    if (!characteristic) {
        [self operationFailedBlockWithMsg:@"Characteristic error" failedBlock:failureBlock];
        return nil;
    }
    __weak typeof(self) weakSelf = self;
    MKPIROperation <MKBLEBaseOperationProtocol>*operation = [[MKPIROperation alloc] initOperationWithID:operationID commandBlock:^{
        [[MKBLEBaseCentralManager shared].peripheral readValueForCharacteristic:characteristic];
    } completeBlock:^(NSError * _Nullable error, id  _Nullable returnData) {
        __strong typeof(self) sself = weakSelf;
        if (error) {
            MKBLEBase_main_safe(^{
                if (failureBlock) {
                    failureBlock(error);
                }
            });
            return ;
        }
        if (!returnData) {
            [sself operationFailedBlockWithMsg:@"Request data error" failedBlock:failureBlock];
            return ;
        }
        NSDictionary *resultDic = @{@"msg":@"success",
                                    @"code":@"1",
                                    @"result":returnData,
                                    };
        MKBLEBase_main_safe(^{
            if (successBlock) {
                successBlock(resultDic);
            }
        });
    }];
    return operation;
}

#pragma mark - private method
- (NSDictionary *)parseModelWithRssi:(NSNumber *)rssi advDic:(NSDictionary *)advDic peripheral:(CBPeripheral *)peripheral {
    if ([rssi integerValue] == 127 || !MKValidDict(advDic) || !peripheral) {
        return @{};
    }
    
    NSData *manufacturerData = advDic[CBAdvertisementDataManufacturerDataKey];
    if (manufacturerData.length != 16) {
        return @{};
    }
    NSString *header = [[MKBLEBaseSDKAdopter hexStringFromData:manufacturerData] substringWithRange:NSMakeRange(0, 4)];
    if (![[header uppercaseString] isEqualToString:@"05AA"]) {
        return @{};
    }
    NSString *content = [[MKBLEBaseSDKAdopter hexStringFromData:manufacturerData] substringFromIndex:4];
    
    NSString *state = [content substringWithRange:NSMakeRange(0, 2)];
    NSString *binary = [MKBLEBaseSDKAdopter binaryByhex:state];
    NSString *pirSensitivity = [binary substringWithRange:NSMakeRange(6, 2)];
    NSString *pirInductionState = [binary substringWithRange:NSMakeRange(4, 2)];
    NSString *roorSensorState = [binary substringWithRange:NSMakeRange(2, 2)];
    BOOL lowPower = [[binary substringWithRange:NSMakeRange(1, 1)] isEqualToString:@"1"];
    BOOL alarm = [[binary substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"1"];
    
    NSString *temperature = [content substringWithRange:NSMakeRange(2, 4)];
    if (![temperature isEqualToString:@"ffff"]) {
        //温度功能启用
        NSInteger temperatureValue = [MKBLEBaseSDKAdopter getDecimalWithHex:temperature range:NSMakeRange(0, 4)];
        temperature = [NSString stringWithFormat:@"%.1f",(temperatureValue * 0.1 - 30.f)];
    }
    
    NSString *humidity = [content substringWithRange:NSMakeRange(6, 4)];
    if (![humidity isEqualToString:@"ffff"]) {
        //温度功能启用
        NSInteger humidityValue = [MKBLEBaseSDKAdopter getDecimalWithHex:humidity range:NSMakeRange(0, 4)];
        humidity = [NSString stringWithFormat:@"%.1f",(humidityValue * 0.1)];
    }
    
    NSInteger batteryValue = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(10, 2)];
    NSString *battery = [NSString stringWithFormat:@"%.1f",(batteryValue * 0.1 + 2.2)];
    
    NSNumber *txPower = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(12, 2)]];
    
    NSString *tempMac = [[content substringWithRange:NSMakeRange(14, 12)] uppercaseString];
    NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",
    [tempMac substringWithRange:NSMakeRange(0, 2)],
    [tempMac substringWithRange:NSMakeRange(2, 2)],
    [tempMac substringWithRange:NSMakeRange(4, 2)],
    [tempMac substringWithRange:NSMakeRange(6, 2)],
    [tempMac substringWithRange:NSMakeRange(8, 2)],
    [tempMac substringWithRange:NSMakeRange(10, 2)]];
    
    NSString *tempState = [content substringWithRange:NSMakeRange(26, 2)];
    NSString *tempBinary = [MKBLEBaseSDKAdopter binaryByhex:tempState];
    BOOL needPassword = [[tempBinary substringWithRange:NSMakeRange(7, 1)] isEqualToString:@"1"];
    
    return @{
        @"rssi":rssi,
        @"peripheral":peripheral,
        @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
        @"macAddress":macAddress,
        @"pirSensitivity":pirSensitivity,
        @"pirInductionState":pirInductionState,
        @"roorSensorState":roorSensorState,
        @"lowPower":@(lowPower),
        @"alarm":@(alarm),
        @"temperature":temperature,
        @"humidity":humidity,
        @"battery":battery,
        @"txPower":txPower,
        @"needPassword":@(needPassword),
        @"connectable":advDic[CBAdvertisementDataIsConnectable],
    };
}

- (void)operationFailedBlockWithMsg:(NSString *)message failedBlock:(void (^)(NSError *error))failedBlock {
    NSError *error = [[NSError alloc] initWithDomain:@"com.moko.MPCentralManager"
                                                code:-999
                                            userInfo:@{@"errorInfo":message}];
    MKBLEBase_main_safe(^{
        if (failedBlock) {
            failedBlock(error);
        }
    });
}

@end
