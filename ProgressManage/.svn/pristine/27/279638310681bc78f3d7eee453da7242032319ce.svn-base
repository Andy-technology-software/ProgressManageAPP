//
//  IncreasePrepaymentRecordViewController.m
//  ProgressManage
//
//  Created by Gem on 2017/6/2.
//  Copyright © 2017年 xurenqinag. All rights reserved.
//

#import "IncreasePrepaymentRecordViewController.h"
#import "UITextView+placeholder.h"
#import "ValuePickerView.h"

@interface IncreasePrepaymentRecordViewController ()<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UITextViewDelegate>{
    NSMutableArray *titleArr;
    NSMutableArray *palceArr;
    NSInteger indexs;
    UIButton *head;
    UIImage *headImag;
    NSString *headStr;
}
@property (nonatomic,strong) UITableView* tableView;
@property (nonatomic,strong) NSMutableArray *titleSource;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic, strong) ValuePickerView *pickerView;

@end

@implementation IncreasePrepaymentRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增预收款记录";
    headStr = @"";
    self.pickerView = [[ValuePickerView alloc]init];
    self.pickerView.pickerTitle = @"";
    self.view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.dataSource = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    self.titleSource = [NSMutableArray arrayWithObjects:@"金额",@"收款方式",@"收款状态",@"备注", nil];
    [self createTableView];
    UIButton *submitBtn = [MyController createButtonWithFrame:CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40) ImageName:nil Target:self Action:@selector(submitAction:) Title:@"保存"];
    submitBtn.backgroundColor = [MyController colorWithHexString:@"4c89f0"];
    [self.view addSubview:submitBtn];
}
#pragma mark - 保存
- (void)submitAction:(UIButton *)btn{
    for (int i = 0; i < self.dataSource.count; i ++) {
        if ([self.dataSource[i] isEqualToString:@""]) {
            [HUD warning:[NSString stringWithFormat:@"请编辑%@",self.titleSource[i]]];
            return;
        }
    }
    [self getIncreaseRequest];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 15, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 49) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:_tableView];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleSource.count + 1;
    
}

