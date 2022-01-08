//
//  CBPeripheral+MKPIRAdd.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <CoreBluetooth/CoreBluetooth.h>

NS_ASSUME_NONNULL_BEGIN

@interface CBPeripheral (MKPIRAdd)

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *pir_manufacturer;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *pir_deviceModel;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *pir_hardware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *pir_sofeware;

/// R
@property (nonatomic, strong, readonly)CBCharacteristic *pir_firmware;

#pragma mark - custom

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_password;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_disconnectType;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_pirSensorData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_doorSensorData;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_thSensorData;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_config;

/// W/N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_state;

/// N
@property (nonatomic, strong, readonly)CBCharacteristic *pir_log;

- (void)pir_updateCharacterWithService:(CBService *)service;

- (void)pir_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic;

- (BOOL)pir_connectSuccess;

- (void)pir_setNil;

@end

NS_ASSUME_NONNULL_END
