//
//  MKPIRPirSettingsModel.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRPirSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKPIRInterface.h"
#import "MKPIRInterface+MKPIRConfig.h"

@interface MKPIRPirSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKPIRPirSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSwitchStatus]) {
            [self operationFailedBlockWithMsg:@"Read Function Switch Error" block:failedBlock];
            return;
        }
        if (![self readReportInterval]) {
            [self operationFailedBlockWithMsg:@"Read Report Interval Error" block:failedBlock];
            return;
        }
        if (![self readPIRSensitivity]) {
            [self operationFailedBlockWithMsg:@"Read PIR Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self readPIRDelayTime]) {
            [self operationFailedBlockWithMsg:@"Read PIR Delay Time Error" block:failedBlock];
            return;
        }
        if (![self readPIRStatus]) {
            [self operationFailedBlockWithMsg:@"Read PIR Status Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        if (![self configSwitchStatus]) {
            [self operationFailedBlockWithMsg:@"Config Function Switch Error" block:failedBlock];
            return;
        }
        if (![self configReportInterval]) {
            [self operationFailedBlockWithMsg:@"Config Report Interval Error" block:failedBlock];
            return;
        }
        if (![self configPIRSensitivity]) {
            [self operationFailedBlockWithMsg:@"Config PIR Sensitivity Error" block:failedBlock];
            return;
        }
        if (![self configPIRDelayTime]) {
            [self operationFailedBlockWithMsg:@"Config PIR Delay Time Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

#pragma mark - interface
- (BOOL)readSwitchStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPIRFunctionStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = returnData[@"result"][@"isOn"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSwitchStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_ConfigPIRFunctionStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readReportInterval {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPIRReportIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.interval = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configReportInterval {
    __block BOOL success = NO;
    [MKPIRInterface pir_configPIRReportInterval:[self.interval integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPIRSensitivity {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPIRSensitivityWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pirSensitivity = [returnData[@"result"][@"value"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPIRSensitivity {
    __block BOOL success = NO;
    [MKPIRInterface pir_configPIRSensitivity:self.pirSensitivity sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPIRDelayTime {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPIRDelayTimeWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pirDelayTime = [returnData[@"result"][@"value"] integerValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configPIRDelayTime {
    __block BOOL success = NO;
    [MKPIRInterface pir_configPIRDelayTime:self.pirDelayTime sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readPIRStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPIRStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.detected = [returnData[@"result"][@"detected"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"PIRSettingParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.interval) || [self.interval integerValue] < 1 || [self.interval integerValue] > 60) {
        return NO;
    }
    return YES;
}

#pragma mark - getter
- (dispatch_semaphore_t)semaphore {
    if (!_semaphore) {
        _semaphore = dispatch_semaphore_create(0);
    }
    return _semaphore;
}

- (dispatch_queue_t)readQueue {
    if (!_readQueue) {
        _readQueue = dispatch_queue_create("PIRSettingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
