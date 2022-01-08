//
//  MKPIRTHAlarmCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRTHAlarmCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *msg;

@property (nonatomic, copy)NSString *textValue;

@end

@protocol MKPIRTHAlarmCellDelegate <NSObject>

- (void)pir_tempThresholdAlarmValueChanged:(NSInteger)index value:(NSString *)value;

@end

@interface MKPIRTHAlarmCell : MKBaseCell

@property (nonatomic, weak)id <MKPIRTHAlarmCellDelegate>delegate;

@property (nonatomic, strong)MKPIRTHAlarmCellModel *dataModel;

+ (MKPIRTHAlarmCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
