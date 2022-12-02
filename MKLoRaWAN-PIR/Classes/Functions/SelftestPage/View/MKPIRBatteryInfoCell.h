//
//  MKPIRBatteryInfoCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRBatteryInfoCellModel : NSObject

@property (nonatomic, copy)NSString *workTimes;

@property (nonatomic, copy)NSString *advCount;

@property (nonatomic, copy)NSString *thSamplingCount;

@property (nonatomic, copy)NSString *loraPowerConsumption;

@property (nonatomic, copy)NSString *loraSendCount;

@property (nonatomic, copy)NSString *batteryPower;

@end

@interface MKPIRBatteryInfoCell : MKBaseCell

@property (nonatomic, strong)MKPIRBatteryInfoCellModel *dataModel;

+ (MKPIRBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
