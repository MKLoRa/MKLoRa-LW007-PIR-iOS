//
//  MKPIRTHSettingsModel.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTHSettingsModel.h"

#import "MKMacroDefines.h"

#import "MKPIRInterface.h"
#import "MKPIRInterface+MKPIRConfig.h"

@interface MKPIRTHSettingsModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKPIRTHSettingsModel

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readSwitchStatus]) {
            [self operationFailedBlockWithMsg:@"Read Function Switch Error" block:failedBlock];
            return;
        }
        if (![self readSampleRate]) {
            [self operationFailedBlockWithMsg:@"Read Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self readHTDatas]) {
            [self operationFailedBlockWithMsg:@"Read HT Data Error" block:failedBlock];
            return;
        }
        if (![self readTempThresholdAlarm]) {
            [self operationFailedBlockWithMsg:@"Read Temp Threshold Alarm Error" block:failedBlock];
            return;
        }
        if (![self readTempThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Temp Threshold Error" block:failedBlock];
            return;
        }
        if (![self readTempChangeAlarm]) {
            [self operationFailedBlockWithMsg:@"Read Temp Change Alarm Error" block:failedBlock];
            return;
        }
        if (![self readTempChangeAlarmDuration]) {
            [self operationFailedBlockWithMsg:@"Read Temp Duration Condition Error" block:failedBlock];
            return;
        }
        if (![self readTempChangeAlarmThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Temp Change Value Threshold Error" block:failedBlock];
            return;
        }
        if (![self readRHThresholdAlarm]) {
            [self operationFailedBlockWithMsg:@"Read RH Threshold Alarm Error" block:failedBlock];
            return;
        }
        if (![self readRHThreshold]) {
            [self operationFailedBlockWithMsg:@"Read RH Threshold Error" block:failedBlock];
            return;
        }
        if (![self readRHChangeAlarm]) {
            [self operationFailedBlockWithMsg:@"Read RH Change Alarm Error" block:failedBlock];
            return;
        }
        if (![self readRHChangeAlarmDuration]) {
            [self operationFailedBlockWithMsg:@"Read RH Duration Condition Error" block:failedBlock];
            return;
        }
        if (![self readRHChangeAlarmThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Temp Change Value Threshold Error" block:failedBlock];
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
        if (![self configSampleRate]) {
            [self operationFailedBlockWithMsg:@"Config Sample Rate Error" block:failedBlock];
            return;
        }
        if (![self configTempThresholdAlarm]) {
            [self operationFailedBlockWithMsg:@"Config Temp Threshold Alarm Error" block:failedBlock];
            return;
        }
        if (![self configTempThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Temp Threshold Error" block:failedBlock];
            return;
        }
        if (![self configTempChangeAlarm]) {
            [self operationFailedBlockWithMsg:@"Config Temp Change Alarm Error" block:failedBlock];
            return;
        }
        if (![self configTempChangeAlarmDuration]) {
            [self operationFailedBlockWithMsg:@"Config Temp Duration Condition Error" block:failedBlock];
            return;
        }
        if (![self configTempChangeAlarmThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Temp Change Value Threshold Error" block:failedBlock];
            return;
        }
        if (![self configRHThresholdAlarm]) {
            [self operationFailedBlockWithMsg:@"Config RH Threshold Alarm Error" block:failedBlock];
            return;
        }
        if (![self configRHThreshold]) {
            [self operationFailedBlockWithMsg:@"Config RH Threshold Error" block:failedBlock];
            return;
        }
        if (![self configRHChangeAlarm]) {
            [self operationFailedBlockWithMsg:@"Config RH Change Alarm Error" block:failedBlock];
            return;
        }
        if (![self configRHChangeAlarmDuration]) {
            [self operationFailedBlockWithMsg:@"Config RH Duration Condition Error" block:failedBlock];
            return;
        }
        if (![self configRHChangeAlarmThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Temp Change Value Threshold Error" block:failedBlock];
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
    [MKPIRInterface pir_readHTSwitchStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.isOn = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSwitchStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_configHTSwitchStatus:self.isOn sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSampleRate {
    __block BOOL success = NO;
    [MKPIRInterface pir_readHTSampleRateWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleRate = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configSampleRate {
    __block BOOL success = NO;
    [MKPIRInterface pir_configHTSampleRate:[self.sampleRate integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readHTDatas {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTHDatasWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.temperature = returnData[@"result"][@"temperature"];
        self.humidity = returnData[@"result"][@"humidity"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTempThresholdAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTempThresholdAlarmStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tempThresholdAlarm = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTempThresholdAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_configTempThresholdAlarmStatus:self.tempThresholdAlarm sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTempThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTempThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tempMax = [NSString stringWithFormat:@"%ld",(long)[returnData[@"result"][@"maxValue"] integerValue]];
        self.tempMin = [NSString stringWithFormat:@"%ld",(long)[returnData[@"result"][@"minValue"] integerValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTempThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_configTempThreshold:[self.tempMax integerValue] minThreshold:[self.tempMin integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTempChangeAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTempChangeAlarmStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tempChangeAlarm = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTempChangeAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_configTempChangeAlarmStatus:self.tempChangeAlarm sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTempChangeAlarmDuration {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTempChangeAlarmDurationConditionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tempDuration = returnData[@"result"][@"duration"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTempChangeAlarmDuration {
    __block BOOL success = NO;
    [MKPIRInterface pir_configTempChangeAlarmDurationCondition:[self.tempDuration integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readTempChangeAlarmThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_readTempChangeAlarmChangeValueThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.tempChangeValueThreshold = returnData[@"result"][@"threshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configTempChangeAlarmThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_configTempChangeAlarmChangeValueThreshold:[self.tempChangeValueThreshold integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRHThresholdAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_readRHThresholdAlarmStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rhThresholdAlarm = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRHThresholdAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_configRHThresholdAlarmStatus:self.rhThresholdAlarm sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRHThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_readRHThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rhMax = [NSString stringWithFormat:@"%ld",(long)[returnData[@"result"][@"maxValue"] integerValue]];
        self.rhMin = [NSString stringWithFormat:@"%ld",(long)[returnData[@"result"][@"minValue"] integerValue]];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRHThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_configRHThreshold:[self.rhMax integerValue] minThreshold:[self.rhMin integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRHChangeAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_readRHChangeAlarmStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rhChangeAlarm = [returnData[@"result"][@"isOn"] boolValue];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRHChangeAlarm {
    __block BOOL success = NO;
    [MKPIRInterface pir_configRHChangeAlarmStatus:self.rhChangeAlarm sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRHChangeAlarmDuration {
    __block BOOL success = NO;
    [MKPIRInterface pir_readRHChangeAlarmDurationConditionWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rhDuration = returnData[@"result"][@"duration"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRHChangeAlarmDuration {
    __block BOOL success = NO;
    [MKPIRInterface pir_configRHChangeAlarmDurationCondition:[self.rhDuration integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readRHChangeAlarmThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_readRHChangeAlarmChangeValueThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.rhChangeValueThreshold = returnData[@"result"][@"threshold"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configRHChangeAlarmThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_configRHChangeAlarmChangeValueThreshold:[self.rhChangeValueThreshold integerValue] sucBlock:^{
        success = YES;
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
        NSError *error = [[NSError alloc] initWithDomain:@"HTSettingParams"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    })
}

- (BOOL)validParams {
    if (!ValidStr(self.sampleRate) || [self.sampleRate integerValue] < 1 || [self.sampleRate integerValue] > 60) {
        return NO;
    }
    if (!ValidStr(self.tempMax) || !ValidStr(self.tempMin)) {
        return NO;
    }
    if ([self.tempMin integerValue] < -30 || [self.tempMax integerValue] > 60 || [self.tempMin integerValue] >= [self.tempMax integerValue]) {
        return NO;
    }
    if (!ValidStr(self.tempDuration) || [self.tempDuration integerValue] < 1 || [self.tempDuration integerValue] > 24) {
        return NO;
    }
    if (!ValidStr(self.tempChangeValueThreshold) || [self.tempChangeValueThreshold integerValue] < 1 || [self.tempChangeValueThreshold integerValue] > 20) {
        return NO;
    }
    if (!ValidStr(self.rhMax) || !ValidStr(self.rhMin)) {
        return NO;
    }
    if ([self.rhMin integerValue] < 0 || [self.rhMax integerValue] > 100 || [self.rhMin integerValue] >= [self.rhMax integerValue]) {
        return NO;
    }
    if (!ValidStr(self.rhDuration) || [self.rhDuration integerValue] < 1 || [self.rhDuration integerValue] > 24) {
        return NO;
    }
    if (!ValidStr(self.rhChangeValueThreshold) || [self.rhChangeValueThreshold integerValue] < 1 || [self.rhChangeValueThreshold integerValue] > 100) {
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
        _readQueue = dispatch_queue_create("HTSettingQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
