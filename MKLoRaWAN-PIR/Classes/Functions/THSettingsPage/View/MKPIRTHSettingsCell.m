//
//  MKPIRTHSettingsCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTHSettingsCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

@implementation MKPIRTHSettingsCellModel
@end

@interface MKPIRTHSettingsCell ()

@property (nonatomic, strong)UILabel *tempLabel;

@property (nonatomic, strong)UIImageView *tempIcon;

@property (nonatomic, strong)UILabel *tempValueLabel;

@property (nonatomic, strong)UILabel *humidityLabel;

@property (nonatomic, strong)UIImageView *humidityIcon;

@property (nonatomic, strong)UILabel *humidityValueLabel;

@end

@implementation MKPIRTHSettingsCell

+ (MKPIRTHSettingsCell *)initCellWithTableView:(UITableView *)tableView {
    MKPIRTHSettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKPIRTHSettingsCellIdenty"];
    if (!cell) {
        cell = [[MKPIRTHSettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKPIRTHSettingsCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.tempLabel];
        [self.contentView addSubview:self.tempIcon];
        [self.contentView addSubview:self.tempValueLabel];
        [self.contentView addSubview:self.humidityLabel];
        [self.contentView addSubview:self.humidityIcon];
        [self.contentView addSubview:self.humidityValueLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(95.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.tempIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.tempValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.humidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempValueLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(70.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.humidityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.humidityLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.humidityValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.humidityIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
}

#pragma mark - setter
- (void)setDataModel:(MKPIRTHSettingsCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKPIRTHSettingsCellModel.class]) {
        return;
    }
    self.tempValueLabel.text = [SafeStr(_dataModel.temperature) stringByAppendingString:@"°C"];
    self.humidityValueLabel.text = [SafeStr(_dataModel.humidity) stringByAppendingString:@"%RH"];
}

#pragma mark - getter
- (UILabel *)tempLabel {
    if (!_tempLabel) {
        _tempLabel = [[UILabel alloc] init];
        _tempLabel.textAlignment = NSTextAlignmentLeft;
        _tempLabel.textColor = DEFAULT_TEXT_COLOR;
        _tempLabel.font = MKFont(15.f);
        _tempLabel.text = @"Temperature:";
    }
    return _tempLabel;
}

- (UIImageView *)tempIcon {
    if (!_tempIcon) {
        _tempIcon = [[UIImageView alloc] init];
        _tempIcon.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsCell", @"pir_scan_temperature.png");
    }
    return _tempIcon;
}

- (UILabel *)tempValueLabel {
    if (!_tempValueLabel) {
        _tempValueLabel = [[UILabel alloc] init];
        _tempValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _tempValueLabel.textAlignment = NSTextAlignmentLeft;
        _tempValueLabel.font = MKFont(11.f);
    }
    return _tempValueLabel;
}

- (UILabel *)humidityLabel {
    if (!_humidityLabel) {
        _humidityLabel = [[UILabel alloc] init];
        _humidityLabel.textAlignment = NSTextAlignmentLeft;
        _humidityLabel.textColor = DEFAULT_TEXT_COLOR;
        _humidityLabel.font = MKFont(15.f);
        _humidityLabel.text = @"Humidity:";
    }
    return _humidityLabel;
}

- (UIImageView *)humidityIcon {
    if (!_humidityIcon) {
        _humidityIcon = [[UIImageView alloc] init];
        _humidityIcon.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsCell", @"pir_scan_humidity.png");
    }
    return _humidityIcon;
}

- (UILabel *)humidityValueLabel {
    if (!_humidityValueLabel) {
        _humidityValueLabel = [[UILabel alloc] init];
        _humidityValueLabel.textColor = DEFAULT_TEXT_COLOR;
        _humidityValueLabel.textAlignment = NSTextAlignmentLeft;
        _humidityValueLabel.font = MKFont(11.f);
    }
    return _humidityValueLabel;
}

@end
