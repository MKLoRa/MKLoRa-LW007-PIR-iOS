//
//  MKPIRConnectModel.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKPIRConnectModel : NSObject

+ (MKPIRConnectModel *)shared;

/// 设备连接的时候是否需要密码
@property (nonatomic, assign, readonly)BOOL hasPassword;

@property (nonatomic, copy, readonly)NSString *macAddress;

@property (nonatomic, assign, readonly)NSInteger deviceType;

/// 连接设备
/// @param peripheral 设备
/// @param deviceType 设备类型，目前00是旧版本，01为最新版本
/// @param password 密码
/// @param macAddress macAddress
/// @param sucBlock 成功回调
/// @param failedBlock 失败回调
- (void)connectDevice:(CBPeripheral *)peripheral
           deviceType:(NSString *)deviceType
             password:(NSString *)password
           macAddress:(NSString *)macAddress
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
