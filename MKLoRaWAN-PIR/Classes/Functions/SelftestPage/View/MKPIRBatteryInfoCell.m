//
//  MKPIRBatteryInfoCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/5/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRBatteryInfoCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "UIView+MKAdd.h"

#import "MKCustomUIAdopter.h"

@implementation MKPIRBatteryInfoCellModel
@end

@interface MKPIRBatteryInfoCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UILabel *workTimeLabel;

@property (nonatomic, strong)UILabel *advCountLabel;

@property (nonatomic, strong)UILabel *thCountLabel;

@property (nonatomic, strong)UILabel *loraPowerLabel;

@property (nonatomic, strong)UILabel *loraSendCountLabel;

@property (nonatomic, strong)UILabel *batteryPowerLabel;

@end

@implementation MKPIRBatteryInfoCell

+ (MKPIRBatteryInfoCell *)initCellWithTableView:(UITableView *)tableView {
    MKPIRBatteryInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKPIRBatteryInfoCellIdenty"];
    if (!cell) {
        cell = [[MKPIRBatteryInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKPIRBatteryInfoCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.workTimeLabel];
        [self.contentView addSubview:self.advCountLabel];
        [self.contentView addSubview:self.thCountLabel];
        [self.contentView addSubview:self.loraPowerLabel];
        [self.contentView addSubview:self.loraSendCountLabel];
        [self.contentView addSubview:self.batteryPowerLabel];
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
    [self.thCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.advCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.thCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.loraSendCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraPowerLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.batteryPowerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.top.mas_equalTo(self.loraSendCountLabel.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKPIRBatteryInfoCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKPIRBatteryInfoCellModel.class]) {
        return;
    }
    self.workTimeLabel.text = [SafeStr(_dataModel.workTimes) stringByAppendingString:@" s"];
    self.advCountLabel.text = [SafeStr(_dataModel.advCount) stringByAppendingString:@" times"];
    self.thCountLabel.text = [SafeStr(_dataModel.thSamplingCount) stringByAppendingString:@" times"];
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
        _msgLabel.text = @"Battery information:";
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

- (UILabel *)thCountLabel {
    if (!_thCountLabel) {
        _thCountLabel = [self fetchValueLabel];
    }
    return _thCountLabel;
}

- (UILabel *)loraPowerLabel {
    if (!_loraPowerLabel) {
        _loraPowerLabel = [self fetchValueLabel];
    }
    return _loraPowerLabel;
}

- (UILabel *)loraSendCountLabel {
    if (!_loraSendCountLabel) {
        _loraSendCountLabel = [self fetchValueLabel];
    }
    return _loraSendCountLabel;
}

- (UILabel *)batteryPowerLabel {
    if (!_batteryPowerLabel) {
        _batteryPowerLabel = [self fetchValueLabel];
    }
    return _batteryPowerLabel;
}

- (UILabel *)fetchValueLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = DEFAULT_TEXT_COLOR;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = MKFont(13.f);
    return label;
}

@end
