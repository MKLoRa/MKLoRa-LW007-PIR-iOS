#pragma mark ****************************************Enumerate************************************************

#pragma mark - MKPIRCentralManager

typedef NS_ENUM(NSInteger, mk_pir_centralConnectStatus) {
    mk_pir_centralConnectStatusUnknow,                                           //未知状态
    mk_pir_centralConnectStatusConnecting,                                       //正在连接
    mk_pir_centralConnectStatusConnected,                                        //连接成功
    mk_pir_centralConnectStatusConnectedFailed,                                  //连接失败
    mk_pir_centralConnectStatusDisconnect,
};

typedef NS_ENUM(NSInteger, mk_pir_centralManagerStatus) {
    mk_pir_centralManagerStatusUnable,                           //不可用
    mk_pir_centralManagerStatusEnable,                           //可用状态
};

typedef NS_ENUM(NSInteger, mk_pir_loraWanRegion) {
    mk_pir_loraWanRegionAS923,
    mk_pir_loraWanRegionAU915,
    mk_pir_loraWanRegionCN470,
    mk_pir_loraWanRegionCN779,
    mk_pir_loraWanRegionEU433,
    mk_pir_loraWanRegionEU868,
    mk_pir_loraWanRegionKR920,
    mk_pir_loraWanRegionIN865,
    mk_pir_loraWanRegionUS915,
    mk_pir_loraWanRegionRU864,
};

typedef NS_ENUM(NSInteger, mk_pir_loraWanModem) {
    mk_pir_loraWanModemABP,
    mk_pir_loraWanModemOTAA,
};

typedef NS_ENUM(NSInteger, mk_pir_loraWanMessageType) {
    mk_pir_loraWanUnconfirmMessage,          //Non-acknowledgement frame.
    mk_pir_loraWanConfirmMessage,            //Confirm the frame.
};

typedef NS_ENUM(NSInteger, mk_pir_pirSensitivityType) {
    mk_pir_pirSensitivityType_low,
    mk_pir_pirSensitivityType_medium,
    mk_pir_pirSensitivityType_high,
};

typedef NS_ENUM(NSInteger, mk_pir_pirDelayTimeType) {
    mk_pir_pirDelayTimeType_low,
    mk_pir_pirDelayTimeType_medium,
    mk_pir_pirDelayTimeType_high,
};

typedef NS_ENUM(NSInteger, mk_pir_lowPowerPromptType) {
    mk_pir_lowPowerPromptType_fivePercent,             //5%
    mk_pir_lowPowerPromptType_tenPercent,              //10%
};

typedef NS_ENUM(NSInteger, mk_pir_txPower) {
    mk_pir_txPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_pir_txPowerNeg20dBm,   //-20dBm
    mk_pir_txPowerNeg16dBm,   //-16dBm
    mk_pir_txPowerNeg12dBm,   //-12dBm
    mk_pir_txPowerNeg8dBm,    //-8dBm
    mk_pir_txPowerNeg4dBm,    //-4dBm
    mk_pir_txPower0dBm,       //0dBm
    mk_pir_txPower3dBm,       //3dBm
    mk_pir_txPower4dBm,       //4dBm
};

typedef NS_ENUM(NSInteger, mk_pir_productModel) {
    mk_pir_productModel_FE,                        //Europe and France
    mk_pir_productModel_America,                  //America
    mk_pir_productModel_UK,                      //UK
};

typedef NS_ENUM(NSInteger, mk_pir_eu868SingleChannelType) {
    mk_pir_eu868SingleChannelType_8681,                        //868.1MHz
    mk_pir_eu868SingleChannelType_8683,                        //868.3MHz
    mk_pir_eu868SingleChannelType_8684,                        //868.5MHz
};

#pragma mark ****************************************Delegate************************************************

@protocol mk_pir_centralManagerScanDelegate <NSObject>


///The device is scanned
/// @param deviceModel deviceModel
/*
 @{
     @"rssi":rssi,                        
     @"peripheral":peripheral,
     @"deviceName":(advDic[CBAdvertisementDataLocalNameKey] ? advDic[CBAdvertisementDataLocalNameKey] : @""),
     @"macAddress":macAddress,
     @"pirSensitivity":pirSensitivity,               //PIR sensor sensitivity.  00:Low sensitivity.
                                                                                01:Medium sensitivity.
                                                                                10:High sensitivity.
                                                                                11:PIR is not enabled.
     @"pirInductionState":pirInductionState,        //PIR sensor sensing status.    00:No person detected.
                                                                                    01:Person detected.
                                                                                    11:PIR is not enabled.
     @"roorSensorState":roorSensorState,            //Door sensor status.           00:Door closed.
                                                                                    01:Door open.
                                                                                    11:Door sensor is not enabled.
     @"lowPower":@(lowPower),                       //Whether the battery level is too low.
     @"alarm":@(alarm),                             //Whether the device has turned on the low battery alarm function.
     @"temperature":temperature,                    //If the temperature value is ffff, it means that the function is not turned on.
     @"humidity":humidity,                          //If the humidity value is ffff, it means that the function is not turned on.
     @"battery":battery,                            //battery voltage.
     @"txPower":txPower,
     @"connectable":advDic[CBAdvertisementDataIsConnectable],
 };
 */
- (void)mk_pir_receiveDevice:(NSDictionary *)deviceModel;

@optional

/// Starts scanning equipment.
- (void)mk_pir_startScan;

/// Stops scanning equipment.
- (void)mk_pir_stopScan;

@end



@protocol mk_pir_centralManagerLogDelegate <NSObject>

- (void)mk_pir_receiveLog:(NSString *)deviceLog;

@end
