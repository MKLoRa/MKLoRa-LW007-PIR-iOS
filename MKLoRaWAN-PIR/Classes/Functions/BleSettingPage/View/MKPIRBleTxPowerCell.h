//
//  MKPIRBleTxPowerCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/10/22.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, mk_pir_deviceTxPower) {
    mk_pir_deviceTxPowerNeg40dBm,   //RadioTxPower:-40dBm
    mk_pir_deviceTxPowerNeg20dBm,   //-20dBm
    mk_pir_deviceTxPowerNeg16dBm,   //-16dBm
    mk_pir_deviceTxPowerNeg12dBm,   //-12dBm
    mk_pir_deviceTxPowerNeg8dBm,    //-8dBm
    mk_pir_deviceTxPowerNeg4dBm,    //-4dBm
    mk_pir_deviceTxPower0dBm,       //0dBm
    mk_pir_deviceTxPower3dBm,       //3dBm
    mk_pir_deviceTxPower4dBm,       //4dBm
};

@interface MKPIRBleTxPowerCellModel : NSObject

@property (nonatomic, assign)mk_pir_deviceTxPower txPower;

@end

@protocol MKPIRBleTxPowerCellDelegate <NSObject>

- (void)mk_pir_txPowerValueChanged:(mk_pir_deviceTxPower)txPower;

@end

@interface MKPIRBleTxPowerCell : MKBaseCell

@property (nonatomic, strong)MKPIRBleTxPowerCellModel *dataModel;

@property (nonatomic, weak)id <MKPIRBleTxPowerCellDelegate>delegate;

+ (MKPIRBleTxPowerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
