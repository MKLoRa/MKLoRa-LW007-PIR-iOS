//
//  MKPIRDevEUICell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2025/3/5.
//  Copyright © 2025 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRDevEUICellModel : NSObject

@property (nonatomic, copy)NSString *devEUI;

@end

@interface MKPIRDevEUICell : MKBaseCell

@property (nonatomic, strong)MKPIRDevEUICellModel *dataModel;

+ (MKPIRDevEUICell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
