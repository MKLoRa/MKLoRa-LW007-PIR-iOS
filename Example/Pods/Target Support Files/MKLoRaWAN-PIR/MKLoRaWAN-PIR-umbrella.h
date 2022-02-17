#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CTMediator+MKPIRAdd.h"
#import "MKLoRaWANDIRModuleKey.h"
#import "MKPIRConnectModel.h"
#import "MKPIRTextButtonCell.h"
#import "MKPIRDatabaseManager.h"
#import "MKPIRAboutController.h"
#import "MKPIRBleSettingsController.h"
#import "MKPIRBleSettingsDataModel.h"
#import "MKPIRBleTxPowerCell.h"
#import "MKPIRDebuggerController.h"
#import "MKPIRDebuggerButton.h"
#import "MKPIRDebuggerCell.h"
#import "MKPIRDeviceInfoController.h"
#import "MKPIRDeviceInfoModel.h"
#import "MKPIRDeviceSettingController.h"
#import "MKPIRDeviceSettingModel.h"
#import "MKPIRGeneralController.h"
#import "MKPIRGeneralModel.h"
#import "MKPIRHallSettingsController.h"
#import "MKPIRHallSettingsModel.h"
#import "MKPIRLoRaAppSettingController.h"
#import "MKPIRLoRaAppSettingModel.h"
#import "MKPIRLoRaController.h"
#import "MKPIRLoRaPageModel.h"
#import "MKPIRLoRaSettingController.h"
#import "MKPIRLoRaSettingModel.h"
#import "MKPIRPirSettingController.h"
#import "MKPIRPirSettingsModel.h"
#import "MKPIRPirSettingsPickerCell.h"
#import "MKPIRScanController.h"
#import "MKPIRScanPageModel.h"
#import "MKPIRScanPageCell.h"
#import "MKPIRTHSettingsController.h"
#import "MKPIRTHSettingsModel.h"
#import "MKPIRTHAlarmCell.h"
#import "MKPIRTHSettingsHeaderView.h"
#import "MKPIRTabBarController.h"
#import "MKPIRUpdateController.h"
#import "MKPIRDFUModule.h"
#import "CBPeripheral+MKPIRAdd.h"
#import "MKPIRCentralManager.h"
#import "MKPIRInterface+MKPIRConfig.h"
#import "MKPIRInterface.h"
#import "MKPIROperation.h"
#import "MKPIROperationID.h"
#import "MKPIRPeripheral.h"
#import "MKPIRSDK.h"
#import "MKPIRSDKDataAdopter.h"
#import "MKPIRSDKNormalDefines.h"
#import "MKPIRTaskAdopter.h"
#import "Target_LoRaWANPIR_Module.h"

FOUNDATION_EXPORT double MKLoRaWAN_PIRVersionNumber;
FOUNDATION_EXPORT const unsigned char MKLoRaWAN_PIRVersionString[];

