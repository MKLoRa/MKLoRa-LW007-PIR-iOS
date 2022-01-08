//
//  Target_LoRaWANPIR_Module.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "Target_LoRaWANPIR_Module.h"

#import "MKPIRScanController.h"

#import "MKPIRAboutController.h"

@implementation Target_LoRaWANPIR_Module

/// 扫描页面
- (UIViewController *)Action_LoRaWANPIR_Module_ScanController:(NSDictionary *)params {
    return [[MKPIRScanController alloc] init];
}

/// 关于页面
- (UIViewController *)Action_LoRaWANPIR_Module_AboutController:(NSDictionary *)params {
    return [[MKPIRAboutController alloc] init];
}

@end
