//
//  MKPIRTHAlarmCell.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTHAlarmCell.h"

#import "Masonry.h"

#import "MKMacroDefines.h"
#import "NSString+MKAdd.h"

#import "MKTextField.h"
#import "MKCustomUIAdopter.h"

@implementation MKPIRTHAlarmCellModel
@end

@interface MKPIRTHAlarmCell ()

@property (nonatomic, strong)UILabel *msgLabel;

@property (nonatomic, strong)MKTextField *textField;

@property (nonatomic, strong)UILabel *unitLabel;

@end

@implementation MKPIRTHAlarmCell

+ (MKPIRTHAlarmCell *)initCellWithTableView:(UITableView *)tableView {
    MKPIRTHAlarmCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MKPIRTHAlarmCellIdenty"];
    if (!cell) {
        cell = [[MKPIRTHAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MKPIRTHAlarmCellIdenty"];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.msgLabel];
        [self.contentView addSubview:self.textField];
        [self.contentView addSubview:self.unitLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15.f);
        make.width.mas_equalTo(90.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(15.f).lineHeight);
    }];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15.f);
        make.width.mas_equalTo(30.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(MKFont(13.f).lineHeight);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_centerX).mas_offset(5.f);
        make.right.mas_equalTo(self.unitLabel.mas_left).mas_offset(-5.f);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.height.mas_equalTo(30.f);
    }];
}

#pragma mark - event method
- (void)textFieldValueChanged:(NSString *)text {
    if (!ValidStr(text)) {
        self.textField.text = @"";
        if ([self.delegate respondsToSelector:@selector(pir_tempThresholdAlarmValueChanged:value:)]) {
            [self.delegate pir_tempThresholdAlarmValueChanged:self.dataModel.index value:@""];
        }
        return;
    }
    
    NSString *lastChar = [text substringWithRange:NSMakeRange(text.length - 1, 1)];
    if (![lastChar isEqualToString:@"-"] && ![lastChar regularExpressions:isRealNumbers]) {
        //输入无效字符
        self.textField.text = [text substringWithRange:NSMakeRange(0, text.length - 1)];
        return;
    }
    if (text.length > 3) {
        //字符数大于3
        self.textField.text = [text substringWithRange:NSMakeRange(0, text.length - 1)];
    }else {
        self.textField.text = text;
        if ([self.delegate respondsToSelector:@selector(pir_tempThresholdAlarmValueChanged:value:)]) {
            [self.delegate pir_tempThresholdAlarmValueChanged:self.dataModel.index value:text];
        }
    }
}

#pragma mark - setter
- (void)setDataModel:(MKPIRTHAlarmCellModel *)dataModel {
    _dataModel = nil;
    _dataModel = dataModel;
    if (!_dataModel || ![_dataModel isKindOfClass:MKPIRTHAlarmCellModel.class]) {
        return;
    }
    self.msgLabel.text = SafeStr(_dataModel.msg);
    self.textField.text = SafeStr(_dataModel.textValue);
}

#pragma mark - getter
- (UILabel *)msgLabel {
    if (!_msgLabel) {
        _msgLabel = [[UILabel alloc] init];
        _msgLabel.textAlignment = NSTextAlignmentLeft;
        _msgLabel.textColor = DEFAULT_TEXT_COLOR;
        _msgLabel.font = MKFont(15.f);
    }
    return _msgLabel;
}

- (UILabel *)unitLabel {
    if (!_unitLabel) {
        _unitLabel = [[UILabel alloc] init];
        _unitLabel.textAlignment = NSTextAlignmentRight;
        _unitLabel.textColor = DEFAULT_TEXT_COLOR;
        _unitLabel.font = MKFont(13.f);
        _unitLabel.text = @"℃";
    }
    return _unitLabel;
}

- (MKTextField *)textField {
    if (!_textField) {
        _textField = [MKCustomUIAdopter customNormalTextFieldWithText:@"" placeHolder:@"-30~60" textType:mk_normal];
        @weakify(self);
        _textField.textChangedBlock = ^(NSString * _Nonnull text) {
            @strongify(self);
            [self textFieldValueChanged:text];
        };
    }
    return _textField;
}

@end
