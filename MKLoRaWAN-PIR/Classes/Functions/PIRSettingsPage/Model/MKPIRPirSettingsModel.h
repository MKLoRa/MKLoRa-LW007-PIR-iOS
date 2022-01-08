//
//  MKPIRPirSettingsModel.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRPirSettingsModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *interval;

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger pirSensitivity;

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger pirDelayTime;

/// 是否检测到人
@property (nonatomic, assign)BOOL detected;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
