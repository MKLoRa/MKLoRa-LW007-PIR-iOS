//
//  MKPIRLoRaSettingModel.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/28.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRLoRaSettingConfigModel : NSObject

@property (nonatomic, assign)BOOL supportClassType;

@property (nonatomic, assign)BOOL supportMessageType;

@property (nonatomic, assign)BOOL supportServerPlatform;

@property (nonatomic, assign)BOOL supportMaxRetransmissionTimes;

@end

@interface MKPIRLoRaSettingModel : NSObject

@property (nonatomic, strong, readonly)MKPIRLoRaSettingConfigModel *configModel;

//1:ABP,2:OTAA
@property (nonatomic, assign)NSInteger modem;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *devEUI;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *appEUI;

//OTAA模式
@property (nonatomic, copy)NSString *appKey;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *devAddr;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *nwkSKey;

//OTAA模式/ABP模式
@property (nonatomic, copy)NSString *appSKey;

/**
 对于platform=0
 0:AS923
 1:AU915
 2:CN470
 3:CN779
 4:EU433
 5:EU868
 6:KR920
 7:IN865
 8:US915
 9:RU864
 10:AS923-1
 11:AS923-2
 12:AS923-3
 13:AS923-4
 
 对于platform=1
 0:AS923,
 1:EU868
 2:US915 FSB1
 3:US915 FSB2
 4:AU915 FSB1
 5:AU915 FSB2
 */
@property (nonatomic, assign)NSInteger region;

/// 0:非确认帧，1:确认帧
@property (nonatomic, assign)NSInteger messageType;

/// 0：classA,1:classC,
@property (nonatomic, assign)NSInteger classType;

/// 0:Third Party NS    1:MOKO IoT DM
@property (nonatomic, assign)NSInteger platform;

/// Gateway ID
@property (nonatomic, copy)NSString *gatewayEUI;

/// 底部是否需要高级选项
@property (nonatomic, assign)BOOL needAdvanceSetting;

/// 底部高级选项是否打开(needAdvanceSetting == YES情况下)
@property (nonatomic, assign)BOOL advancedStatus;

/// 当频段选择为US915, AU915和CN470时，CH设置项显示。US915默认显示值为8-15；AU915默认显示值为8-15；CN470默认显示值为0-7.
@property (nonatomic, assign)NSInteger CHL;

/// 当频段选择为US915, AU915和CN470时，CH设置项显示。US915默认显示值为8-15；AU915默认显示值为8-15；CN470默认显示值为0-7.
@property (nonatomic, assign)NSInteger CHH;

//EU868,CN779, EU433,RU864
@property (nonatomic, assign)BOOL dutyIsOn;

/// It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864
/// 0~15
@property (nonatomic, assign)NSInteger join;

@property (nonatomic, assign)BOOL adrIsOn;

/// 1/2         目前不支持
@property (nonatomic, assign)NSInteger transmissions;

/// 0~7
@property (nonatomic, assign)NSInteger retransmission;

@property (nonatomic, assign)NSInteger DRL;

@property (nonatomic, assign)NSInteger DRH;

/// 1~255        目前不支持
@property (nonatomic, copy)NSString *ackLimit;

/// 1~255        目前不支持
@property (nonatomic, copy)NSString *ackDelay;

@property (nonatomic, assign)BOOL eu868SignleChannelStatus;

/// 0: 868.1MHz 1:868.3MHz 2:868.5MHz
@property (nonatomic, assign)NSInteger eu868SignleChannel;

- (void)readDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

- (void)configDataWithSucBlock:(void (^)(void))sucBlock failedBlock:(void (^)(NSError *error))failedBlock;

/// 用户主动选择了region，底部高级设置需要按照需求设置为默认值
- (void)configAdvanceSettingDefaultParams;

- (NSInteger)currentRegion;

- (NSArray <NSString *>*)RegionList;
- (NSArray <NSString *>*)CHLValueList;
- (NSArray <NSString *>*)CHHValueList;
- (NSArray <NSString *>*)DRValueList;
- (NSArray <NSString *>*)DRLValueList;
- (NSArray <NSString *>*)DRHValueList;

@end

NS_ASSUME_NONNULL_END
