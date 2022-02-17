//
//  MKPIRTHSettingsController.m
//  MKLoRaWAN-PIR_Example
//
//  Created by aa on 2021/12/25.
//  Copyright © 2021 aadyx2007@163.com. All rights reserved.
//

#import "MKPIRTHSettingsController.h"

#import "Masonry.h"

#import "MLInputDodger.h"

#import "MKMacroDefines.h"
#import "MKBaseTableView.h"
#import "UIView+MKAdd.h"
#import "UITableView+MKAdd.h"

#import "MKTableSectionLineHeader.h"

#import "MKHudManager.h"
#import "MKTextSwitchCell.h"
#import "MKTextFieldCell.h"

#import "MKPIRCentralManager.h"

#import "MKPIRTHSettingsModel.h"

#import "MKPIRTHSettingsHeaderView.h"
#import "MKPIRTHAlarmCell.h"

@interface MKPIRTHSettingsController ()<UITableViewDelegate,
UITableViewDataSource,
mk_textSwitchCellDelegate,
MKTextFieldCellDelegate,
MKPIRTHAlarmCellDelegate,
MKPIRTHSettingsHeaderViewDelegate>

@property (nonatomic, strong)MKPIRTHSettingsHeaderView *tableHeaderView;

@property (nonatomic, strong)MKPIRTHSettingsHeaderViewModel *headerDataModel;

@property (nonatomic, strong)MKBaseTableView *tableView;

@property (nonatomic, strong)NSMutableArray *section0List;

@property (nonatomic, strong)NSMutableArray *section1List;

@property (nonatomic, strong)NSMutableArray *section2List;

@property (nonatomic, strong)NSMutableArray *section3List;

@property (nonatomic, strong)NSMutableArray *section4List;

@property (nonatomic, strong)NSMutableArray *section5List;

@property (nonatomic, strong)NSMutableArray *section6List;

@property (nonatomic, strong)NSMutableArray *section7List;

@property (nonatomic, strong)NSMutableArray *headerList;

@property (nonatomic, strong)MKPIRTHSettingsModel *dataModel;

@end

@implementation MKPIRTHSettingsController

- (void)dealloc {
    NSLog(@"MKPIRTHSettingsController销毁");
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
    if (section == 0 || section == 2 || section == 4 || section == 6) {
        return 10.f;
    }
    return 0.f;
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
    return [self numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self cellForRowAtIndexPath:indexPath];
}

#pragma mark - mk_textSwitchCellDelegate
/// 开关状态发生改变了
/// @param isOn 当前开关状态
/// @param index 当前cell所在的index
- (void)mk_textSwitchCellStatusChanged:(BOOL)isOn index:(NSInteger)index {
    if (index == 0) {
        //Temp Threshold Alarm
        self.dataModel.tempThresholdAlarm = isOn;
        MKTextSwitchCellModel *cellModel = self.section0List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 1) {
        //Temp Change Alarm
        self.dataModel.tempChangeAlarm = isOn;
        MKTextSwitchCellModel *cellModel = self.section2List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 2) {
        //RH Threshold Alarm
        self.dataModel.rhThresholdAlarm = isOn;
        MKTextSwitchCellModel *cellModel = self.section4List[0];
        cellModel.isOn = isOn;
        return;
    }
    if (index == 3) {
        //RH Change Alarm
        self.dataModel.rhChangeAlarm = isOn;
        MKTextSwitchCellModel *cellModel = self.section6List[0];
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
        //Temp Change Alarm/Duration Condition
        self.dataModel.tempDuration = value;
        MKTextFieldCellModel *cellModel = self.section3List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 1) {
        //Temp Change Alarm/Change Value Threshold
        self.dataModel.tempChangeValueThreshold = value;
        MKTextFieldCellModel *cellModel = self.section3List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 2) {
        //RH Threshold Alarm Max.
        self.dataModel.rhMax = value;
        MKTextFieldCellModel *cellModel = self.section5List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 3) {
        //RH Threshold Alarm Min.
        self.dataModel.rhMin = value;
        MKTextFieldCellModel *cellModel = self.section5List[1];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 4) {
        //RH Change Alarm/Duration Condition
        self.dataModel.rhDuration = value;
        MKTextFieldCellModel *cellModel = self.section7List[0];
        cellModel.textFieldValue = value;
        return;
    }
    if (index == 5) {
        //RH Change Alarm/Change Value Threshold
        self.dataModel.rhChangeValueThreshold = value;
        MKTextFieldCellModel *cellModel = self.section7List[1];
        cellModel.textFieldValue = value;
        return;
    }
}

#pragma mark - MKPIRTHSettingsHeaderViewDelegate
- (void)mk_pir_functionSwitchChanged:(BOOL)isOn {
    self.headerDataModel.isOn = isOn;
    self.dataModel.isOn = isOn;
}

- (void)mk_pir_sampleRateChanged:(NSString *)sampleRate {
    self.headerDataModel.sampleRate = sampleRate;
    self.dataModel.sampleRate = sampleRate;
}

