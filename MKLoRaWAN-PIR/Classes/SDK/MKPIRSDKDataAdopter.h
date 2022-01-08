//
//  MKPIRSDKDataAdopter.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MKPIRSDKNormalDefines.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRSDKDataAdopter : NSObject

+ (NSString *)lorawanRegionString:(mk_pir_loraWanRegion)region;

+ (NSString *)fetchTxPower:(mk_pir_txPower)txPower;

/// 实际值转换为0dBm、4dBm等
/// @param content content
+ (NSString *)fetchTxPowerValueString:(NSString *)content;

@end

NS_ASSUME_NONNULL_END
