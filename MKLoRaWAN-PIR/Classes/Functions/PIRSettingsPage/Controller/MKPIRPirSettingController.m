//
//  MKPIRPirSettingController.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/24.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRPirSettingController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextFieldCell.h"
#import "MKNormalTextCell.h"
#import "MKTextSwitchCell.h"

#import "MKPIRCentralManager.h"
#import "MKPIRInterface.h"

#import "MKPIRPirSettingsModel.h"

#import "MKPIRPirSettingsPickerCell.h"

@interface MKPIRPirSettingController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKPIRPirSettingsPickerCellDelegate>

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKPIRPirSettingsModel *dataModel;

@end

@implementation MKPIRPirSettingController

- (void)dealloc {
    NSLog(@"MKPIRPirSettingController销毁");
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
    if (indexPath.section == 1) {
        MKTextFieldCellModel *cellModel = self.section1List[indexPath.row];
        return [cellModel cellHeightWithContentWidth:kViewWidth];
    }
    if (indexPath.section == 2) {
        return 100.f;
    }
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 0;
    }
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
    if (section == 2) {
        return self.section2List.count;
    }
    if (section == 3) {
        return self.section3List.count;
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
    if (indexPath.section == 1) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKPIRPirSettingsPickerCell *cell = [MKPIRPirSettingsPickerCell initCellWithTableView:tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKNormalTextCell *cell = [MKNormalTextCell initCellWithTableView:tableView];
    cell.dataModel = self.section3List[indexPath.row];
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

#pragma mark - MKTextFieldCellDelegate
/// textField内容发送改变时的回调事件
/// @param index 当前cell所在的index
/// @param value 当前textField的值
- (void)mk_deviceTextCellValueChanged:(NSInteger)index textValue:(NSString *)value {
    if (index == 0) {
        //Repoert Interval
        self.dataModel.interval = value;
        MKTextFieldCellModel *cellModel = self.section1List[0];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKPIRPirSettingsPickerCellDelegate
- (void)pir_pickerValueChanged:(NSInteger)index value:(NSInteger)value {
    MKPIRPirSettingsPickerCellModel *cellModel = self.section2List[index];
    cellModel.valueIndex = value;
    if (index == 0) {
        //PIR Sensitivity
        self.dataModel.pirSensitivity = value;
        return;
    }
    if (index == 1) {
        //PIR Delay Time
        self.dataModel.pirDelayTime = value;
        return;
    }
}

#pragma mark - notes
- (void)receivePIRStatus:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    if (!ValidDict(userInfo) || !self.dataModel.isOn) {
        return;
    }
    BOOL detected = [userInfo[@"detected"] boolValue];
    MKNormalTextCellModel *cellModel = self.section3List[0];
    cellModel.rightMsg = (detected ? @"Motion detected" : @"Motion not detected");
    [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
        [[MKPIRCentralManager shared] notifyPirSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receivePIRStatus:)
                                                         name:mk_pir_pirStatusNotification
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
        [[MKPIRCentralManager shared] notifyPirSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receivePIRStatus:)
                                                         name:mk_pir_pirStatusNotification
                                                       object:nil];
            [self readPIRStatus];
        }else {
            //关闭状态
            MKNormalTextCellModel *statusModel = self.section3List[0];
            statusModel.rightMsg = @"";
            [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

- (void)readPIRStatus {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    [MKPIRInterface pir_readPIRStatusWithSucBlock:^(id  _Nonnull returnData) {
        [[MKHudManager share] hide];
        self.dataModel.detected = [returnData[@"result"][@"detected"] boolValue];
        MKNormalTextCellModel *statusModel = self.section3List[0];
        statusModel.rightMsg = (self.dataModel.detected ? @"Motion detected" : @"Motion not detected");
        [self.tableView mk_reloadSection:3 withRowAnimation:UITableViewRowAnimationNone];
    } failedBlock:^(NSError * _Nonnull error) {
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    
    for (NSInteger i = 0; i < 4; i ++) {
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
    MKTextFieldCellModel *cellModel = [[MKTextFieldCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Report Interval";
    cellModel.textPlaceholder = @"1-60";
    cellModel.textFieldType = mk_realNumberOnly;
    cellModel.textFieldValue = self.dataModel.interval;
    cellModel.maxLength = 2;
    cellModel.unit = @"Mins";
    cellModel.noteMsg = @"*Information Payload reporting interval when PIR is continuously triggered.";
    [self.section1List addObject:cellModel];
}

- (void)loadSection2Datas {
    MKPIRPirSettingsPickerCellModel *cellModel1 = [[MKPIRPirSettingsPickerCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"PIR Sensitivity";
    cellModel1.valueIndex = self.dataModel.pirSensitivity;
    [self.section2List addObject:cellModel1];

    MKPIRPirSettingsPickerCellModel *cellModel2 = [[MKPIRPirSettingsPickerCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"PIR Delay Time";
    cellModel2.valueIndex = self.dataModel.pirDelayTime;
    [self.section2List addObject:cellModel2];
}

- (void)loadSection3Datas {
    MKNormalTextCellModel *cellModel = [[MKNormalTextCellModel alloc] init];
    cellModel.leftIcon = LOADICON(@"MKLoRaWAN-PIR", @"MKPIRPirSettingController", @"pir_pirSettingsIcon.png");
    cellModel.leftMsg = @"PIR Status";
    cellModel.rightMsg = (self.dataModel.detected ? @"Motion detected" : @"Motion not detected");
    [self.section3List addObject:cellModel];
    if (!self.dataModel.isOn) {
        cellModel.rightMsg = @"";
    }
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"PIR Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-PIR", @"MKPIRPirSettingController", @"pir_slotSaveIcon.png") forState:UIControlStateNormal];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(defaultTopInset);
        make.bottom.mas_equalTo(-VirtualHomeHeight);
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

- (NSMutableArray *)section2List {
    if (!_section2List) {
        _section2List = [NSMutableArray array];
    }
    return _section2List;
}

- (NSMutableArray *)section3List {
    if (!_section3List) {
        _section3List = [NSMutableArray array];
    }
    return _section3List;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKPIRPirSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKPIRPirSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