#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 1 || indexPath.row == 2) {
        
        __weak typeof(self) weakSelf = self;
        if (indexPath.row == 1) {
            self.pickerView.dataSource= [NSArray arrayWithObjects:@"现金",@"支票", @"汇款",nil];
        }else if (indexPath.row == 2){
            self.pickerView.dataSource= [NSArray arrayWithObjects:@"未付款",@"已付款", nil];
        }
        self.pickerView.valueDidSelect = ^(NSString *value){
            NSArray * stateArr = [value componentsSeparatedByString:@"/"];
            [weakSelf.dataSource replaceObjectAtIndex:indexPath.row withObject:stateArr[0]];
            [weakSelf.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        };
        [self.pickerView show];
    }
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 44);
    bgView.backgroundColor = [UIColor whiteColor];
    [cell addSubview:bgView];
    UILabel *titlelabel = [UILabel new];
    if (indexPath.row != 4) {
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = [MyController colorWithHexString:@"81889d"];
        titlelabel.text = [NSString stringWithFormat:@"%@",self.titleSource[indexPath.row]];
        titlelabel.frame = CGRectMake(15, 0, 60, 44);
        titlelabel.numberOfLines = 2;
        [bgView addSubview:titlelabel];
    }
    if (indexPath.row == 0){
        UITextField *tf = [MyController createTextFieldWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15 ,  0, [MyController getScreenWidth] - 110, 44) placeholder:@"请填写" passWord:NO leftImageView:nil rightImageView:nil Font:12];
        tf.text = self.dataSource[indexPath.row];
        tf.tag = 100 + indexPath.row;
        tf.delegate = self;
        [bgView addSubview:tf];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, 44-0.5, [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];
        
    }else if(indexPath.row == 1 || indexPath.row == 2){
        UILabel *selectLabel = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 15, 0, [MyController getScreenWidth] - 110, 44) Font:13 Text:nil];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        if ([self.dataSource[indexPath.row] length]) {
            selectLabel.text = self.dataSource[indexPath.row];
            selectLabel.textColor = [UIColor blackColor];
        }else{
            selectLabel.text = @"请选择";
            selectLabel.textColor = [MyController colorWithHexString:@"d3d3d8"];
        }
        [bgView addSubview:selectLabel];
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15,44-0.5 , [MyController getScreenWidth] - 60, 0.5)];
        line.backgroundColor = [MyController colorWithHexString:@"e8e8e8"];
        [bgView addSubview:line];
        
    }else if (indexPath.row == 4){
        head = [MyController createButtonWithFrame:CGRectMake(10, 10, 60, 60) ImageName:@"拍照" Target:self Action:@selector(headAction:) Title:nil];
        UIImageView *tempView = [[UIImageView alloc] initWithFrame:CGRectZero];
//        [tempView sd_setImageWithURL:[NSURL URLWithString:headUrl] placeholderImage:headImag completed:^(UIImage *image, NSError *error, EMSDImageCacheType cacheType, NSURL *imageURL) {
//            
//            if (![headUrl isEqualToString:@""]) {
//                [head setBackgroundImage:tempView.image forState:UIControlStateNormal];
//            }else{
//                [head setBackgroundImage:[UIImage imageNamed:@"group"] forState:UIControlStateNormal];
//            }
//            if (![headStr isEqualToString:@""]) {
//                
//                [head setBackgroundImage:tempView.image forState:UIControlStateNormal];
//            }
//        }];
        
        [bgView addSubview:head];
        bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 80);

        UIImageView *imageView = [MyController createImageViewWithFrame:CGRectMake(85, 25, 53 / 2, 23 / 2) ImageName:@"上传单据"];
        [bgView addSubview:imageView];
        
        UILabel *titlelabel = [UILabel new];
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = [MyController colorWithHexString:@"81889d"];
        titlelabel.text = @"可上传收款单据";
        titlelabel.frame = CGRectMake(85, 50, 150, 20);
        [bgView addSubview:titlelabel];
        
    }else{
        UILabel *titlelabel = [UILabel new];
        titlelabel.font = [UIFont systemFontOfSize:14];
        titlelabel.textColor = [MyController colorWithHexString:@"81889d"];
        titlelabel.text = [NSString stringWithFormat:@"%@",self.titleSource[indexPath.row]];
        titlelabel.frame = CGRectMake(15, 0, 40, 44);
        titlelabel.numberOfLines = 2;
        [bgView addSubview:titlelabel];
        UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titlelabel.frame) + 20,6, [MyController getScreenWidth] - 110, 154)];
        tv.font = [UIFont systemFontOfSize:12];
        tv.placeholder = @"请填写";
        tv.delegate = self;
        tv.tag = 100 + indexPath.row;
        [bgView addSubview:tv];
        bgView.frame = CGRectMake(10, 0, SCREEN_WIDTH - 20, 160);
    }
    return cell;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        return 160;
    }else if(indexPath.row == 4){
        return 80;
    }
    return 44;
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    NSInteger index = textView.tag - 100;
    [self.dataSource replaceObjectAtIndex:index withObject:textView.text];
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSInteger index = textField.tag - 100;
    [self.dataSource replaceObjectAtIndex:index withObject:textField.text];
}
#pragma mark -action
- (void)headAction:(UIButton *)btn{
    NSLog(@"头像");
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册中选择", nil];
    [sheet showInView:_tableView];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSLog(@"拍照");
        [self takePhoto];
    }else if (buttonIndex == 1)
    {
        NSLog(@"从相册中选择");
        [self takeLocalPhoto];
    }else{
        NSLog(@"取消");
    }
}
-(void)takePhoto
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *pick = [[UIImagePickerController alloc]init];
        pick.delegate = self;
        pick.allowsEditing = NO;
        pick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:pick animated:YES completion:nil];
    }else{
        NSLog(@"模拟其中无法打开照相机,请在真机中使用");
    }
}
-(void)takeLocalPhoto
{
    UIImagePickerController *pick = [[UIImagePickerController alloc]init];
    pick.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pick.delegate = self;
    pick.allowsEditing = NO;
    [self presentViewController:pick animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    NSLog(@"type == %@",type);
    //选择类型为图片
    if ([type isEqualToString:@"public.image"]) {
        //转成NSData类型
        UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        image = [MyController fixOrientation:image];
        
        //        NSData *_data = UIImageJPEGRepresentation(image, 0.001);
        //        NSInteger imagM = _data.length/1024/1024;
        //        if(imagM > 2){
        //            _data = UIImageJPEGRepresentation(image, 2/imagM);
        //        }
//        image = [self scaleImage:image scaleFactor:0.1];
        NSData *_data = UIImageJPEGRepresentation(image, 1);
        headStr = [_data base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
        
        [picker dismissViewControllerAnimated:YES completion:nil];
        headImag = image;
        [head setImage:image forState:UIControlStateNormal];
    }
}

//- (UIImage *) scaleImage: (UIImage *)image scaleFactor:(float)scaleFloat
//{
//    CGSize size = CGSizeMake(image.size.width * scaleFloat, image.size.height * scaleFloat);
//    
//    UIGraphicsBeginImageContext(size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGAffineTransform transform = CGAffineTransformIdentity;
//    
//    transform = CGAffineTransformScale(transform, scaleFloat, scaleFloat);
//    CGContextConcatCTM(context, transform);
//    
//    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
//    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return newimg;
//}

#pragma mark - 新增请求
- (void)getIncreaseRequest{
    
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSString *payType = @"";
        if ([self.dataSource[1] isEqualToString:@"现金"]) {
            payType = @"0";
        }else if ([self.dataSource[1] isEqualToString:@"支票"]){
            payType = @"1";
        }else if ([self.dataSource[1] isEqualToString:@"汇款"]){
            payType = @"2";
        }
        NSString *status = @"";
        if ([self.dataSource[2] isEqualToString:@"未付款"]) {
            status = @"0";
        }else if ([self.dataSource[2] isEqualToString:@"已付款"]){
            status = @"1";
        }
        NSLog(@"%@",[MyController getCName]);
        NSLog(@"token=%@",[MyController returnStr:souDic[@"token"]]);
        [HUD loading];
        NSString* requestAddress = AddAct;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"cname":[MyController getCName],
                                                  @"money":[MyController returnStr:self.dataSource[0]],
                                                  @"statusId":status,
                                                  @"payType":payType,
                                                  @"remark":[MyController returnStr:self.dataSource[3]],
                                                  @"img":headStr,
                                                  @"custId":[MyController returnStr:self.account_id],
                                                  @"saleId":[MyController returnStr:self.idStr],
                                                  @"userId":[MyController getUserid],
                                                  @"recordType":[MyController returnStr:self.recordType],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"新增请求----%@",responseObject);
                  NSLog(@"新增请求data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD success:[responseObject objectForKey:@"data"]];
                  }else{
                      NSLog(@"111111111token=%@",[MyController returnStr:souDic[@"token"]]);
                      NSString *errStr = [responseObject objectForKey:@"error"];
                      NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                      [HUD error:[dic objectForKey:@"errorInfo"]];
                  }
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  NSLog(@"失败");
                  NSLog(@"失败===%@", error);
                  [HUD error:@"请检查网络"];
              }];
    } failure:^(NSError *error) {
        
    }];
}
@end
