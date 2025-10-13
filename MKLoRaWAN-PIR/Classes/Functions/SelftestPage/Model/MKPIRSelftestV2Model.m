//
//  MKPIRSelftestV2Model.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2025/10/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRSelftestV2Model.h"

#import "MKMacroDefines.h"

#import "MKPIRInterface.h"
#import "MKPIRInterface+MKPIRConfig.h"

@interface MKPIRSelftestV2Model ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKPIRSelftestV2Model

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPCBAStatus]) {
            [self operationFailedBlockWithMsg:@"Read PCBA Status Error" block:failedBlock];
            return;
        }
        if (![self readSelftestStatus]) {
            [self operationFailedBlockWithMsg:@"Read Self Test Status Error" block:failedBlock];
            return;
        }
        if (![self readCondition1VoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Read Condition1 Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self readCondition1SampleInterval]) {
            [self operationFailedBlockWithMsg:@"Read Condition1 Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self readCondition1SampleTimes]) {
            [self operationFailedBlockWithMsg:@"Read Condition1 Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
}

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self validParams]) {
            [self operationFailedBlockWithMsg:@"Opps！Save failed. Please check the input characters and try again." block:failedBlock];
            return;
        }
        
        if (![self configCondition1VoltageThreshold]) {
            [self operationFailedBlockWithMsg:@"Config Condition1 Voltage Threshold Error" block:failedBlock];
            return;
        }
        if (![self configCondition1SampleInterval]) {
            [self operationFailedBlockWithMsg:@"Config Condition1 Sample Interval Error" block:failedBlock];
            return;
        }
        if (![self configCondition1SampleTimes]) {
            [self operationFailedBlockWithMsg:@"Config Condition1 Sample Times Error" block:failedBlock];
            return;
        }
        
        moko_dispatch_main_safe(^{
            if (sucBlock) {
                sucBlock();
            }
        });
    });
}

- (BOOL)validParams {
    if (self.voltageThreshold1 < 0 || self.voltageThreshold1 > 20) {
        return NO;
    }
    if (!ValidStr(self.sampleInterval1) || [self.sampleInterval1 integerValue] < 1 || [self.sampleInterval1 integerValue] > 1440) {
        return NO;
    }
    if (!ValidStr(self.sampleTimes1) || [self.sampleTimes1 integerValue] < 1 || [self.sampleTimes1 integerValue] > 100) {
        return NO;
    }
    
    return YES;
}

#pragma mark - interface
- (BOOL)readPCBAStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_readPCBAStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.pcbaStatus = returnData[@"result"][@"status"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readSelftestStatus {
    __block BOOL success = NO;
    [MKPIRInterface pir_readSelftestStatusWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.selftestError = ([returnData[@"result"][@"status"] integerValue] == 1);
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCondition1VoltageThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_readLowPowerCondition1VoltageThresholdWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.voltageThreshold1 = [returnData[@"result"][@"threshold"] integerValue] - 44;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCondition1VoltageThreshold {
    __block BOOL success = NO;
    [MKPIRInterface pir_configLowPowerCondition1VoltageThreshold:(self.voltageThreshold1 + 44) sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCondition1SampleInterval {
    __block BOOL success = NO;
    [MKPIRInterface pir_readLowPowerCondition1MinSampleIntervalWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleInterval1 = returnData[@"result"][@"interval"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCondition1SampleInterval {
    __block BOOL success = NO;
    [MKPIRInterface pir_configLowPowerCondition1MinSampleInterval:[self.sampleInterval1 integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)readCondition1SampleTimes {
    __block BOOL success = NO;
    [MKPIRInterface pir_readLowPowerCondition1SampleTimesWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.sampleTimes1 = returnData[@"result"][@"times"];
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

- (BOOL)configCondition1SampleTimes {
    __block BOOL success = NO;
    [MKPIRInterface pir_configLowPowerCondition1SampleTimes:[self.sampleTimes1 integerValue] sucBlock:^{
        success = YES;
        dispatch_semaphore_signal(self.semaphore);
    } failedBlock:^(NSError * _Nonnull error) {
        dispatch_semaphore_signal(self.semaphore);
    }];
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    return success;
}

#pragma mark - private method
- (NSString *)binaryByhex:(NSString *)hex {
    NSDictionary *hexDic = @{
                             @"0":@"0000",@"1":@"0001",@"2":@"0010",
                             @"3":@"0011",@"4":@"0100",@"5":@"0101",
                             @"6":@"0110",@"7":@"0111",@"8":@"1000",
                             @"9":@"1001",@"A":@"1010",@"a":@"1010",
                             @"B":@"1011",@"b":@"1011",@"C":@"1100",
                             @"c":@"1100",@"D":@"1101",@"d":@"1101",
                             @"E":@"1110",@"e":@"1110",@"F":@"1111",
                             @"f":@"1111",
                             };
    NSString *binaryString = @"";
    for (int i=0; i<[hex length]; i++) {
        NSRange rage;
        rage.length = 1;
        rage.location = i;
        NSString *key = [hex substringWithRange:rage];
        binaryString = [NSString stringWithFormat:@"%@%@",binaryString,
                        [NSString stringWithFormat:@"%@",[hexDic objectForKey:key]]];
        
    }
    
    return binaryString;
}

- (void)operationFailedBlockWithMsg:(NSString *)msg block:(void (^)(NSError *error))block {
    moko_dispatch_main_safe(^{
        NSError *error = [[NSError alloc] initWithDomain:@"selftest"
                                                    code:-999
                                                userInfo:@{@"errorInfo":msg}];
        block(error);
    });
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
        _readQueue = dispatch_queue_create("selftestQueue", DISPATCH_QUEUE_SERIAL);
    }
    return _readQueue;
}

@end
