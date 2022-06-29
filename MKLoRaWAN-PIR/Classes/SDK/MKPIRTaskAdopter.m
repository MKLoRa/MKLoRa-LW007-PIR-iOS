//
//  MKPIRTaskAdopter.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTaskAdopter.h"

#import <CoreBluetooth/CoreBluetooth.h>

#import "MKBLEBaseSDKAdopter.h"
#import "MKBLEBaseSDKDefines.h"

#import "MKPIROperationID.h"
#import "MKPIRSDKDataAdopter.h"

@implementation MKPIRTaskAdopter

+ (NSDictionary *)parseReadDataWithCharacteristic:(CBCharacteristic *)characteristic {
    NSData *readData = characteristic.value;
    NSLog(@"+++++%@-----%@",characteristic.UUID.UUIDString,readData);
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
        //产品型号
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"modeID":tempString} operationID:mk_pir_taskReadDeviceModelOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
        //firmware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"firmware":tempString} operationID:mk_pir_taskReadFirmwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
        //hardware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"hardware":tempString} operationID:mk_pir_taskReadHardwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
        //soft ware
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"software":tempString} operationID:mk_pir_taskReadSoftwareOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
        //manufacturerKey
        NSString *tempString = [[NSString alloc] initWithData:readData encoding:NSUTF8StringEncoding];
        return [self dataParserGetDataSuccess:@{@"manufacturer":tempString} operationID:mk_pir_taskReadManufacturerOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //密码相关
        NSString *content = [MKBLEBaseSDKAdopter hexStringFromData:readData];
        NSString *state = @"";
        if (content.length == 10) {
            state = [content substringWithRange:NSMakeRange(8, 2)];
        }
        return [self dataParserGetDataSuccess:@{@"state":state} operationID:mk_pir_connectPasswordOperation];
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]] || [characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA06"]]) {
        return [self parseCustomData:readData];
    }
    return @{};
}

+ (NSDictionary *)parseWriteDataWithCharacteristic:(CBCharacteristic *)characteristic {
    return @{};
}

