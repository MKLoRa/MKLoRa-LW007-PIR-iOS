//
//  MKPIRTHSettingsModel.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRTHSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *sampleRate;

@property (nonatomic, copy)NSString *temperature;

@property (nonatomic, copy)NSString *humidity;


@property (nonatomic, assign)BOOL tempThresholdAlarm;

@property (nonatomic, copy)NSString *tempMax;

@property (nonatomic, copy)NSString *tempMin;


@property (nonatomic, assign)BOOL tempChangeAlarm;

@property (nonatomic, copy)NSString *tempDuration;

@property (nonatomic, copy)NSString *tempChangeValueThreshold;


@property (nonatomic, assign)BOOL rhThresholdAlarm;

@property (nonatomic, copy)NSString *rhMax;

@property (nonatomic, copy)NSString *rhMin;


@property (nonatomic, assign)BOOL rhChangeAlarm;

@property (nonatomic, copy)NSString *rhDuration;

@property (nonatomic, copy)NSString *rhChangeValueThreshold;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)readTHDatasWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
