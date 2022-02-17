//
//  MKPIRTHSettingsHeaderView.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2022/2/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTHSettingsHeaderView.h"

#import "Masonry.h"

#import "MKMacroDefines.h"

#import "MKTextField.h"

@implementation MKPIRTHSettingsHeaderViewModel

- (void)setIsOn:(BOOL)isOn {
    _isOn = isOn;
}

@end

@interface MKPIRTHSettingsHeaderSwitchView : UIView

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)UIButton *stateButton;

@property (nonatomic, strong)UIView *lineView;

@end

@implementation MKPIRTHSettingsHeaderSwitchView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE_MACROS;
        [self addSubview:self.msgLabel];
        [self addSubview:self.stateButton];
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.stateButton.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.stateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(40.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Function Switch";
    }
    return _msgLabel;
}

- (UIButton *)stateButton {
    if (!_stateButton) {
        _stateButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _stateButton;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView;
}

@end

@interface MKPIRTHSettingsHeaderTextFieldView : UIView

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@property (nonatomic, strong)UIView *lineView;

@end

@implementation MKPIRTHSettingsHeaderTextFieldView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE_MACROS;
        [self addSubview:self.msgLabel];
        [self addSubview:self.textField];
        [self addSubview:self.unitLabel];
        [self addSubview:self.lineView];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.width.mas_equalTo(80.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(self.textField.mas_left).mas_offset(-15.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.right.mas_equalTo(-15.f);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(CUTTING_LINE_HEIGHT);
    }];
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.font = MKFont(15.f);
        _msgLabel.text = @"Sample Rate";
    }
    return _msgLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [[MKTextField alloc] initWithTextFieldType:mk_realNumberOnly];
        _textField.placeholder = @"1 ~ 60";
        _textField.maxLength = 2;
        
        _textField.layer.masksToBounds = YES;
        _textField.layer.borderColor = CUTTING_LINE_COLOR.CGColor;
        _textField.layer.borderWidth = 0.5f;
        _textField.layer.cornerRadius = 5.f;
    }
    return _textField;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.textAlignment = NSTextAlignmentLeft;
        _unitLabel.font = MKFont(13.f);
        _unitLabel.text = @"S";
    }
    return _unitLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = CUTTING_LINE_COLOR;
    }
    return _lineView;
}

@end

@interface MKPIRTHSettingsHeaderLabelView : UIView

@property (nonatomic, strong)UILabel *tempLabel;

@property (nonatomic, strong)UIImageView *tempIcon;

@property (nonatomic, strong)UILabel *tempValueLabel;

@property (nonatomic, strong)UILabel *humidityLabel;

@property (nonatomic, strong)UIImageView *humidityIcon;

@property (nonatomic, strong)UILabel *humidityValueLabel;

@end

@implementation MKPIRTHSettingsHeaderLabelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = COLOR_WHITE_MACROS;
        [self addSubview:self.tempLabel];
        [self addSubview:self.tempIcon];
        [self addSubview:self.tempValueLabel];
        [self addSubview:self.humidityLabel];
        [self addSubview:self.humidityIcon];
        [self addSubview:self.humidityValueLabel];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(95.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.tempIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.tempValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempIcon.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(60.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
    [self.humidityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tempValueLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(70.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.humidityIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.humidityLabel.mas_right).mas_offset(5.f);
        make.width.mas_equalTo(20.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(20.f);
    }];
    [self.humidityValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.humidityIcon.mas_right).mas_offset(5.f);
        make.right.mas_equalTo(-15.f);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(MKFont(11.f).lineHeight);
    }];
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
        _tempIcon.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderLabelView", @"pir_scan_temperature.png");
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
        _humidityIcon.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderLabelView", @"pir_scan_humidity.png");
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

@interface MKPIRTHSettingsHeaderView ()

@property (nonatomic, strong)MKPIRTHSettingsHeaderSwitchView *switchView;

@property (nonatomic, strong)MKPIRTHSettingsHeaderTextFieldView *textFieldView;

@property (nonatomic, strong)MKPIRTHSettingsHeaderLabelView *labelView;

@end

@implementation MKPIRTHSettingsHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = RGBCOLOR(242, 242, 242);
        [self addSubview:self.switchView];
        [self addSubview:self.textFieldView];
        [self addSubview:self.labelView];
    }
    return self;
}

#pragma mark - super method
- (void)layoutSubviews {
    [super layoutSubviews];
    [self.switchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(10.f);
        make.height.mas_equalTo(44.f);
    }];
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.switchView.mas_bottom);
        make.height.mas_equalTo(44.f);
    }];
    [self.labelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.textFieldView.mas_bottom).mas_offset(10.f);
        make.height.mas_equalTo(44.f);
    }];
}

#pragma mark - event method
- (void)functionSwitchChanged {
    self.switchView.stateButton.selected = !self.switchView.stateButton.selected;
    UIImage *stateIcon = (self.switchView.stateButton.selected ? LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderView", @"pir_switchSelectedIcon.png") : LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderView", @"pir_switchUnselectedIcon.png"));
    [self.switchView.stateButton setImage:stateIcon forState:UIControlStateNormal];
    if ([self.delegate respondsToSelector:@selector(mk_pir_functionSwitchChanged:)]) {
        [self.delegate mk_pir_functionSwitchChanged:self.switchView.stateButton.selected];
    }
}

#pragma mark - setter
- (void)setDataModel:(MKPIRTHSettingsHeaderViewModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKPIRTHSettingsHeaderViewModel.class]) {
        return;
    }
    //Function Switch
    self.switchView.stateButton.selected = _dataModel.isOn;
    UIImage *stateIcon = (_dataModel.isOn ? LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderView", @"pir_switchSelectedIcon.png") : LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsHeaderView", @"pir_switchUnselectedIcon.png"));
    [self.switchView.stateButton setImage:stateIcon forState:UIControlStateNormal];
    //Sample Rate
    self.textFieldView.textField.text = SafeStr(_dataModel.sampleRate);
    //Temp Humidity
    self.labelView.tempValueLabel.text = [SafeStr(_dataModel.temperature) stringByAppendingString:@"°C"];
    self.labelView.humidityValueLabel.text = [SafeStr(_dataModel.humidity) stringByAppendingString:@"%RH"];
}

#pragma mark - getter
- (MKPIRTHSettingsHeaderSwitchView *)switchView {
    if (!_switchView) {
        _switchView = [[MKPIRTHSettingsHeaderSwitchView alloc] init];
        [_switchView.stateButton addTarget:self
                                    action:@selector(functionSwitchChanged)
                          forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchView;
}

- (MKPIRTHSettingsHeaderTextFieldView *)textFieldView {
    if (!_textFieldView) {
        _textFieldView = [[MKPIRTHSettingsHeaderTextFieldView alloc] init];
        @weakify(self);
        _textFieldView.textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            if ([self.delegate respondsToSelector:@selector(mk_pir_sampleRateChanged:)]) {
                [self.delegate mk_pir_sampleRateChanged:text];
            }
        };
    }
    return _textFieldView;
}

- (MKPIRTHSettingsHeaderLabelView *)labelView {
    if (!_labelView) {
        _labelView = [[MKPIRTHSettingsHeaderLabelView alloc] init];
    }
    return _labelView;
}

@end
