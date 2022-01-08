//
//  MKPIRPirSettingsPickerCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRPirSettingsPickerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

/// 0:Low 1:Medium 2:High
@property (nonatomic, assign)NSInteger valueIndex;

@end

@protocol MKPIRPirSettingsPickerCellDelegate <NSObject>

- (void)pir_pickerValueChanged:(NSInteger)index value:(NSInteger)value;

@end

@interface MKPIRPirSettingsPickerCell : MKBaseCell

@property (nonatomic, weak)id <MKPIRPirSettingsPickerCellDelegate>delegate;

@property (nonatomic, strong)MKPIRPirSettingsPickerCellModel *dataModel;

+ (MKPIRPirSettingsPickerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
