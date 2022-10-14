

typedef NS_ENUM(NSInteger, mk_pir_taskOperationID) {
    mk_pir_defaultTaskOperationID,
    
#pragma mark - Read
    mk_pir_taskReadDeviceModelOperation,        //读取产品型号
    mk_pir_taskReadFirmwareOperation,           //读取固件版本
    mk_pir_taskReadHardwareOperation,           //读取硬件类型
    mk_pir_taskReadSoftwareOperation,           //读取软件版本
    mk_pir_taskReadManufacturerOperation,       //读取厂商信息
    mk_pir_taskReadDeviceTypeOperation,         //读取产品类型
    
#pragma mark - 密码特征
    mk_pir_connectPasswordOperation,             //连接设备时候发送密码
    
#pragma mark - 设备LoRa参数读取
    mk_pir_taskReadLorawanRegionOperation,           //读取LoRaWAN频段
    mk_pir_taskReadLorawanModemOperation,        //读取LoRaWAN入网类型
    mk_pir_taskReadLorawanDEVEUIOperation,           //读取LoRaWAN DEVEUI
    mk_pir_taskReadLorawanAPPEUIOperation,           //读取LoRaWAN APPEUI
    mk_pir_taskReadLorawanAPPKEYOperation,           //读取LoRaWAN APPKEY
    mk_pir_taskReadLorawanDEVADDROperation,          //读取LoRaWAN DEVADDR
    mk_pir_taskReadLorawanAPPSKEYOperation,          //读取LoRaWAN APPSKEY
    mk_pir_taskReadLorawanNWKSKEYOperation,          //读取LoRaWAN NWKSKEY
    mk_pir_taskReadLorawanMessageTypeOperation,      //读取上行数据类型
    mk_pir_taskReadLorawanMaxRetransmissionTimesOperation,   //读取LoRaWAN重传次数
    mk_pir_taskReadLorawanCHOperation,               //读取LoRaWAN CH
    mk_pir_taskReadLorawanDROperation,               //读取LoRaWAN DR
    mk_pir_taskReadLorawanUplinkStrategyOperation,   //读取LoRaWAN数据发送策略
    mk_pir_taskReadLorawanDutyCycleStatusOperation,  //读取dutycyle
    mk_pir_taskReadLorawanDevTimeSyncIntervalOperation,  //读取同步时间同步间隔
    mk_pir_taskReadLorawanNetworkCheckIntervalOperation, //读取网络确认间隔
    
#pragma mark - 蓝牙参数读取
    mk_pir_taskReadBeaconModeStatusOperation,            //读取Beacon Mode状态
    mk_pir_taskReadAdvIntervalOperation,                 //读取广播间隔
    mk_pir_taskReadDeviceConnectableOperation,           //读取可连接状态
    mk_pir_taskReadBroadcastTimeoutOperation,            //读取蓝牙配置模式下广播超时时间
    mk_pir_taskReadConnectationNeedPasswordOperation,    //读取密码开关
    mk_pir_taskReadTxPowerOperation,                     //读取发射功率
    mk_pir_taskReadDeviceNameOperation,                  //读取设备广播名称
    
#pragma mark - 读取辅助功能参数
    mk_pir_taskReadPIRFunctionStatusOperation,          //读取PIR监测开关状态
    mk_pir_taskReadPIRReportIntervalOperation,         //读取PIR持续占用上报间隔
    mk_pir_taskReadPIRSensitivityOperation,             //读取PIR灵敏度
    mk_pir_taskReadPIRDelayTimeOperation,               //读取PIR延时时间档位设置
    mk_pir_taskReadDoorSensorSwitchStatusOperation,     //读取门磁感应功能状态
    mk_pir_taskReadHTSwitchStatusOperation,             //读取温湿度监测使能
    mk_pir_taskReadHTSampleRateOperation,               //读取温湿度数据采样间隔
    mk_pir_taskReadTempThresholdAlarmStatusOperation,   //读取温度阈值报警使能
    mk_pir_taskReadTempThresholdOperation,              //读取温度上下限阈值
    mk_pir_taskReadTempChangeAlarmStatusOperation,      //读取温度变化报警使能
    mk_pir_taskReadTempChangeAlarmDurationConditionOperation,   //读取温度变化报警设定时间
    mk_pir_taskReadTempChangeAlarmChangeValueThresholdOperation,    //读取温度变化值
    mk_pir_taskReadRHThresholdAlarmStatusOperation,     //读取湿度阈值报警使能
    mk_pir_taskReadRHThresholdOperation,                //读取湿度上下限阈值
    mk_pir_taskReadRHChangeAlarmStatusOperation,        //读取湿度变化报警使能
    mk_pir_taskReadRHChangeAlarmDurationConditionOperation,     //读取湿度变化报警设定时间
    mk_pir_taskReadRHChangeAlarmChangeValueThresholdOperation,  //读取湿度变化值
    mk_pir_taskReadTimeZoneOperation,                   //读取时区
    mk_pir_taskReadPasswordOperation,                   //读取密码
    mk_pir_taskReadHeartbeatIntervalOperation,          //读取设备心跳间隔
    mk_pir_taskReadLowPowerPromptOperation,             //读取低电档位
    mk_pir_taskReadLowPowerPayloadOperation,            //读取低点上报状态
    
#pragma mark - 设备控制参数读取
    mk_pir_taskReadLorawanNetworkStatusOperation,    //读取LoRaWAN网络状态
    mk_pir_taskReadBatteryVoltageOperation,          //读取电池电量
    mk_pir_taskReadMacAddressOperation,              //读取mac地址
    mk_pir_taskReadPIRStatusOperation,               //读取PIR状态
    mk_pir_taskReadDoorSensorDatasOperation,         //读取门磁传感器数据
    mk_pir_taskReadTHDatasSensorDatasOperation,     //读取温湿度数据
    mk_pir_taskReadPCBAStatusOperation,              //读取产测标志
    
#pragma mark - 设备LoRa参数配置
    mk_pir_taskConfigRegionOperation,                    //配置LoRaWAN的region
    mk_pir_taskConfigModemOperation,                     //配置LoRaWAN的入网类型
    mk_pir_taskConfigDEVEUIOperation,                    //配置LoRaWAN的devEUI
    mk_pir_taskConfigAPPEUIOperation,                    //配置LoRaWAN的appEUI
    mk_pir_taskConfigAPPKEYOperation,                    //配置LoRaWAN的appKey
    mk_pir_taskConfigDEVADDROperation,                   //配置LoRaWAN的DevAddr
    mk_pir_taskConfigAPPSKEYOperation,                   //配置LoRaWAN的APPSKEY
    mk_pir_taskConfigNWKSKEYOperation,                   //配置LoRaWAN的NwkSKey
    mk_pir_taskConfigMessageTypeOperation,               //配置LoRaWAN的message type
    mk_pir_taskConfigMaxRetransmissionTimesOperation,    //配置LoRaWAN的重传次数
    mk_pir_taskConfigCHValueOperation,                   //配置LoRaWAN的CH值
    mk_pir_taskConfigDutyCycleStatusOperation,           //配置LoRaWAN的duty cycle
    mk_pir_taskConfigDRValueOperation,                   //配置LoRaWAN的DR值
    mk_pir_taskConfigUplinkStrategyOperation,            //配置LoRaWAN数据发送策略
    mk_pir_taskConfigTimeSyncIntervalOperation,          //配置LoRaWAN的同步指令间隔
    mk_pir_taskConfigNetworkCheckIntervalOperation,      //配置LoRaWAN的LinkCheckReq间隔
    
#pragma mark - 蓝牙参数
    mk_pir_taskConfigBeaconModeStatusOperation,          //配置Beacon Mode使能
    mk_pir_taskConfigAdvIntervalOperation,               //配置广播间隔
    mk_pir_taskConfigConnectableStatusOperation,         //配置可连接状态
    mk_pir_taskConfigBroadcastTimeoutOperation,          //配置蓝牙配置模式下广播超时时间
    mk_pir_taskConfigNeedPasswordOperation,              //配置密码开关
    mk_pir_taskConfigTxPowerOperation,                   //配置txPower
    mk_pir_taskConfigDeviceNameOperation,                //配置设备广播名称
    
#pragma mark - 配置设备辅助功能参数
    mk_pir_taskConfigPIRFunctionStatusOperation,         //配置PIR检测开关
    mk_pir_taskConfigPIRReportIntervalOperation,        //配置PIR持续占用上报间隔
    mk_pir_taskConfigPIRSensitivityOperation,            //配置PIR灵敏度档位
    mk_pir_taskConfigPIRDelayTimeOperation,              //配置PIR延时时间档位
    mk_pir_taskConfigDoorSensorSwitchStatusOperation,    //配置门磁感应功能状态
    mk_pir_taskConfigHTSwitchStatusOperation,            //配置温湿度监测使能
    mk_pir_taskConfigHTSampleRateOperation,              //配置温湿度数据采样间隔
    mk_pir_taskConfigTempThresholdAlarmStatusOperation,  //配置温度阈值报警使能
    mk_pir_taskConfigTempThresholdOperation,             //配置温度上下限阈值
    mk_pir_taskConfigTempChangeAlarmStatusOperation,     //配置温度变化报警使能
    mk_pir_taskConfigTempChangeAlarmDurationConditionOperation,     //配置温度变化报警设定时间
    mk_pir_taskConfigTempChangeAlarmChangeValueThresholdOperation,  //配置温度变化值
    mk_pir_taskConfigRHThresholdAlarmStatusOperation,               //配置湿度阈值报警使能
    mk_pir_taskConfigRHThresholdOperation,              //配置湿度上下限阈值
    mk_pir_taskConfigRHChangeAlarmStatusOperation,      //配置湿度变化报警使能
    mk_pir_taskConfigRHChangeAlarmDurationConditionOperation,       //配置湿度变化报警设定时间
    mk_pir_taskConfigRHChangeAlarmChangeValueThresholdOperation,    //配置湿度变化值
    mk_pir_taskConfigTimeZoneOperation,                 //配置时区
    mk_pir_taskConfigPasswordOperation,                 //修改密码
    mk_pir_taskConfigHeartbeatIntervalOperation,         //配置心跳间隔
    mk_pir_taskConfigLowPowerPromptOperation,           //配置低电档位
    mk_pir_taskConfigLowPowerPayloadOperation,          //配置低电上报
    
#pragma mark - 配置设备状态参数
    mk_pir_taskRestartDeviceOperation,                   //重启设备
    mk_pir_taskFactoryResetOperation,                    //恢复出厂设置
    mk_pir_taskPowerOffOperation,                        //关机
    mk_pir_taskConfigDeviceTimeOperation,                //同步时间
};
