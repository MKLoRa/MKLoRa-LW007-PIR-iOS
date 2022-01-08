//
//  CBPeripheral+MKPIRAdd.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "CBPeripheral+MKPIRAdd.h"

#import <objc/runtime.h>

static const char *pir_manufacturerKey = "pir_manufacturerKey";
static const char *pir_deviceModelKey = "pir_deviceModelKey";
static const char *pir_hardwareKey = "pir_hardwareKey";
static const char *pir_softwareKey = "pir_softwareKey";
static const char *pir_firmwareKey = "pir_firmwareKey";

static const char *pir_passwordKey = "pir_passwordKey";
static const char *pir_disconnectTypeKey = "pir_disconnectTypeKey";
static const char *pir_pirSensorDataKey = "pir_pirSensorDataKey";
static const char *pir_doorSensorDataKey = "pir_doorSensorDataKey";
static const char *pir_thSensorDataKey = "pir_thSensorDataKey";
static const char *pir_configKey = "pir_configKey";
static const char *pir_stateKey = "pir_stateKey";
static const char *pir_logKey = "pir_logKey";

static const char *pir_passwordNotifySuccessKey = "pir_passwordNotifySuccessKey";
static const char *pir_disconnectTypeNotifySuccessKey = "pir_disconnectTypeNotifySuccessKey";
static const char *pir_configNotifySuccessKey = "pir_configNotifySuccessKey";
static const char *pir_stateNotifySuccessKey = "pir_stateNotifySuccessKey";

@implementation CBPeripheral (MKPIRAdd)

- (void)pir_updateCharacterWithService:(CBService *)service {
    NSArray *characteristicList = service.characteristics;
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"180A"]]) {
        //设备信息
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A24"]]) {
                objc_setAssociatedObject(self, &pir_deviceModelKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A26"]]) {
                objc_setAssociatedObject(self, &pir_firmwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A27"]]) {
                objc_setAssociatedObject(self, &pir_hardwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A28"]]) {
                objc_setAssociatedObject(self, &pir_softwareKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"2A29"]]) {
                objc_setAssociatedObject(self, &pir_manufacturerKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
    if ([service.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        //自定义
        for (CBCharacteristic *characteristic in characteristicList) {
            if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
                objc_setAssociatedObject(self, &pir_passwordKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
                objc_setAssociatedObject(self, &pir_disconnectTypeKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA02"]]) {
                objc_setAssociatedObject(self, &pir_pirSensorDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA03"]]) {
                objc_setAssociatedObject(self, &pir_doorSensorDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA04"]]) {
                objc_setAssociatedObject(self, &pir_thSensorDataKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
                objc_setAssociatedObject(self, &pir_configKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA06"]]) {
                objc_setAssociatedObject(self, &pir_stateKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [self setNotifyValue:YES forCharacteristic:characteristic];
            }else if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA07"]]) {
                objc_setAssociatedObject(self, &pir_logKey, characteristic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
        }
        return;
    }
}

- (void)pir_updateCurrentNotifySuccess:(CBCharacteristic *)characteristic {
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA00"]]) {
        objc_setAssociatedObject(self, &pir_passwordNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA01"]]) {
        objc_setAssociatedObject(self, &pir_disconnectTypeNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA05"]]) {
        objc_setAssociatedObject(self, &pir_configNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    if ([characteristic.UUID isEqual:[CBUUID UUIDWithString:@"AA06"]]) {
        objc_setAssociatedObject(self, &pir_stateNotifySuccessKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
}

- (BOOL)pir_connectSuccess {
    if (![objc_getAssociatedObject(self, &pir_configNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &pir_passwordNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &pir_disconnectTypeNotifySuccessKey) boolValue] || ![objc_getAssociatedObject(self, &pir_stateNotifySuccessKey) boolValue]) {
        return NO;
    }
    if (!self.pir_manufacturer || !self.pir_deviceModel || !self.pir_hardware || !self.pir_sofeware || !self.pir_firmware) {
        return NO;
    }
    if (!self.pir_password || !self.pir_disconnectType || !self.pir_pirSensorData || !self.pir_doorSensorData || !self.pir_thSensorData || !self.pir_config || !self.pir_state || !self.pir_log) {
        return NO;
    }
    return YES;
}

- (void)pir_setNil {
    objc_setAssociatedObject(self, &pir_manufacturerKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_deviceModelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_hardwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_softwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_firmwareKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &pir_passwordKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_disconnectTypeKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_pirSensorDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_doorSensorDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_thSensorDataKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_configKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_stateKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_logKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    objc_setAssociatedObject(self, &pir_passwordNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_disconnectTypeNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_configNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &pir_stateNotifySuccessKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - getter

- (CBCharacteristic *)pir_manufacturer {
    return objc_getAssociatedObject(self, &pir_manufacturerKey);
}

- (CBCharacteristic *)pir_deviceModel {
    return objc_getAssociatedObject(self, &pir_deviceModelKey);
}

- (CBCharacteristic *)pir_hardware {
    return objc_getAssociatedObject(self, &pir_hardwareKey);
}

- (CBCharacteristic *)pir_sofeware {
    return objc_getAssociatedObject(self, &pir_softwareKey);
}

- (CBCharacteristic *)pir_firmware {
    return objc_getAssociatedObject(self, &pir_firmwareKey);
}

- (CBCharacteristic *)pir_password {
    return objc_getAssociatedObject(self, &pir_passwordKey);
}

- (CBCharacteristic *)pir_disconnectType {
    return objc_getAssociatedObject(self, &pir_disconnectTypeKey);
}

- (CBCharacteristic *)pir_pirSensorData {
    return objc_getAssociatedObject(self, &pir_pirSensorDataKey);
}

- (CBCharacteristic *)pir_doorSensorData {
    return objc_getAssociatedObject(self, &pir_doorSensorDataKey);
}

- (CBCharacteristic *)pir_thSensorData {
    return objc_getAssociatedObject(self, &pir_thSensorDataKey);
}

- (CBCharacteristic *)pir_config {
    return objc_getAssociatedObject(self, &pir_configKey);
}

- (CBCharacteristic *)pir_state {
    return objc_getAssociatedObject(self, &pir_stateKey);
}

- (CBCharacteristic *)pir_log {
    return objc_getAssociatedObject(self, &pir_logKey);
}

@end
