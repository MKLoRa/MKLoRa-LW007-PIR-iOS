//
//  MKPIRHallSettingsController.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRHallSettingsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"

#import "MKPIRCentralManager.h"
#import "MKPIRInterface.h"

#import "MKPIRHallSettingsModel.h"

@interface MKPIRHallSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKPIRHallSettingsModel *dataModel;

@end

@implementation MKPIRHallSettingsController

- (void)dealloc {
    NSLog(@"MKPIRHallSettingsController销毁");
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.view.shiftHeightAsDodgeViewForMLInputDodger = 50.0f;
    [self.view registerAsDodgeViewForMLInputDodgerWithOriginalY:self.view.frame.origin.y];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadSubViews];
    [self readDatasFromDevice];
}

#pragma mark - super method
- (void)rightButtonMethod {
    [self saveDataToDevice];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    MKTableSectionLineHeader *headerView = [MKTableSectionLineHeader initHeaderViewWithTableView:tableView];
    headerView.headerModel = self.headerList[section];
    return headerView;
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headerList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.section0List.count;
    }
    if (section == 1) {
        return self.section1List.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section1List[indexPath.row];
    return cell;
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Function Switch
        self.dataModel.isOn = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
}

#pragma mark - notes
- (void)receiveDoorSensorStatus:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    if (!ValidDict(userInfo)) {
        return;
    }
    MKNormalTextCellModel *cellModel1 = self.section1List[0];
    cellModel1.rightMsg = ([userInfo[@"open"] boolValue] ? @"Open" : @"Closed");
    
    MKNormalTextCellModel *cellModel2 = self.section1List[1];
    cellModel2.rightMsg = userInfo[@"times"];
    
    [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
        [[MKPIRCentralManager shared] notifyDoorSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveDoorSensorStatus:)
                                                         name:mk_pir_doorSensorDatasNotification
                                                       object:nil];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)saveDataToDevice {
    [[MKHudManager share] showHUDWithTitle:@"Config..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel configDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:@"Success"];
        [[MKPIRCentralManager shared] notifyDoorSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveDoorSensorStatus:)
                                                         name:mk_pir_doorSensorDatasNotification
                                                       object:nil];
            [self readDoorSensorDatas];
        }else {
            MKNormalTextCellModel *cellModel1 = self.section1List[0];
            cellModel1.rightMsg = @"";
            
            MKNormalTextCellModel *cellModel2 = self.section1List[1];
            cellModel2.rightMsg = @"";
            
            [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)readDoorSensorDatas {
    [MKPIRInterface pir_readDoorSensorDatasWithSucBlock:^(id  _Nonnull returnData) {
        self.dataModel.open = [returnData[@"result"][@"open"] boolValue];
        self.dataModel.times = returnData[@"result"][@"times"];
        MKNormalTextCellModel *cellModel1 = self.section1List[0];
        cellModel1.rightMsg = (self.dataModel.open ? @"Open" : @"Closed");
        
        MKNormalTextCellModel *cellModel2 = self.section1List[1];
        cellModel2.rightMsg = self.dataModel.times;
        
        [self.tableView mk_reloadSection:1 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    
    for (NSInteger i = 0; i < 2; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Function Switch";
    cellModel.isOn = self.dataModel.isOn;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKNormalTextCellModel *cellModel1 = [[MKNormalTextCellModel alloc] init];
    cellModel1.leftIcon = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRHallSettingsController", @"pir_hallSettings_doorStatusIcon.png");
    cellModel1.leftMsg = @"Door Status";
    cellModel1.rightMsg = (self.dataModel.open ? @"Open" : @"Closed");
    [self.section1List addObject:cellModel1];
    
    MKNormalTextCellModel *cellModel2 = [[MKNormalTextCellModel alloc] init];
    cellModel2.leftMsg = @"Total Trigger Times";
    cellModel2.rightMsg = self.dataModel.times;
    [self.section1List addObject:cellModel2];
    
    if (!self.dataModel.isOn) {
        //功能关闭
        cellModel1.rightMsg = @"";
        cellModel2.rightMsg = @"";
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"Hall Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-PIR", @"MKPIRHallSettingsController", @"pir_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.bottom.mas_equalTo(self.view.mas_safeAreaLayoutGuideBottom);
    }];
}

#pragma mark - getter
- (MKBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[MKBaseTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        _tableView.backgroundColor = RGBCOLOR(242, 242, 242);
    }
    return _tableView;
}

- (NSMutableArray *)section0List {
    if (!_section0List) {
        _section0List = [NSMutableArray array];
    }
    return _section0List;
}

- (NSMutableArray *)section1List {
    if (!_section1List) {
        _section1List = [NSMutableArray array];
    }
    return _section1List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKPIRHallSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKPIRHallSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
