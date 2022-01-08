//
//  MKPIRScanPageCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MKPIRScanPageCellDelegate <NSObject>

/// 连接按钮点击事件
/// @param index 当前cell的row
- (void)pir_scanCellConnectButtonPressed:(NSInteger)index;

@end

@class MKPIRScanPageModel;
@interface MKPIRScanPageCell : MKBaseCell

@property (nonatomic, strong)MKPIRScanPageModel *dataModel;

@property (nonatomic, weak)id <MKPIRScanPageCellDelegate>delegate;

+ (MKPIRScanPageCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
