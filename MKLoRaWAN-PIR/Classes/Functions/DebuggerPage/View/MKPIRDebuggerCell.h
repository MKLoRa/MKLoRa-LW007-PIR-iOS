//
//  MKPIRDebuggerCell.h
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/29.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import <MKBaseModuleLibrary/MKBaseCell.h>

NS_ASSUME_NONNULL_BEGIN

@interface MKPIRDebuggerCellModel : NSObject

@property (nonatomic, assign)NSInteger index;

@property (nonatomic, copy)NSString *timeMsg;

@property (nonatomic, assign)BOOL selected;

@property (nonatomic, copy)NSString *logInfo;

@end

@protocol MKPIRDebuggerCellDelegate <NSObject>

- (void)pir_debuggerCellSelectedChanged:(NSInteger)index selected:(BOOL)selected;

@end

@interface MKPIRDebuggerCell : MKBaseCell

@property (nonatomic, strong)MKPIRDebuggerCellModel *dataModel;

@property (nonatomic, weak)id <MKPIRDebuggerCellDelegate>delegate;

+ (MKPIRDebuggerCell *)initCellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
