//
//  MKPIRBatteryInfoForV2Cell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRBatteryInfoForV2CellModel : NSObject

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *thSamplingCount;

@property (nonatomic, copy)NSString *pirWorkTimes;

@property (nonatomic, copy)NSString *doorMagneticTriggerCloseTimes;

@property (nonatomic, copy)NSString *doorMagneticTriggerOpenTimes;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *batteryPower;

@end

@interface MKPIRBatteryInfoForV2Cell : MKBaseCell

@property (nonatomic, strong)MKPIRBatteryInfoForV2CellModel *dataModel;

+ (MKPIRBatteryInfoForV2Cell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
