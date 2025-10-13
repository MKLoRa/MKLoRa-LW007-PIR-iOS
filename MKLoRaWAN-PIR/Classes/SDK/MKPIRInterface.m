//
//  MKPIRInterface.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRInterface.h"

#import "MKPIRCentralManager.h"
#import "MKPIROperationID.h"
#import "MKPIROperation.h"
#import "CBPeripheral+MKPIRAdd.h"

#define centralManager [MKPIRCentralManager shared]
#define peripheral ([MKPIRCentralManager shared].peripheral)

@implementation MKPIRInterface

#pragma mark ****************************************Device Service Information************************************************

+ (void)pir_readDeviceModelWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_pir_taskReadDeviceModelOperation
                           characteristic:peripheral.pir_deviceModel
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)pir_readFirmwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_pir_taskReadFirmwareOperation
                           characteristic:peripheral.pir_firmware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)pir_readHardwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_pir_taskReadHardwareOperation
                           characteristic:peripheral.pir_hardware
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)pir_readSoftwareWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_pir_taskReadSoftwareOperation
                           characteristic:peripheral.pir_software
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

+ (void)pir_readManufacturerWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [centralManager addReadTaskWithTaskID:mk_pir_taskReadManufacturerOperation
                           characteristic:peripheral.pir_manufacturer
                             successBlock:sucBlock
                             failureBlock:failedBlock];
}

#pragma mark **************************************** LoRaWAN ************************************************

+ (void)pir_readLorawanRegionWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanRegionOperation
                     cmdFlag:@"01"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanModemWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanModemOperation
                     cmdFlag:@"02"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanDEVEUIWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanDEVEUIOperation
                     cmdFlag:@"03"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanAPPEUIWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanAPPEUIOperation
                     cmdFlag:@"04"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanAPPKEYWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanAPPKEYOperation
                     cmdFlag:@"05"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanDEVADDRWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanDEVADDROperation
                     cmdFlag:@"06"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanAPPSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanAPPSKEYOperation
                     cmdFlag:@"07"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanNWKSKEYWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanNWKSKEYOperation
                     cmdFlag:@"08"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanMessageTypeWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanMessageTypeOperation
                     cmdFlag:@"09"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanMaxRetransmissionTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanMaxRetransmissionTimesOperation
                     cmdFlag:@"0a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanCHWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanCHOperation
                     cmdFlag:@"0b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanDRWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanDROperation
                     cmdFlag:@"0c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanUplinkStrategyWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanUplinkStrategyOperation
                     cmdFlag:@"0d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanDutyCycleStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanDutyCycleStatusOperation
                     cmdFlag:@"0e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanTimeSyncIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanDevTimeSyncIntervalOperation
                     cmdFlag:@"0f"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLorawanNetworkCheckIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLorawanNetworkCheckIntervalOperation
                     cmdFlag:@"10"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readEU868SingleChannelStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadEU868SingleChannelStatusOperation
                     cmdFlag:@"11"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readEU868SingleChannelSelectionWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadEU868SingleChannelSelectionOperation
                     cmdFlag:@"12"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark **************************************** BLE Params ************************************************

+ (void)pir_readBeaconModeStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadBeaconModeStatusOperation
                     cmdFlag:@"20"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readAdvIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadAdvIntervalOperation
                     cmdFlag:@"21"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readDeviceConnectableWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadDeviceConnectableOperation
                     cmdFlag:@"22"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readBroadcastTimeoutWithSucBlock:(void (^)(id returnData))sucBlock
                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadBroadcastTimeoutOperation
                     cmdFlag:@"23"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readConnectationNeedPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadConnectationNeedPasswordOperation
                     cmdFlag:@"24"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTxPowerWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTxPowerOperation
                     cmdFlag:@"25"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readDeviceNameWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadDeviceNameOperation
                     cmdFlag:@"26"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark ****************************************Device Config Params************************************************
