//
//  MKPIRSelftestV2Model.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2025/10/13.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRSelftestV2Model : NSObject

@property (nonatomic, assign)BOOL selftestError;

@property (nonatomic, copy)NSString *pcbaStatus;

/// 0-2.2v  20-3.2v
@property (nonatomic, assign)NSInteger voltageThreshold1;

@property (nonatomic, copy)NSString *sampleInterval1;

@property (nonatomic, copy)NSString *sampleTimes1;


- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
