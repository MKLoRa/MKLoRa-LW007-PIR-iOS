//
//  MKPIRLoRaSettingAccountCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2025/3/3.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRLoRaSettingAccountCellModel : NSObject

@property (nonatomic, copy)NSString *account;

@end

@protocol MKPIRLoRaSettingAccountCellDelegate <NSObject>

- (void)pir_loRaSettingAccountCell_logoutBtnPressed;

@end

@interface MKPIRLoRaSettingAccountCell : MKBaseCell

@property (nonatomic, strong)MKPIRLoRaSettingAccountCellModel *dataModel;

@property (nonatomic, weak)id <MKPIRLoRaSettingAccountCellDelegate>delegate;

+ (MKPIRLoRaSettingAccountCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
