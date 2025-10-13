//
//  MKADSelftestVoltageThresholdCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2025/4/27.
//  Copyright © 2025 lovexiaoxia. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRSelftestVoltageThresholdCellModel : NSObject

/// 当前cell所在的index
@property (nonatomic, assign)NSInteger index;

/// 左侧显示的msg
@property (nonatomic, copy)NSString *msg;

/// 0~20
@property (nonatomic, assign)NSInteger threshold;

@end

@protocol MKPIRSelftestVoltageThresholdCellDelegate <NSObject>

- (void)pir_selftestVoltageThresholdCell_thresholdChanged:(NSInteger)index threshold:(NSInteger)threshold;

@end

@interface MKPIRSelftestVoltageThresholdCell : MKBaseCell

@property (nonatomic, strong)MKPIRSelftestVoltageThresholdCellModel *dataModel;

@property (nonatomic, weak)id <MKPIRSelftestVoltageThresholdCellDelegate>delegate;

+ (MKPIRSelftestVoltageThresholdCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
