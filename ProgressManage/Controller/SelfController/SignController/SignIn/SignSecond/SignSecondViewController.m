//
//  SignSecondViewController.m
//  ProgressManage
//
//  Created by lingnet on 2017/5/11.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "SignSecondViewController.h"

#import "SignSecondTableViewCell.h"

#import "XRQExpandableTableViewCell.h"

#import "SignSecondImageModel.h"

#import "SignSecondImageTableViewCell.h"
@interface SignSecondViewController ()<UITableViewDataSource,UITableViewDelegate,AdvancedExpandableTableViewDelegate,SignSecondImageTableViewCellDelegate,ImagePickerSheetViewControllerDelegate,MWPhotoBrowserDelegate,SignSecondTableViewCellDelegate>{
    UITableView* _tableView;
    CGFloat textCellHeight;
}
@property(nonatomic,strong)NSMutableArray* dataSourceArr;
@property(nonatomic,strong)NSMutableArray* dataSourceArr2;
@property(nonatomic,strong)NSMutableArray* dataSourceBase64Arr;

@property (strong, nonatomic) UINavigationController *photoNavigationController;
@property (strong, nonatomic) MWPhotoBrowser *photoBrowser;
@property (strong, nonatomic) UIWindow *keyWindow;
@property(nonatomic,retain)NSMutableArray* photos;

@property(nonatomic,copy)NSString* beizhu;
@end

@implementation SignSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"签到";
    [self makeData];
    [self createTableView];
    [self makeSendbtn];
}
- (void)makeData{
    self.dataSourceArr = [[NSMutableArray alloc] init];
    self.dataSourceBase64Arr = [[NSMutableArray alloc] init];
    [self.dataSourceArr addObject:self.model];
    
    self.dataSourceArr2 = [[NSMutableArray alloc] init];
    SignSecondImageModel* mm = [[SignSecondImageModel alloc] init];
    mm.imageArr = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 5; i++) {
//        [mm.imageArr addObject:[UIImage imageNamed:@"addMatters"]];
//    }
    [self.dataSourceArr2 addObject:mm];
}
- (void)makeSendbtn{
    UIButton* sendBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 50) ImageName:nil Target:self Action:@selector(sendBtn) Title:@"提  交"];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:[MyController colorWithHexString:@"4c89f0"]];
    [self.view addSubview:sendBtn];
}
- (void)sendBtn{
    NSLog(@"提交");
    [HUD loading];
    NSString* _img = @"";
    if (self.dataSourceBase64Arr.count) {
        for (int i = 0; i < self.dataSourceBase64Arr.count; i++) {
            _img = [NSString stringWithFormat:@"%@,",self.dataSourceBase64Arr[i]];
        }
        _img = [_img substringToIndex:_img.length - 1];
    }
    
    [requestService postQIANDAOWithSignDate:self.model.time1 address:[MyController returnStr:self.model.add1] location:[MyController returnStr:self.model.add] customer:[MyController returnStr:self.model.name] userId:[MyController getuserId] remark:[MyController returnStr:self.beizhu] lon:self.lng lat:self.lat img:_img complate:^(id responseObject) {
        NSLog(@"%@",responseObject);
        if ([responseObject[@"result"] intValue]) {
            //创建通知
            NSNotification *notification =[NSNotification notificationWithName:@"signSuccess" object:nil userInfo:nil];
            //通过通知中心发送通知
            [[NSNotificationCenter defaultCenter] postNotification:notification];
            
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [HUD error:responseObject[@"error"][@"errorInfo"]];
        }
    } failure:^(NSError *error) {
        [HUD error:@"请检查网络连接"];
    }];
}

- (void)sendBackKehuName:(NSString *)name{
    self.model.name = [MyController returnStr:name];
}

#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, [MyController getScreenHeight] - [MyController isIOS7] - 50) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}

#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.dataSourceArr.count;
    }
    return 1;
}

#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"SignSecondTableViewCell";
        SignSecondTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[SignSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        SignSecondModel* model = self.dataSourceArr[indexPath.row];
        celll.SignSecondTableViewCellDelegate = self;
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        XRQExpandableTableViewCell *textCell = [tableView advancedExpandableTextCellWithId:@"kExpandableTextCell"];
        textCell.placeholder = @"请填写签到备注";
        textCell.selectionStyle = UITableViewCellSelectionStyleNone;
        textCell.maxCharacter = 1000;
        
        return textCell;
    }
//    NSString *cellIdentifier = @"SignSecondImageTableViewCell";
    SignSecondImageTableViewCell *celll = [[SignSecondImageTableViewCell alloc] init];