#pragma mark - MKPIRTHAlarmCellDelegate
- (void)pir_tempThresholdAlarmValueChanged:(NSInteger)index value:(NSString *)value {
    if (index == 0) {
        //Temp Threshold Alarm Max.
        self.dataModel.tempMax = value;
        MKPIRTHAlarmCellModel *cellModel = self.section1List[0];
        cellModel.textValue = value;
        return;
    }
    if (index == 1) {
        //Temp Threshold Alarm Min.
        self.dataModel.tempMin = value;
        MKPIRTHAlarmCellModel *cellModel = self.section1List[1];
        cellModel.textValue = value;
        return;
    }
}

#pragma mark - notes
- (void)receiveTHDatas:(NSNotification *)note {
    NSDictionary *userInfo = note.userInfo;
    if (!ValidDict(userInfo) || !self.dataModel.isOn) {
        return;
    }
    self.headerDataModel.temperature = userInfo[@"temperature"];
    self.headerDataModel.humidity = userInfo[@"humidity"];
    self.tableHeaderView.dataModel = self.headerDataModel;
}

#pragma mark - interface
- (void)readDatasFromDevice {
    [[MKHudManager share] showHUDWithTitle:@"Reading..." inView:self.view isPenetration:NO];
    @weakify(self);
    [self.dataModel readDataWithSucBlock:^{
        @strongify(self);
        [[MKHudManager share] hide];
        [self loadSectionDatas];
        [[MKPIRCentralManager shared] notifyTHSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveTHDatas:)
                                                         name:mk_pir_thSensorDatasNotification
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
        [[MKPIRCentralManager shared] notifyTHSensorData:self.dataModel.isOn];
        if (self.dataModel.isOn) {
            [[NSNotificationCenter defaultCenter] addObserver:self
                                                     selector:@selector(receiveTHDatas:)
                                                         name:mk_pir_thSensorDatasNotification
                                                       object:nil];
        }else {
            self.headerDataModel.temperature = @"";
            self.headerDataModel.humidity = @"";
            self.tableHeaderView.dataModel = self.headerDataModel;
        }
    } failedBlock:^(NSError * _Nonnull error) {
        @strongify(self);
        [[MKHudManager share] hide];
        [self.view showCentralToast:error.userInfo[@"errorInfo"]];
    }];
}

