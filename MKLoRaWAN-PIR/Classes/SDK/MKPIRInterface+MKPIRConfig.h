//
//  MKPIRInterface+MKPIRConfig.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRInterface.h"

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRInterface (MKPIRConfig)

#pragma mark ****************************************设备lorawan信息设置************************************************

/// Configure the region information of LoRaWAN.
/// @param region region
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRegion:(mk_pir_loraWanRegion)region
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN network access type.
/// @param modem modem
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configModem:(mk_pir_loraWanModem)modem
               sucBlock:(void (^)(void))sucBlock
            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVEUI of LoRaWAN.
/// @param devEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDEVEUI:(NSString *)devEUI
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPEUI of LoRaWAN.
/// @param appEUI Hexadecimal characters, length must be 16.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configAPPEUI:(NSString *)appEUI
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPKEY of LoRaWAN.
/// @param appKey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configAPPKEY:(NSString *)appKey
                sucBlock:(void (^)(void))sucBlock
             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DEVADDR of LoRaWAN.
/// @param devAddr Hexadecimal characters, length must be 8.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDEVADDR:(NSString *)devAddr
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the APPSKEY of LoRaWAN.
/// @param appSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configAPPSKEY:(NSString *)appSkey
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the NWKSKEY of LoRaWAN.
/// @param nwkSkey Hexadecimal characters, length must be 32.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configNWKSKEY:(NSString *)nwkSkey
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the message type of LoRaWAN.
/// @param messageType messageType
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configMessageType:(mk_pir_loraWanMessageType)messageType
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure The Max retransmission times  Of Lorawan.(Only for the message type is confirmed.)
/// @param times 1~8
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configLorawanMaxRetransmissionTimes:(NSInteger)times
                                       sucBlock:(void (^)(void))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the CH of LoRaWAN.It is only used for US915,AU915,CN470.
/// @param chlValue Minimum value of CH.0 ~ 95
/// @param chhValue Maximum value of CH. chlValue ~ 95
/// @param sucBlock Success callback
/// @param failedBlock  Failure callback
+ (void)pir_configCHL:(NSInteger)chlValue
                  CHH:(NSInteger)chhValue
             sucBlock:(void (^)(void))sucBlock
          failedBlock:(void (^)(NSError *error))failedBlock;

/// It is only used for EU868,CN779, EU433 and RU864. Off: The uplink report interval will not be limit by region freqency. On:The uplink report interval will be limit by region freqency.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDutyCycleStatus:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the DR of LoRaWAN.It is only used for CN470, CN779, EU433, EU868,KR920, IN865, RU864.
/// @param drValue 0~5
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDR:(NSInteger)drValue
            sucBlock:(void (^)(void))sucBlock
         failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure LoRaWAN uplink data sending strategy.
/// @param isOn ADR is on.
/// @param DRL When the ADR switch is off, the range is 0~6.
/// @param DRH When the ADR switch is off, the range is DRL~6
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configUplinkStrategy:(BOOL)isOn
                             DRL:(NSInteger)DRL
                             DRH:(NSInteger)DRH
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Time Sync Interval.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTimeSyncInterval:(NSInteger)interval
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Network Check Interval Of Lorawan.
/// @param interval 0h~255h.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configLorawanNetworkCheckInterval:(NSInteger)interval
                                     sucBlock:(void (^)(void))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark **************************************** BLE Params ************************************************

/// Configure the Beacon Mode switch status of the device.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configBeaconModeStatus:(BOOL)isOn
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure beacon broadcast time interval.
/// @param interval 1 x 100ms ~ 100 x 100ms
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configAdvInterval:(NSInteger)interval
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connectable status of the device.
/// @param connectable connectable
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configConnectableStatus:(BOOL)connectable
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast timeout time in Bluetooth configuration mode.
/// @param timeout 1Min~60Mins
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configBroadcastTimeout:(NSInteger)timeout
                          sucBlock:(void (^)(void))sucBlock
                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Do you need a password when configuring the device connection.
/// @param need need
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configNeedPassword:(BOOL)need
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the txPower of device.
/// @param txPower txPower
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTxPower:(mk_pir_txPower)txPower
                 sucBlock:(void (^)(void))sucBlock
              failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the broadcast name of the device.
/// @param deviceName 0~16 ascii characters
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDeviceName:(NSString *)deviceName
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************Device Config Params************************************************

