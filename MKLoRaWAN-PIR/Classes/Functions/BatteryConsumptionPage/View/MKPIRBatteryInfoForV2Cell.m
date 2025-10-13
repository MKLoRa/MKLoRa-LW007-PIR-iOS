//
//  MKPIRBatteryInfoForV2Cell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRBatteryInfoForV2Cell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKPIRBatteryInfoForV2CellModel
@end

@interface MKPIRBatteryInfoForV2Cell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *thSamplingCountLabel;

@property (nonatomic, strong)UILabel *pirWorkTimesLabel;

@property (nonatomic, strong)UILabel *doorTriggerCloseTimesLabel;

@property (nonatomic, strong)UILabel *doorTriggerOpenTimesLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@property (nonatomic, strong)UILabel *batteryPowerLabel;

@end

@implementation MKPIRBatteryInfoForV2Cell

+ (MKPIRBatteryInfoForV2Cell *)initCellWithTableView:(UITableView *)tableView {
    MKPIRBatteryInfoForV2Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKPIRBatteryInfoForV2CellIdenty"];
    if (!cell) {
        cell = [[MKPIRBatteryInfoForV2Cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKPIRBatteryInfoForV2CellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.thSamplingCountLabel];
        [self.contentView addSubview:self.pirWorkTimesLabel];
        [self.contentView addSubview:self.doorTriggerCloseTimesLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
        [self.contentView addSubview:self.batteryPowerLabel];
        [self.contentView addSubview:self.doorTriggerOpenTimesLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.workTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.msgLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.advCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.workTimeLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.thSamplingCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.pirWorkTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.thSamplingCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.doorTriggerCloseTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.pirWorkTimesLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.doorTriggerOpenTimesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.doorTriggerCloseTimesLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.doorTriggerOpenTimesLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.batteryPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKPIRBatteryInfoForV2CellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKPIRBatteryInfoForV2CellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.thSamplingCountLabel.text = [SafeStr(_dataModel.thSamplingCount) stringByAppendingString:@" times"];
    self.pirWorkTimesLabel.text = [SafeStr(_dataModel.pirWorkTimes) stringByAppendingString:@"s"];
    self.doorTriggerCloseTimesLabel.text = [SafeStr(_dataModel.doorMagneticTriggerCloseTimes) stringByAppendingString:@"s"];
    self.doorTriggerOpenTimesLabel.text = [SafeStr(_dataModel.doorMagneticTriggerOpenTimes) stringByAppendingString:@"s"];
    self.loraPowerLabel.text = [SafeStr(_dataModel.loraPowerConsumption) stringByAppendingString:@" mAS"];
    self.loraSendCountLabel.text = [SafeStr(_dataModel.loraSendCount) stringByAppendingString:@" times"];
    self.batteryPowerLabel.text = [NSString stringWithFormat:@"%.3f %@",([_dataModel.batteryPower integerValue] * 0.001),@"mAH"];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)workTimeLabel {
    if (!_workTimeLabel) {
        _workTimeLabel = [self fetchValueLabel];
    }
    return _workTimeLabel;
}

- (UILabel *)advCountLabel {
    if (!_advCountLabel) {
        _advCountLabel = [self fetchValueLabel];
    }
    return _advCountLabel;
}

- (UILabel *)thSamplingCountLabel {
    if (!_thSamplingCountLabel) {
        _thSamplingCountLabel = [self fetchValueLabel];
    }
    return _thSamplingCountLabel;
}

- (UILabel *)pirWorkTimesLabel {
    if (!_pirWorkTimesLabel) {
        _pirWorkTimesLabel = [self fetchValueLabel];
    }
    return _pirWorkTimesLabel;
}

- (UILabel *)doorTriggerCloseTimesLabel {
    if (!_doorTriggerCloseTimesLabel) {
        _doorTriggerCloseTimesLabel = [self fetchValueLabel];
    }
    return _doorTriggerCloseTimesLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)batteryPowerLabel {
    if (!_batteryPowerLabel) {
        _batteryPowerLabel = [self fetchValueLabel];
    }
    return _batteryPowerLabel;
}

- (UILabel *)doorTriggerOpenTimesLabel {
    if (!_doorTriggerOpenTimesLabel) {
        _doorTriggerOpenTimesLabel = [self fetchValueLabel];
    }
    return _doorTriggerOpenTimesLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end