//    if (!celll) {
//        celll = [[SignSecondImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
//    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    SignSecondImageModel* model = self.dataSourceArr2[indexPath.row];
    celll.SignSecondImageTableViewCellDelegate = self;
    [celll configCellWithModel:model];
    return celll;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        return MAX(90, textCellHeight);
    }else if (2 == indexPath.section){
        SignSecondImageModel *model = nil;
        if (indexPath.row < self.dataSourceArr2.count) {
            model = [self.dataSourceArr2 objectAtIndex:indexPath.row];
        }
        
        return  [SignSecondImageTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
            SignSecondImageTableViewCell *cell = (SignSecondImageTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    SignSecondModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }

    return [SignSecondTableViewCell hyb_heightForTableView:tableView config:^(UITableViewCell *sourceCell) {
        SignSecondTableViewCell *cell = (SignSecondTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath{
    textCellHeight = height;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (2 == indexPath.section) {
        NSLog(@"================");
    }
}
- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"debug : updatedText\n%@", text);
    self.beizhu = text;
}

- (void)sendBackDeleImage:(NSInteger)index{
    SignSecondImageModel* model = [self.dataSourceArr2 lastObject];
    [model.imageArr removeObjectAtIndex:index];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.dataSourceBase64Arr removeObjectAtIndex:index];
}

/**
 查看图片代理回调

 @param index 点击了第几张图片
 */
- (void)sendBackSelectImage:(NSInteger)index{
    NSLog(@"点击了---%ld",index);
    UIViewController *rootController = [self.keyWindow rootViewController];
    [rootController presentViewController:self.photoNavigationController animated:YES completion:nil];
    [_photoBrowser setCurrentPhotoIndex:index];
    
}

/**
 添加图片代理方法
 */
- (void)sendBackAddImage{
    SignSecondImageModel* model = [self.dataSourceArr2 lastObject];
    if (!(model.imageArr.count < 1)) {
        [HUD warning:@"最多支持上传1张"];
        return;
    }
    
    ImagePickerSheetViewController *imagePicker = [[ImagePickerSheetViewController alloc] init];
    imagePicker.maximumNumberOfSelection = 1 - model.imageArr.count;
    imagePicker.delegate = self;
    //使用内置相册回调使用内置相册回调
    imagePicker.photoLabrary = ^(LFImagePickerController *lf_imagePicker) {
        lf_imagePicker.allowTakePicture = NO;
        lf_imagePicker.allowPickingVideo = NO;
        lf_imagePicker.doneBtnTitleStr = @"发送";
    };
    
    //发送图片block，回调回两组数组，一组压缩图片数组，一组原图数组
    imagePicker.imagePickerSheetVCSendImageBlock = ^(NSArray *thumbnailImages, NSArray *originalImages) {
        [HUD loading];
        [model.imageArr addObjectsFromArray:originalImages];
        
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSData *data = UIImageJPEGRepresentation([model.imageArr lastObject], 1.0f);
        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [self.dataSourceBase64Arr addObject:encodedImageStr];
        [HUD hide];
        
        self.photos = [[NSMutableArray alloc] init];
        for (int i = 0; i < model.imageArr.count; i++) {
            [self.photos addObject:[MWPhoto photoWithImage:model.imageArr[i]]];
        }
    };
    
    //拍照发送，回调回图片
    imagePicker.imagePickerSheetVCPhotoSendImageBlock = ^(UIImage *image) {
        [HUD loading];
        [model.imageArr addObject:image];
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        
//        NSData *data = UIImageJPEGRepresentation(image, 1.0f);
//        NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//        [self.dataSourceBase64Arr addObject:encodedImageStr];
        
        NSData *_data = UIImageJPEGRepresentation(image, 0.01);
//        NSInteger imagM = _data.length/1024/1024;
        [self.dataSourceBase64Arr addObject:[_data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength]];
        [HUD hide];
        
        self.photos = [[NSMutableArray alloc] init];
        for (int i = 0; i < model.imageArr.count; i++) {
            [self.photos addObject:[MWPhoto photoWithImage:model.imageArr[i]]];
        }
    };
    
    [imagePicker showImagePickerInController:self animated:YES];
}

#pragma mark - getter 创建一个显示图片的window
- (UIWindow *)keyWindow{
    if(_keyWindow == nil){
        _keyWindow = [[UIApplication sharedApplication] keyWindow];
    }
    return _keyWindow;
}
#pragma mark - 初始化MWPhotoBrowser
- (MWPhotoBrowser *)photoBrowser{
    if (_photoBrowser == nil) {
        _photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
        _photoBrowser.displayActionButton = YES;
        _photoBrowser.displayNavArrows = YES;
        _photoBrowser.displaySelectionButtons = NO;
        _photoBrowser.alwaysShowControls = NO;
        _photoBrowser.wantsFullScreenLayout = YES;
        _photoBrowser.zoomPhotosToFill = YES;
        _photoBrowser.enableGrid = NO;
        _photoBrowser.startOnGrid = NO;
    }
    return _photoBrowser;
}

- (UINavigationController *)photoNavigationController{
    if (_photoNavigationController == nil) {
        _photoNavigationController = [[UINavigationController alloc] initWithRootViewController:self.photoBrowser];
        _photoNavigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    [self.photoBrowser reloadData];
    return _photoNavigationController;
}

#pragma mark - MWPhotoBrowserDelegate
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser{
    return [self.photos count];
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index{
    if (index < self.photos.count){
        return [self.photos objectAtIndex:index];
    }
    return nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
