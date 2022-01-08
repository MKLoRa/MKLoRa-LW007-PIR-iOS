//
//  MKPIRSDKDataAdopter.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRSDKDataAdopter.h"

#import "MKBLEBaseSDKDefines.h"
#import "MKBLEBaseSDKAdopter.h"

@implementation MKPIRSDKDataAdopter

+ (NSString *)lorawanRegionString:(mk_pir_loraWanRegion)region {
    switch (region) {
        case mk_pir_loraWanRegionAS923:
            return @"00";
        case mk_pir_loraWanRegionAU915:
            return @"01";
        case mk_pir_loraWanRegionCN470:
            return @"02";
        case mk_pir_loraWanRegionCN779:
            return @"03";
        case mk_pir_loraWanRegionEU433:
            return @"04";
        case mk_pir_loraWanRegionEU868:
            return @"05";
        case mk_pir_loraWanRegionKR920:
            return @"06";
        case mk_pir_loraWanRegionIN865:
            return @"07";
        case mk_pir_loraWanRegionUS915:
            return @"08";
        case mk_pir_loraWanRegionRU864:
            return @"09";
    }
}

+ (NSString *)fetchTxPower:(mk_pir_txPower)txPower {
    switch (txPower) {
        case mk_pir_txPower4dBm:
            return @"04";
            
        case mk_pir_txPower3dBm:
            return @"03";
            
        case mk_pir_txPower0dBm:
            return @"00";
            
        case mk_pir_txPowerNeg4dBm:
            return @"fc";
            
        case mk_pir_txPowerNeg8dBm:
            return @"f8";
            
        case mk_pir_txPowerNeg12dBm:
            return @"f4";
            
        case mk_pir_txPowerNeg16dBm:
            return @"f0";
            
        case mk_pir_txPowerNeg20dBm:
            return @"ec";
            
        case mk_pir_txPowerNeg40dBm:
            return @"d8";
    }
}

+ (NSString *)fetchTxPowerValueString:(NSString *)content {
    if ([content isEqualToString:@"08"]) {
        return @"8dBm";
    }
    if ([content isEqualToString:@"07"]) {
        return @"7dBm";
    }
    if ([content isEqualToString:@"06"]) {
        return @"6dBm";
    }
    if ([content isEqualToString:@"05"]) {
        return @"5dBm";
    }
    if ([content isEqualToString:@"04"]) {
        return @"4dBm";
    }
    if ([content isEqualToString:@"03"]) {
        return @"3dBm";
    }
    if ([content isEqualToString:@"02"]) {
        return @"2dBm";
    }
    if ([content isEqualToString:@"00"]) {
        return @"0dBm";
    }
    if ([content isEqualToString:@"fc"]) {
        return @"-4dBm";
    }
    if ([content isEqualToString:@"f8"]) {
        return @"-8dBm";
    }
    if ([content isEqualToString:@"f4"]) {
        return @"-12dBm";
    }
    if ([content isEqualToString:@"f0"]) {
        return @"-16dBm";
    }
    if ([content isEqualToString:@"ec"]) {
        return @"-20dBm";
    }
    if ([content isEqualToString:@"d8"]) {
        return @"-40dBm";
    }
    return @"0dBm";
}

@end
