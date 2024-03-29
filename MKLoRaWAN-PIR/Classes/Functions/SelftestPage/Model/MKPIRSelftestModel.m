//
//  MKPIRSelftestModel.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2022/5/26.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRSelftestModel.h"

#import "MKMacroDefines.h"

#import "MKPIRInterface.h"

@interface MKPIRSelftestModel ()

@property (nonatomic, strong)dispatch_queue_t readQueue;

@property (nonatomic, strong)dispatch_semaphore_t semaphore;

@end

@implementation MKPIRSelftestModel
- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock {
    dispatch_async(self.readQueue, ^{
        if (![self readPCBAStatus]) {
            [self operationFailedBlockWithMsg:@"Read PCBA Status Error" block:failedBlock];
            return;
        }
        if (![self readBatteryDatas]) {
            [self operationFailedBlockWithMsg:@"Read Battery Datas Error" block:failedBlock];
            return;
        }
        moko_dispatch_main_safe(^{
            sucBlock();
        });
    });
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

- (BOOL)readBatteryDatas {
    __block BOOL success = NO;
    [MKPIRInterface pir_readBatteryInformationWithSucBlock:^(id  _Nonnull returnData) {
        success = YES;
        self.workTimes = returnData[@"result"][@"workTimes"];
        self.advCount = returnData[@"result"][@"advCount"];
        self.thSamplingCount = returnData[@"result"][@"thSamplingCount"];
        self.loraPowerConsumption = returnData[@"result"][@"loraPowerConsumption"];
        self.loraSendCount = returnData[@"result"][@"loraSendCount"];
        self.batteryPower = returnData[@"result"][@"batteryPower"];
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