#pragma mark - 数据解析
+ (NSDictionary *)parseCustomData:(NSData *)readData {
    NSString *readString = [MKBLEBaseSDKAdopter hexStringFromData:readData];
    if (![[readString substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"ed"]) {
        return @{};
    }
    NSInteger dataLen = [MKBLEBaseSDKAdopter getDecimalWithHex:readString range:NSMakeRange(6, 2)];
    if (readData.length != dataLen + 4) {
        return @{};
    }
    NSString *flag = [readString substringWithRange:NSMakeRange(2, 2)];
    NSString *cmd = [readString substringWithRange:NSMakeRange(4, 2)];
    NSString *content = [readString substringWithRange:NSMakeRange(8, dataLen * 2)];
    if ([flag isEqualToString:@"00"]) {
        //读取
        return [self parseCustomReadData:content cmd:cmd data:readData];
    }
    if ([flag isEqualToString:@"01"]) {
        return [self parseCustomConfigData:content cmd:cmd];
    }
    return @{};
}

+ (NSDictionary *)parseCustomReadData:(NSString *)content cmd:(NSString *)cmd data:(NSData *)data {
    mk_pir_taskOperationID operationID = mk_pir_defaultTaskOperationID;
    NSDictionary *resultDic = @{};
    
    if ([cmd isEqualToString:@"01"]) {
        //读取LoRaWAN频段
        resultDic = @{
            @"region":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanRegionOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //读取LoRaWAN入网类型
        resultDic = @{
            @"modem":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanModemOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //读取LoRaWAN DEVEUI
        resultDic = @{
            @"devEUI":content,
        };
        operationID = mk_pir_taskReadLorawanDEVEUIOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //读取LoRaWAN APPEUI
        resultDic = @{
            @"appEUI":content
        };
        operationID = mk_pir_taskReadLorawanAPPEUIOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //读取LoRaWAN APPKEY
        resultDic = @{
            @"appKey":content
        };
        operationID = mk_pir_taskReadLorawanAPPKEYOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //读取LoRaWAN DEVADDR
        resultDic = @{
            @"devAddr":content
        };
        operationID = mk_pir_taskReadLorawanDEVADDROperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //读取LoRaWAN APPSKEY
        resultDic = @{
            @"appSkey":content
        };
        operationID = mk_pir_taskReadLorawanAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //读取LoRaWAN nwkSkey
        resultDic = @{
            @"nwkSkey":content
        };
        operationID = mk_pir_taskReadLorawanNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //读取LoRaWAN 上行数据类型
        resultDic = @{
            @"messageType":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //读取LoRaWAN 重传次数
        resultDic = @{
            @"number":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //读取LoRaWAN CH
        resultDic = @{
            @"CHL":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)],
            @"CHH":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)]
        };
        operationID = mk_pir_taskReadLorawanCHOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //读取LoRaWAN DR
        resultDic = @{
            @"DR":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanDROperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //读取LoRaWAN 数据发送策略
        BOOL isOn = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *DRL = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        NSString *DRH = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(4, 2)];
        resultDic = @{
            @"isOn":@(isOn),
            @"DRL":DRL,
            @"DRH":DRH,
        };
        operationID = mk_pir_taskReadLorawanUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //读取LoRaWAN duty cycle
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadLorawanDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //读取LoRaWAN devtime指令同步间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanDevTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //读取LoRaWAN LinkCheckReq指令间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //读取Beacon使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadBeaconModeStatusOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //读取可连接状态
        BOOL connectable = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"connectable":@(connectable)
        };
        operationID = mk_pir_taskReadDeviceConnectableOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //读取蓝牙配置模式下广播超时时间
        resultDic = @{
            @"timeout":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //读取密码开关
        BOOL need = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"need":@(need)
        };
        operationID = mk_pir_taskReadConnectationNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //读取设备Tx Power
        NSString *txPower = [MKPIRSDKDataAdopter fetchTxPowerValueString:content];
        resultDic = @{@"txPower":txPower};
        operationID = mk_pir_taskReadTxPowerOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //读取设备广播名称
        NSData *nameData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *deviceName = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"deviceName":(MKValidStr(deviceName) ? deviceName : @""),
        };
        operationID = mk_pir_taskReadDeviceNameOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //读取PIR监测开关
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadPIRFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //读取PIR持续占用上报间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadPIRReportIntervalOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //读取PIR灵敏度档位设置
        NSInteger value = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"value":[NSString stringWithFormat:@"%ld",(long)(value - 1)],
        };
        operationID = mk_pir_taskReadPIRSensitivityOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //读取PIR延时时间档位设置
        NSInteger value = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"value":[NSString stringWithFormat:@"%ld",(long)(value - 1)],
        };
        operationID = mk_pir_taskReadPIRDelayTimeOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //读取门磁感应功能状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadDoorSensorSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //读取温湿度监测功能是否打开
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadHTSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //读取温湿度数据采样间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadHTSampleRateOperation;
    }else if ([cmd isEqualToString:@"37"]) {
        //读取温度阈值报警使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadTempThresholdAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"38"]) {
        //读取温度上下限阈值
        NSNumber *minValue = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(0, 2)]];
        NSNumber *maxValue = [MKBLEBaseSDKAdopter signedHexTurnString:[content substringWithRange:NSMakeRange(2, 2)]];
        resultDic = @{
            @"minValue":minValue,
            @"maxValue":maxValue,
        };
        operationID = mk_pir_taskReadTempThresholdOperation;
    }else if ([cmd isEqualToString:@"3a"]) {
        //读取温度变化报警使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadTempChangeAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"3b"]) {
        //读取温度变化报警设定时间
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadTempChangeAlarmDurationConditionOperation;
    }else if ([cmd isEqualToString:@"3c"]) {
        //读取温度变化值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadTempChangeAlarmChangeValueThresholdOperation;
    }else if ([cmd isEqualToString:@"3d"]) {
        //读取湿度阈值报警使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadRHThresholdAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"3e"]) {
        //读取湿度上限阈值
        NSNumber *minValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, 2)];
        NSNumber *maxValue = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 2)];
        resultDic = @{
            @"minValue":minValue,
            @"maxValue":maxValue,
        };
        operationID = mk_pir_taskReadRHThresholdOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //读取湿度变化报警使能
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadRHChangeAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //读取湿度变化报警设定时间
        resultDic = @{
            @"duration":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadRHChangeAlarmDurationConditionOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //读取湿度变化值
        resultDic = @{
            @"threshold":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadRHChangeAlarmChangeValueThresholdOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //读取时区
        resultDic = @{
            @"timeZone":[MKBLEBaseSDKAdopter signedHexTurnString:content],
        };
        operationID = mk_pir_taskReadTimeZoneOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //读取密码
        NSData *passwordData = [data subdataWithRange:NSMakeRange(4, data.length - 4)];
        NSString *password = [[NSString alloc] initWithData:passwordData encoding:NSUTF8StringEncoding];
        resultDic = @{
            @"password":(MKValidStr(password) ? password : @""),
        };
        operationID = mk_pir_taskReadPasswordOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //读取广播间隔
        resultDic = @{
            @"interval":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //读取低电档位
        resultDic = @{
            @"value":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //读取低电上报状态
        BOOL isOn = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"isOn":@(isOn)
        };
        operationID = mk_pir_taskReadLowPowerPayloadOperation;
    }else if ([cmd isEqualToString:@"54"]) {
        //读取LoRaWAN网络状态
        resultDic = @{
            @"status":[MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)],
        };
        operationID = mk_pir_taskReadLorawanNetworkStatusOperation;
    }else if ([cmd isEqualToString:@"56"]) {
        //读取电池电量
        NSInteger value = [MKBLEBaseSDKAdopter getDecimalWithHex:content range:NSMakeRange(0, content.length)];
        
        resultDic = @{
            @"voltage":[NSString stringWithFormat:@"%.3f",(value * 0.001)],
        };
        operationID = mk_pir_taskReadBatteryVoltageOperation;
    }else if ([cmd isEqualToString:@"57"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_pir_taskReadMacAddressOperation;
    }else if ([cmd isEqualToString:@"58"]) {
        //读取PIR状态
        BOOL detected = ([content isEqualToString:@"01"]);
        resultDic = @{
            @"detected":@(detected)
        };
        operationID = mk_pir_taskReadPIRStatusOperation;
    }else if ([cmd isEqualToString:@"59"]) {
        //读取门磁传感器数据
        BOOL open = ([[content substringWithRange:NSMakeRange(0, 2)] isEqualToString:@"01"]);
        NSString *times = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(2, 4)];
        resultDic = @{
            @"open":@(open),
            @"times":times,
        };
        operationID = mk_pir_taskReadDoorSensorDatasOperation;
    }else if ([cmd isEqualToString:@"5c"]) {
        //读取产测状态
        NSString *status = [MKBLEBaseSDKAdopter getDecimalStringWithHex:content range:NSMakeRange(0, content.length)];
        resultDic = @{
            @"status":status,
        };
        operationID = mk_pir_taskReadPCBAStatusOperation;
    }else if ([cmd isEqualToString:@"68"]) {
        //读取MAC地址
        NSString *macAddress = [NSString stringWithFormat:@"%@:%@:%@:%@:%@:%@",[content substringWithRange:NSMakeRange(0, 2)],[content substringWithRange:NSMakeRange(2, 2)],[content substringWithRange:NSMakeRange(4, 2)],[content substringWithRange:NSMakeRange(6, 2)],[content substringWithRange:NSMakeRange(8, 2)],[content substringWithRange:NSMakeRange(10, 2)]];
        resultDic = @{@"macAddress":[macAddress uppercaseString]};
        operationID = mk_pir_taskReadMacAddressOperation;
    }
    
    return [self dataParserGetDataSuccess:resultDic operationID:operationID];
}

