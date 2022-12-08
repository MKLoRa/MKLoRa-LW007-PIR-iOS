//
//  MKPIRTabBarController.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/10/21.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTabBarController.h"

#import "MKMacroDefines.h"
#import "MKBaseNavigationController.h"

#import "MKAlertController.h"

#import "MKPIRLoRaController.h"
#import "MKPIRGeneralController.h"
#import "MKPIRBleSettingsController.h"
#import "MKPIRDeviceSettingController.h"

#import "MKPIRCentralManager.h"

@interface MKPIRTabBarController ()

/// 当触发
/// 01:表示连接成功后，1分钟内没有通过密码验证（未输入密码，或者连续输入密码错误）认为超时，返回结果， 然后断开连接
/// 02:修改密码成功后，返回结果，断开连接
/// 03:连续三分钟设备没有数据通信断开，返回结果，断开连接
/// 04:重启设备，就不需要显示断开连接的弹窗了，只需要显示对应的弹窗
/// 05:恢复出厂设置
@property (nonatomic, assign)BOOL disconnectType;

/// 产品要求，进入debugger模式之后，设备断开连接也要停留在当前页面，只有退出debugger模式才进行正常模式通信
@property (nonatomic, assign)BOOL isDebugger;

@end

@implementation MKPIRTabBarController

- (void)dealloc {
    NSLog(@"MKPIRTabBarController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (![[self.navigationController viewControllers] containsObject:self]){
        [[MKPIRCentralManager shared] disconnect];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubPages];
    [self addNotifications];
}

- (void)addNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gotoScanPage)
                                                 name:@"mk_pir_popToRootViewControllerNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dfuUpdateComplete)
                                                 name:@"mk_pir_centralDeallocNotification"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(centralManagerStateChanged)
                                                 name:mk_pir_centralManagerStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(disconnectTypeNotification:)
                                                 name:mk_pir_deviceDisconnectTypeNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceConnectStateChanged)
                                                 name:mk_pir_peripheralConnectStateChangedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceEnterDebuggerMode)
                                                 name:@"mk_pir_startDebuggerMode"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceStopDebuggerMode)
                                                 name:@"mk_pir_stopDebuggerMode"
                                               object:nil];
}

#pragma mark - notes
- (void)gotoScanPage {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_pir_needResetScanDelegate:)]) {
            [self.delegate mk_pir_needResetScanDelegate:NO];
        }
    }];
}

- (void)dfuUpdateComplete {
    @weakify(self);
    [self dismissViewControllerAnimated:YES completion:^{
        @strongify(self);
        if ([self.delegate respondsToSelector:@selector(mk_pir_needResetScanDelegate:)]) {
            [self.delegate mk_pir_needResetScanDelegate:YES];
        }
    }];
}

- (void)disconnectTypeNotification:(NSNotification *)note {
    NSString *type = note.userInfo[@"type"];
    //02:修改密码成功后，返回结果，断开连接
    //03:连续两分钟设备没有数据通信断开，返回结果，断开连接
    //04:重启设备
    //05:恢复出厂设置
    self.disconnectType = YES;
    if ([type isEqualToString:@"02"]) {
        [self showAlertWithMsg:@"Password changed successfully! Please reconnect the device." title:@"Change Password"];
        return;
    }
    if ([type isEqualToString:@"03"]) {
        [self showAlertWithMsg:@"No data communication for 3 minutes, the device is disconnected." title:@""];
        return;
    }
    if ([type isEqualToString:@"04"]) {
        [self showAlertWithMsg:@"Reboot successfully!Please reconnect the device." title:@"Dismiss"];
        return;
    }
    if ([type isEqualToString:@"05"]) {
        [self showAlertWithMsg:@"Factory reset successfully!Please reconnect the device." title:@"Factory Reset"];
        return;
    }
    //异常断开
    NSString *msg = [NSString stringWithFormat:@"Device disconnected for unknown reason.(%@)",type];
    [self showAlertWithMsg:msg title:@"Dismiss"];
}

- (void)centralManagerStateChanged{
    if (self.disconnectType) {
        return;
    }
    if ([MKPIRCentralManager shared].centralStatus != mk_pir_centralManagerStatusEnable) {
        [self showAlertWithMsg:@"The current system of bluetooth is not available!" title:@"Dismiss"];
    }
}

- (void)deviceConnectStateChanged {
     if (self.disconnectType) {
        return;
    }
    [self showAlertWithMsg:@"The device is disconnected." title:@"Dismiss"];
    return;
}

- (void)deviceEnterDebuggerMode {
    self.isDebugger = YES;
}

- (void)deviceStopDebuggerMode {
    self.isDebugger = NO;
}

#pragma mark - private method
- (void)showAlertWithMsg:(NSString *)msg title:(NSString *)title{
    MKAlertController *alertController = [MKAlertController alertControllerWithTitle:title
                                                                             message:msg
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    @weakify(self);
    UIAlertAction *moreAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
        if (!self.isDebugger) {
            [self gotoScanPage];
        }
    }];
    [alertController addAction:moreAction];
    
    //让setting页面推出的alert消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_pir_needDismissAlert" object:nil];
    //让所有MKPickView消失
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mk_customUIModule_dismissPickView" object:nil];
    [self performSelector:@selector(presentAlert:) withObject:alertController afterDelay:1.2f];
}

- (void)presentAlert:(UIAlertController *)alert {
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)loadSubPages {
    MKPIRLoRaController *loraPage = [[MKPIRLoRaController alloc] init];
    loraPage.tabBarItem.title = @"LORA";
    loraPage.tabBarItem.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_lora_tabBarUnselected.png");
    loraPage.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_lora_tabBarSelected.png");
    MKBaseNavigationController *advNav = [[MKBaseNavigationController alloc] initWithRootViewController:loraPage];

    MKPIRGeneralController *setting = [[MKPIRGeneralController alloc] init];
    setting.tabBarItem.title = @"GENERAL";
    setting.tabBarItem.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_setting_tabBarUnselected.png");
    setting.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_setting_tabBarSelected.png");
    MKBaseNavigationController *settingPage = [[MKBaseNavigationController alloc] initWithRootViewController:setting];
    
    MKPIRBleSettingsController *bleSettingPage = [[MKPIRBleSettingsController alloc] init];
    bleSettingPage.tabBarItem.title = @"BLUETOOTH";
    bleSettingPage.tabBarItem.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_bleSettings_tabBarUnselected.png");
    bleSettingPage.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_bleSettings_tabBarSelected.png");
    MKBaseNavigationController *bleNav = [[MKBaseNavigationController alloc] initWithRootViewController:bleSettingPage];

    
    MKPIRDeviceSettingController *deviceInfo = [[MKPIRDeviceSettingController alloc] init];
    deviceInfo.tabBarItem.title = @"DEVICE";
    deviceInfo.tabBarItem.image = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_device_tabBarUnselected.png");
    deviceInfo.tabBarItem.selectedImage = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTabBarController", @"pir_device_tabBarSelected.png");
    MKBaseNavigationController *deviceInfoPage = [[MKBaseNavigationController alloc] initWithRootViewController:deviceInfo];
    
    self.viewControllers = @[advNav,settingPage,bleNav,deviceInfoPage];
}

@end