#pragma mark - 加载cell数据
- (NSInteger)numberOfRowsInSection:(NSInteger)section {
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
    if (section == 4) {
        return self.section4List.count;
    }
    if (section == 5) {
        return self.section5List.count;
    }
    if (section == 6) {
        return self.section6List.count;
    }
    if (section == 7) {
        return self.section7List.count;
    }
    return 0;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section0List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 1) {
        MKPIRTHAlarmCell *cell = [MKPIRTHAlarmCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section1List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 2) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section2List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 3) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section3List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 4) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section4List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 5) {
        MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section5List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    if (indexPath.section == 6) {
        MKTextSwitchCell *cell = [MKTextSwitchCell initCellWithTableView:self.tableView];
        cell.dataModel = self.section6List[indexPath.row];
        cell.delegate = self;
        return cell;
    }
    MKTextFieldCell *cell = [MKTextFieldCell initCellWithTableView:self.tableView];
    cell.dataModel = self.section7List[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark - loadSectionDatas
- (void)loadSectionDatas {
    [self loadHeaderDatas];
    [self loadSection0Datas];
    [self loadSection1Datas];
    [self loadSection2Datas];
    [self loadSection3Datas];
    [self loadSection4Datas];
    [self loadSection5Datas];
    [self loadSection6Datas];
    [self loadSection7Datas];
    
    for (NSInteger i = 0; i < 8; i ++) {
        MKTableSectionLineHeaderModel *headerModel = [[MKTableSectionLineHeaderModel alloc] init];
        [self.headerList addObject:headerModel];
    }
    
    [self.tableView reloadData];
}

- (void)loadHeaderDatas {
    self.headerDataModel.isOn = self.dataModel.isOn;
    self.headerDataModel.sampleRate = self.dataModel.sampleRate;
    self.headerDataModel.temperature = (self.dataModel.isOn ? self.dataModel.temperature : @"");
    self.headerDataModel.humidity = (self.dataModel.isOn ? self.dataModel.humidity : @"");
    self.tableHeaderView.dataModel = self.headerDataModel;
}

- (void)loadSection0Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 0;
    cellModel.msg = @"Temp Threshold Alarm";
    cellModel.isOn = self.dataModel.tempThresholdAlarm;
    [self.section0List addObject:cellModel];
}

- (void)loadSection1Datas {
    MKPIRTHAlarmCellModel *cellModel1 = [[MKPIRTHAlarmCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Max.";
    cellModel1.textValue = self.dataModel.tempMax;
    [self.section1List addObject:cellModel1];
    
    MKPIRTHAlarmCellModel *cellModel2 = [[MKPIRTHAlarmCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Min.";
    cellModel2.textValue = self.dataModel.tempMin;
    [self.section1List addObject:cellModel2];
}

- (void)loadSection2Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 1;
    cellModel.msg = @"Temp Change Alarm";
    cellModel.isOn = self.dataModel.tempChangeAlarm;
    [self.section2List addObject:cellModel];
}

- (void)loadSection3Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 0;
    cellModel1.msg = @"Duration Condition";
    cellModel1.textPlaceholder = @"1 ~ 24";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.textFieldValue = self.dataModel.tempDuration;
    cellModel1.maxLength = 2;
    cellModel1.unit = @"H";
    [self.section3List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 1;
    cellModel2.msg = @"Change Value Threshold";
    cellModel2.msgFont = MKFont(14.f);
    cellModel2.textPlaceholder = @"1 ~ 20";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.textFieldValue = self.dataModel.tempChangeValueThreshold;
    cellModel2.maxLength = 2;
    cellModel2.unit = @"℃";
    [self.section3List addObject:cellModel2];
}

- (void)loadSection4Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 4;
    cellModel.msg = @"RH Threshold Alarm";
    cellModel.isOn = self.dataModel.rhThresholdAlarm;
    [self.section4List addObject:cellModel];
}

- (void)loadSection5Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 2;
    cellModel1.msg = @"Max.";
    cellModel1.textPlaceholder = @"0 ~ 100";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.textFieldValue = self.dataModel.rhMax;
    cellModel1.maxLength = 3;
    cellModel1.unit = @"%";
    [self.section5List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 3;
    cellModel2.msg = @"Min.";
    cellModel2.textPlaceholder = @"0 ~ 100";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.textFieldValue = self.dataModel.rhMin;
    cellModel2.maxLength = 3;
    cellModel2.unit = @"%";
    [self.section5List addObject:cellModel2];
}

- (void)loadSection6Datas {
    MKTextSwitchCellModel *cellModel = [[MKTextSwitchCellModel alloc] init];
    cellModel.index = 5;
    cellModel.msg = @"RH Change Alarm";
    cellModel.isOn = self.dataModel.rhChangeAlarm;
    [self.section6List addObject:cellModel];
}

- (void)loadSection7Datas {
    MKTextFieldCellModel *cellModel1 = [[MKTextFieldCellModel alloc] init];
    cellModel1.index = 4;
    cellModel1.msg = @"Duration Condition";
    cellModel1.textPlaceholder = @"1 ~ 24";
    cellModel1.textFieldType = mk_realNumberOnly;
    cellModel1.textFieldValue = self.dataModel.rhDuration;
    cellModel1.maxLength = 2;
    cellModel1.unit = @"H";
    [self.section7List addObject:cellModel1];
    
    MKTextFieldCellModel *cellModel2 = [[MKTextFieldCellModel alloc] init];
    cellModel2.index = 5;
    cellModel2.msg = @"Change Value Threshold";
    cellModel2.msgFont = MKFont(14.f);
    cellModel2.textPlaceholder = @"1 ~ 100";
    cellModel2.textFieldType = mk_realNumberOnly;
    cellModel2.textFieldValue = self.dataModel.rhChangeValueThreshold;
    cellModel2.maxLength = 3;
    cellModel2.unit = @"%";
    [self.section7List addObject:cellModel2];
}

#pragma mark - UI
- (void)loadSubViews {
    self.defaultTitle = @"T&H Settings";
    [self.rightButton setImage:LOADICON(@"MKLoRaWAN-PIR", @"MKPIRTHSettingsController", @"pir_slotSaveIcon.png") forState:UIControlStateNormal];
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
        _tableView.tableHeaderView = self.tableHeaderView;
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

- (NSMutableArray *)section4List {
    if (!_section4List) {
        _section4List = [NSMutableArray array];
    }
    return _section4List;
}

- (NSMutableArray *)section5List {
    if (!_section5List) {
        _section5List = [NSMutableArray array];
    }
    return _section5List;
}

- (NSMutableArray *)section6List {
    if (!_section6List) {
        _section6List = [NSMutableArray array];
    }
    return _section6List;
}

- (NSMutableArray *)section7List {
    if (!_section7List) {
        _section7List = [NSMutableArray array];
    }
    return _section7List;
}

- (MKPIRTHSettingsHeaderView *)tableHeaderView {
    if (!_tableHeaderView) {
        _tableHeaderView = [[MKPIRTHSettingsHeaderView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 152)];
        _tableHeaderView.delegate = self;
    }
    return _tableHeaderView;
}

- (MKPIRTHSettingsHeaderViewModel *)headerDataModel {
    if (!_headerDataModel) {
        _headerDataModel = [[MKPIRTHSettingsHeaderViewModel alloc] init];
    }
    return _headerDataModel;
}

- (NSMutableArray *)headerList {
    if (!_headerList) {
        _headerList = [NSMutableArray array];
    }
    return _headerList;
}

- (MKPIRTHSettingsModel *)dataModel {
    if (!_dataModel) {
        _dataModel = [[MKPIRTHSettingsModel alloc] init];
    }
    return _dataModel;
}

@end