+ (NSDictionary *)parseCustomConfigData:(NSString *)content cmd:(NSString *)cmd {
    mk_pir_taskOperationID operationID = mk_pir_defaultTaskOperationID;
    BOOL success = [content isEqualToString:@"01"];
    
    if ([cmd isEqualToString:@"01"]) {
        //配置LoRaWAN频段
        operationID = mk_pir_taskConfigRegionOperation;
    }else if ([cmd isEqualToString:@"02"]) {
        //配置LoRaWAN入网类型
        operationID = mk_pir_taskConfigModemOperation;
    }else if ([cmd isEqualToString:@"03"]) {
        //配置LoRaWAN DEVEUI
        operationID = mk_pir_taskConfigDEVEUIOperation;
    }else if ([cmd isEqualToString:@"04"]) {
        //配置LoRaWAN APPEUI
        operationID = mk_pir_taskConfigAPPEUIOperation;
    }else if ([cmd isEqualToString:@"05"]) {
        //配置LoRaWAN APPKEY
        operationID = mk_pir_taskConfigAPPKEYOperation;
    }else if ([cmd isEqualToString:@"06"]) {
        //配置LoRaWAN DEVADDR
        operationID = mk_pir_taskConfigDEVADDROperation;
    }else if ([cmd isEqualToString:@"07"]) {
        //配置LoRaWAN APPSKEY
        operationID = mk_pir_taskConfigAPPSKEYOperation;
    }else if ([cmd isEqualToString:@"08"]) {
        //配置LoRaWAN nwkSkey
        operationID = mk_pir_taskConfigNWKSKEYOperation;
    }else if ([cmd isEqualToString:@"09"]) {
        //配置LoRaWAN 上行数据类型
        operationID = mk_pir_taskConfigMessageTypeOperation;
    }else if ([cmd isEqualToString:@"0a"]) {
        //配置LoRaWAN 重传次数
        operationID = mk_pir_taskConfigMaxRetransmissionTimesOperation;
    }else if ([cmd isEqualToString:@"0b"]) {
        //配置LoRaWAN CH
        operationID = mk_pir_taskConfigCHValueOperation;
    }else if ([cmd isEqualToString:@"0c"]) {
        //配置LoRaWAN DR
        operationID = mk_pir_taskConfigDRValueOperation;
    }else if ([cmd isEqualToString:@"0d"]) {
        //配置LoRaWAN 数据发送策略
        operationID = mk_pir_taskConfigUplinkStrategyOperation;
    }else if ([cmd isEqualToString:@"0e"]) {
        //配置LoRaWAN duty cycle
        operationID = mk_pir_taskConfigDutyCycleStatusOperation;
    }else if ([cmd isEqualToString:@"0f"]) {
        //配置LoRaWAN devtime指令同步间隔
        operationID = mk_pir_taskConfigTimeSyncIntervalOperation;
    }else if ([cmd isEqualToString:@"10"]) {
        //配置LoRaWAN LinkCheckReq指令间隔
        operationID = mk_pir_taskConfigNetworkCheckIntervalOperation;
    }else if ([cmd isEqualToString:@"20"]) {
        //配置Beacon Mode开关
        operationID = mk_pir_taskConfigBeaconModeStatusOperation;
    }else if ([cmd isEqualToString:@"21"]) {
        //配置Beacon 广播间隔
        operationID = mk_pir_taskConfigAdvIntervalOperation;
    }else if ([cmd isEqualToString:@"22"]) {
        //配置可连接状态
        operationID = mk_pir_taskConfigConnectableStatusOperation;
    }else if ([cmd isEqualToString:@"23"]) {
        //配置蓝牙配置模式下广播超时时间
        operationID = mk_pir_taskConfigBroadcastTimeoutOperation;
    }else if ([cmd isEqualToString:@"24"]) {
        //配置是否需要连接密码
        operationID = mk_pir_taskConfigNeedPasswordOperation;
    }else if ([cmd isEqualToString:@"25"]) {
        //配置Tx Power
        operationID = mk_pir_taskConfigTxPowerOperation;
    }else if ([cmd isEqualToString:@"26"]) {
        //配置广播名称
        operationID = mk_pir_taskConfigDeviceNameOperation;
    }else if ([cmd isEqualToString:@"30"]) {
        //配置PIR检测开关
        operationID = mk_pir_taskConfigPIRFunctionStatusOperation;
    }else if ([cmd isEqualToString:@"31"]) {
        //配置PIR持续占用上报间隔
        operationID = mk_pir_taskConfigPIRReportIntervalOperation;
    }else if ([cmd isEqualToString:@"32"]) {
        //配置PIR灵敏度档位
        operationID = mk_pir_taskConfigPIRSensitivityOperation;
    }else if ([cmd isEqualToString:@"33"]) {
        //配置PIR延时时间档位
        operationID = mk_pir_taskConfigPIRDelayTimeOperation;
    }else if ([cmd isEqualToString:@"34"]) {
        //配置门磁感应功能状态
        operationID = mk_pir_taskConfigDoorSensorSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"35"]) {
        //配置温湿度检测时能
        operationID = mk_pir_taskConfigHTSwitchStatusOperation;
    }else if ([cmd isEqualToString:@"36"]) {
        //配置温湿度数据采样间隔
        operationID = mk_pir_taskConfigHTSampleRateOperation;
    }else if ([cmd isEqualToString:@"37"]) {
        //配置温度阈值报警使能
        operationID = mk_pir_taskConfigTempThresholdAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"38"]) {
        //配置温度上下限阈值
        operationID = mk_pir_taskConfigTempThresholdOperation;
    }else if ([cmd isEqualToString:@"3a"]) {
        //配置温度变化报警使能
        operationID = mk_pir_taskConfigTempChangeAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"3b"]) {
        //配置温度变化报警设定时间
        operationID = mk_pir_taskConfigTempChangeAlarmDurationConditionOperation;
    }else if ([cmd isEqualToString:@"3c"]) {
        //配置温度变化报警值
        operationID = mk_pir_taskConfigTempChangeAlarmChangeValueThresholdOperation;
    }else if ([cmd isEqualToString:@"3d"]) {
        //配置湿度阈值报警使能
        operationID = mk_pir_taskConfigRHThresholdAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"3e"]) {
        //配置湿度上下限阈值
        operationID = mk_pir_taskConfigRHThresholdOperation;
    }else if ([cmd isEqualToString:@"40"]) {
        //配置湿度变化报警使能
        operationID = mk_pir_taskConfigRHChangeAlarmStatusOperation;
    }else if ([cmd isEqualToString:@"41"]) {
        //配置湿度变化报警设定时间
        operationID = mk_pir_taskConfigRHChangeAlarmDurationConditionOperation;
    }else if ([cmd isEqualToString:@"42"]) {
        //配置湿度变化报警设定值
        operationID = mk_pir_taskConfigRHChangeAlarmChangeValueThresholdOperation;
    }else if ([cmd isEqualToString:@"43"]) {
        //配置时区
        operationID = mk_pir_taskConfigTimeZoneOperation;
    }else if ([cmd isEqualToString:@"44"]) {
        //修改密码
        operationID = mk_pir_taskConfigPasswordOperation;
    }else if ([cmd isEqualToString:@"46"]) {
        //配置心跳间隔
        operationID = mk_pir_taskConfigHeartbeatIntervalOperation;
    }else if ([cmd isEqualToString:@"47"]) {
        //配置低电档位
        operationID = mk_pir_taskConfigLowPowerPromptOperation;
    }else if ([cmd isEqualToString:@"48"]) {
        //配置低电上报
        operationID = mk_pir_taskConfigLowPowerPayloadOperation;
    }else if ([cmd isEqualToString:@"50"]) {
        //配置LoRaWAN 入网
        operationID = mk_pir_taskRestartDeviceOperation;
    }else if ([cmd isEqualToString:@"51"]) {
        //恢复出厂设置
        operationID = mk_pir_taskFactoryResetOperation;
    }else if ([cmd isEqualToString:@"52"]) {
        //关机
        operationID = mk_pir_taskPowerOffOperation;
    }else if ([cmd isEqualToString:@"53"]) {
        //同步时间
        operationID = mk_pir_taskConfigDeviceTimeOperation;
    }
    
    return [self dataParserGetDataSuccess:@{@"success":@(success)} operationID:operationID];
}



#pragma mark -

+ (NSDictionary *)dataParserGetDataSuccess:(NSDictionary *)returnData operationID:(mk_pir_taskOperationID)operationID{
    if (!returnData) {
        return @{};
    }
    return @{@"returnData":returnData,@"operationID":@(operationID)};
}

@end