+ (void)pir_readPIRFunctionStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadPIRFunctionStatusOperation
                     cmdFlag:@"30"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readPIRReportIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadPIRReportIntervalOperation
                     cmdFlag:@"31"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readPIRSensitivityWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadPIRSensitivityOperation
                     cmdFlag:@"32"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readPIRDelayTimeWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadPIRDelayTimeOperation
                     cmdFlag:@"33"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readDoorSensorSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadDoorSensorSwitchStatusOperation
                     cmdFlag:@"34"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readHTSwitchStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadHTSwitchStatusOperation
                     cmdFlag:@"35"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readHTSampleRateWithSucBlock:(void (^)(id returnData))sucBlock
                             failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadHTSampleRateOperation
                     cmdFlag:@"36"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTempThresholdAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTempThresholdAlarmStatusOperation
                     cmdFlag:@"37"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTempThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTempThresholdOperation
                     cmdFlag:@"38"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTempChangeAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                      failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTempChangeAlarmStatusOperation
                     cmdFlag:@"3a"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTempChangeAlarmDurationConditionWithSucBlock:(void (^)(id returnData))sucBlock
                                                 failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTempChangeAlarmDurationConditionOperation
                     cmdFlag:@"3b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTempChangeAlarmChangeValueThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTempChangeAlarmChangeValueThresholdOperation
                     cmdFlag:@"3c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readRHThresholdAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                       failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadRHThresholdAlarmStatusOperation
                     cmdFlag:@"3d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readRHThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadRHThresholdOperation
                     cmdFlag:@"3e"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readRHChangeAlarmStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadRHChangeAlarmStatusOperation
                     cmdFlag:@"40"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readRHChangeAlarmDurationConditionWithSucBlock:(void (^)(id returnData))sucBlock
                                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadRHChangeAlarmDurationConditionOperation
                     cmdFlag:@"41"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readRHChangeAlarmChangeValueThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadRHChangeAlarmChangeValueThresholdOperation
                     cmdFlag:@"42"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readTimeZoneWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadTimeZoneOperation
                     cmdFlag:@"43"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readPasswordWithSucBlock:(void (^)(id returnData))sucBlock
                         failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadPasswordOperation
                     cmdFlag:@"44"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readHeartbeatIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                  failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadHeartbeatIntervalOperation
                     cmdFlag:@"46"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLowPowerPromptWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLowPowerPromptOperation
                     cmdFlag:@"47"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLowPowerPayloadWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLowPowerPayloadOperation
                     cmdFlag:@"48"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLowPowerCondition1VoltageThresholdWithSucBlock:(void (^)(id returnData))sucBlock
                                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLowPowerCondition1VoltageThresholdOperation
                     cmdFlag:@"4b"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLowPowerCondition1MinSampleIntervalWithSucBlock:(void (^)(id returnData))sucBlock
                                                    failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLowPowerCondition1MinSampleIntervalOperation
                     cmdFlag:@"4c"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

+ (void)pir_readLowPowerCondition1SampleTimesWithSucBlock:(void (^)(id returnData))sucBlock
                                              failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDataWithTaskID:mk_pir_taskReadLowPowerCondition1SampleTimesOperation
                     cmdFlag:@"4d"
                    sucBlock:sucBlock
                 failedBlock:failedBlock];
}

#pragma mark - 配置
+ (void)pir_readLorawanNetworkStatusWithSucBlock:(void (^)(id returnData))sucBlock
                                     failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadLorawanNetworkStatusOperation
                                  cmdFlag:@"54"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readBatteryVoltageWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadBatteryVoltageOperation
                                  cmdFlag:@"56"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readMacAddressWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadMacAddressOperation
                                  cmdFlag:@"57"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readPIRStatusWithSucBlock:(void (^)(id returnData))sucBlock
                          failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadPIRStatusOperation
                                  cmdFlag:@"58"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readDoorSensorDatasWithSucBlock:(void (^)(id returnData))sucBlock
                                failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadDoorSensorDatasOperation
                                  cmdFlag:@"59"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readTHDatasWithSucBlock:(void (^)(id returnData))sucBlock
                        failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadTHDatasSensorDatasOperation
                                  cmdFlag:@"5a"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readPCBAStatusWithSucBlock:(void (^)(id returnData))sucBlock
                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadPCBAStatusOperation
                                  cmdFlag:@"5c"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readSelftestStatusWithSucBlock:(void (^)(id returnData))sucBlock
                               failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadSelftestStatusOperation
                                  cmdFlag:@"5d"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                   failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadBatteryInformationOperation
                                  cmdFlag:@"5e"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readLastCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                            failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadLastCycleBatteryInformationOperation
                                  cmdFlag:@"60"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

+ (void)pir_readAllCycleBatteryInformationWithSucBlock:(void (^)(id returnData))sucBlock
                                           failedBlock:(void (^)(NSError *error))failedBlock {
    [self readDeviceControlDataWithTaskID:mk_pir_taskReadAllCycleBatteryInformationOperation
                                  cmdFlag:@"61"
                                 sucBlock:sucBlock
                              failedBlock:failedBlock];
}

#pragma mark - private method

+ (void)readDataWithTaskID:(mk_pir_taskOperationID)taskID
                   cmdFlag:(NSString *)flag
                  sucBlock:(void (^)(id returnData))sucBlock
               failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.pir_config
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

+ (void)readDeviceControlDataWithTaskID:(mk_pir_taskOperationID)taskID
                                cmdFlag:(NSString *)flag
                               sucBlock:(void (^)(id returnData))sucBlock
                            failedBlock:(void (^)(NSError *error))failedBlock {
    NSString *commandString = [NSString stringWithFormat:@"%@%@%@",@"ed00",flag,@"00"];
    [centralManager addTaskWithTaskID:taskID
                       characteristic:peripheral.pir_state
                          commandData:commandString
                         successBlock:sucBlock
                         failureBlock:failedBlock];
}

@end