/// Configure PIR monitoring switch status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_ConfigPIRFunctionStatus:(BOOL)isOn
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Information Payload reporting interval when PIR is continuously triggered.
/// @param interval 1Min~60Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configPIRReportInterval:(NSInteger)interval
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure PIR sensitivity.
/// @param sensitivity sensitivity
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configPIRSensitivity:(mk_pir_pirSensitivityType)sensitivity
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure PIR Delay Time.
/// @param value value
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configPIRDelayTime:(mk_pir_pirDelayTimeType)value
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure  the door sensor function status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDoorSensorSwitchStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the T&H sensor status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configHTSwitchStatus:(BOOL)isOn
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Sampling rate for reading temperature and humidity data.
/// @param rate 1s~60s.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configHTSampleRate:(NSInteger)rate
                      sucBlock:(void (^)(void))sucBlock
                   failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Temp Threshold Alarm.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTempThresholdAlarmStatus:(BOOL)isOn
                                  sucBlock:(void (^)(void))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the temperature alarm threshold.
/// @param maxThreshold minThreshold~60℃
/// @param minThreshold -30℃~maxThreshold
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTempThreshold:(NSInteger)maxThreshold
                   minThreshold:(NSInteger)minThreshold
                       sucBlock:(void (^)(void))sucBlock
                    failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Temp Change Alarm.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTempChangeAlarmStatus:(BOOL)isOn
                               sucBlock:(void (^)(void))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Change Value Threshold Of Temp Change Alarm.
/// @param duration 1H~24H
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTempChangeAlarmDurationCondition:(NSInteger)duration
                                          sucBlock:(void (^)(void))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Change Value Threshold Of Temp Change Alarm.
/// @param threshold 1℃~20℃
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTempChangeAlarmChangeValueThreshold:(NSInteger)threshold
                                             sucBlock:(void (^)(void))sucBlock
                                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure humidity threshold alarm status.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRHThresholdAlarmStatus:(BOOL)isOn
                                sucBlock:(void (^)(void))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the humidity alarm threshold.
/// @param maxThreshold minThreshold~100%
/// @param minThreshold 0%~maxThreshold
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRHThreshold:(NSInteger)maxThreshold
                 minThreshold:(NSInteger)minThreshold
                     sucBlock:(void (^)(void))sucBlock
                  failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Humidity Change Alarm.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRHChangeAlarmStatus:(BOOL)isOn
                             sucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Change Value Threshold Of Humidity Change Alarm.
/// @param duration 1H~24H
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRHChangeAlarmDurationCondition:(NSInteger)duration
                                        sucBlock:(void (^)(void))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Change Value Threshold Of Humidity Change Alarm.
/// @param threshold 1%~100%
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configRHChangeAlarmChangeValueThreshold:(NSInteger)threshold
                                           sucBlock:(void (^)(void))sucBlock
                                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the time zone of the device.
/// @param timeZone -24~28  //(The time zone is in units of 30 minutes, UTC-12:00~UTC+14:00.eg:timeZone = -23 ,--> UTC-11:30)
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configTimeZone:(NSInteger)timeZone
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure the connection password of device.
/// @param password 8-character ascii code
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configPassword:(NSString *)password
                  sucBlock:(void (^)(void))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure device heartbeat interval.
/// @param interval 1Min - 14400Mins.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configHeartbeatInterval:(NSInteger)interval
                           sucBlock:(void (^)(void))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Low Power Prompt.
/// @param type type
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configLowPowerPrompt:(mk_pir_lowPowerPromptType)type
                        sucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Configure Low Power Payload.
/// @param isOn isOn
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configLowPowerPayload:(BOOL)isOn
                         sucBlock:(void (^)(void))sucBlock
                      failedBlock:(void (^)(NSError *error))failedBlock;

#pragma mark ****************************************Device System Params************************************************

/// Restart the device.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_restartDeviceWithSucBlock:(void (^)(void))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock;

/// Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_factoryResetWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

/// Device shutdown.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_powerOffWithSucBlock:(void (^)(void))sucBlock
                     failedBlock:(void (^)(NSError *error))failedBlock;

/// Sync device time.
/// @param timestamp UTC
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_configDeviceTime:(unsigned long)timestamp
                    sucBlock:(void (^)(void))sucBlock
                 failedBlock:(void (^)(NSError *error))failedBlock;

/// Battery Reset.
/// @param sucBlock Success callback
/// @param failedBlock Failure callback
+ (void)pir_batteryResetWithSucBlock:(void (^)(void))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock;

@end

NS_ASSUME_NONNULL_END
