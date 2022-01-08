//
//  MKPIRScanPageModel.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class CBPeripheral;
@interface MKPIRScanPageModel : NSObject

/**
 当前model所在的row
 */
@property (nonatomic, assign)NSInteger index;

@property (nonatomic, assign)NSInteger rssi;

@property (nonatomic, strong)CBPeripheral *peripheral;

@property (nonatomic, copy)NSString *deviceName;

@property (nonatomic, copy)NSString *macAddress;

/// PIR传感器灵敏度.00:低灵敏度   01:中灵敏度     10:高灵敏度    11:未使能
@property (nonatomic, copy)NSString *pirSensitivity;

/// PIR感应状态   00:无人    01:有人      11:PIR未使能
@property (nonatomic, copy)NSString *pirInductionState;

/// 门磁感应状态   00:门关   01:门开    11:门磁未使能
@property (nonatomic, copy)NSString *roorSensorState;

/// 低电状态
@property (nonatomic, assign)BOOL lowPower;

/// 低电报警功能
@property (nonatomic, assign)BOOL alarm;

/// 温度，FFFF表示未启用
@property (nonatomic, copy)NSString *temperature;

/// 湿度，FFFF表示未启用
@property (nonatomic, copy)NSString *humidity;

/// 是否可连接
@property (nonatomic, assign)BOOL connectable;

@property (nonatomic, strong)NSNumber *txPower;

@property (nonatomic, copy)NSString *battery;

/// 是否需要密码连接
@property (nonatomic, assign)BOOL needPassword;

/// cell上面显示的时间
@property (nonatomic, copy)NSString *scanTime;

/**
 上一次扫描到的时间
 */
@property (nonatomic, copy)NSString *lastScanDate;

@end

NS_ASSUME_NONNULL_END
