//
//  MKPIRTHSettingsCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRTHSettingsCellModel : NSObject

@property (nonatomic, copy)NSString *temperature;

@property (nonatomic, copy)NSString *humidity;

@end

@interface MKPIRTHSettingsCell : MKBaseCell

@property (nonatomic, strong)MKPIRTHSettingsCellModel *dataModel;

+ (MKPIRTHSettingsCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
