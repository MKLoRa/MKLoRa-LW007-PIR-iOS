//
//  MKPIRTHSettingsHeaderView.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2022/2/16.
//  Copyright © 2022 aadyx2007@163.com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRTHSettingsHeaderViewModel : NSObject

@property (nonatomic, assign)BOOL isOn;

@property (nonatomic, copy)NSString *sampleRate;

@property (nonatomic, copy)NSString *temperature;

@property (nonatomic, copy)NSString *humidity;

@end

@protocol MKPIRTHSettingsHeaderViewDelegate <NSObject>

- (void)mk_pir_functionSwitchChanged:(BOOL)isOn;

- (void)mk_pir_sampleRateChanged:(NSString *)sampleRate;

@end

@interface MKPIRTHSettingsHeaderView : UIView

@property (nonatomic, strong)MKPIRTHSettingsHeaderViewModel *dataModel;

@property (nonatomic, weak)id <MKPIRTHSettingsHeaderViewDelegate>delegate;

@end

NS_ASSUME_NONNULL_END
