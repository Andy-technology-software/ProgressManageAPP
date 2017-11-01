/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationListViewController.h"

#import "EaseEmotionEscape.h"
#import "EaseConversationCell.h"
#import "EaseConvertToCommonEmoticonsHelper.h"
#import "EaseMessageViewController.h"
#import "NSDate+Category.h"
#import "EaseLocalDefine.h"


#import "LingXinModel.h"
#import "LingXinTableViewCell.h"
#import "GemScrollView.h"
#import "ChatViewController.h"
#import "SaleDetailViewController.h"
#import "DailyViewController.h"
#import "SignIndexViewController.h"


@interface EaseConversationListViewController (){
    BOOL open;
    float height;
}
@property (nonatomic,strong) NSMutableArray *dataSourceItem;
@end

@implementation EaseConversationListViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"11111111111-----+++++____%@",NSStringFromCGRect(self.view.frame));

    [self registerNotifications];
    [self getMessageRequest];
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    [self unregisterNotifications];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showRefreshHeader = YES;
    self.delegate = self;
    self.dataSource = self;
    self.dataSourceItem = [NSMutableArray array];
    

    // Do any additional setup after loading the view.
//    [self tableViewDidTriggerHeaderRefresh];
    [self reloadAllConversations];
    self.tableView.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    self.tableView.frame = CGRectMake(10, 0, self.view.frame.size.width - 20, self.view.frame.size.height);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        if (open) {
            return self.dataSourceItem.count;
        }else{
            return 1;
        }
    }else{
       return [self.dataArray count];
    }

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (open) {
            
            LingXinTableViewCell *cell = [[LingXinTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.model = self.dataSourceItem[indexPath.row];
            return cell;
        }else{
            UITableViewCell *cell = [[UITableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.backgroundColor = [UIColor clearColor];
            CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH - 20, 120);
            GemScrollView *scroll = [[GemScrollView alloc] initWithFrame:rect withImages:self.dataSourceItem withIsRunloop:YES withBlock:^(NSInteger index) {
                NSLog(@"点击了index%zd",index);
                if (index == 0) {
                    [self.navigationController pushViewController:[[DailyViewController alloc] init] animated:YES];
                }else if (index == 1){
                    [self.navigationController pushViewController:[[SignIndexViewController alloc] init] animated:YES];
                    
                }else if (index == 2){
                    [self.navigationController pushViewController:[[SaleDetailViewController alloc] init] animated:YES];
                    
                }
                
            }];
            [cell addSubview:scroll];
            return cell;
            
        }
    }else{
    NSString *CellIdentifier = [EaseConversationCell cellIdentifierWithModel:nil];
    EaseConversationCell *cell = (EaseConversationCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseConversationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if ([self.dataArray count] <= indexPath.row) {
        return cell;
    }
    
    id<IConversationModel> model = [self.dataArray objectAtIndex:indexPath.row];
    cell.model = model;
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTitleForConversationModel:)]) {
        NSMutableAttributedString *attributedText = [[_dataSource conversationListViewController:self latestMessageTitleForConversationModel:model] mutableCopy];
        [attributedText addAttributes:@{NSFontAttributeName : cell.detailLabel.font} range:NSMakeRange(0, attributedText.length)];
        cell.detailLabel.attributedText =  attributedText;
    } else {
        cell.detailLabel.attributedText =  [[EaseEmotionEscape sharedInstance] attStringFromTextForChatting:[self _latestMessageTitleForConversationModel:model]textFont:cell.detailLabel.font];
    }
    
    if (_dataSource && [_dataSource respondsToSelector:@selector(conversationListViewController:latestMessageTimeForConversationModel:)]) {
        cell.timeLabel.text = [_dataSource conversationListViewController:self latestMessageTimeForConversationModel:model];
    } else {
        cell.timeLabel.text = [self _latestMessageTimeForConversationModel:model];
    }
    
    return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.section == 0) {
        if (open) {
            return 85;
        }else{
            return 120;
        }
    }
    return [EaseConversationCell cellHeightWithModel:nil];
}

#pragma mark -section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 30;
    }
    return 20;
}
#pragma mark -section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 20)];
    view.backgroundColor = [MyController colorWithHexString:@"f9fafb"];
    if (section == 0) {
        view.frame = CGRectMake(0, 0, [MyController getScreenWidth], 30);
        UIButton *openBtn = [MyController createButtonWithFrame:CGRectMake(SCREEN_WIDTH - 20 - 60, 10, 60, 20) ImageName:nil Target:self Action:@selector(OpenAction:) Title:@""];
        if (open) {
            [openBtn setTitle:@"收起全部" forState:UIControlStateNormal];
        }else{
            [openBtn setTitle:@"全部显示" forState:UIControlStateNormal];
        }
        openBtn.titleLabel.textAlignment = NSTextAlignmentRight;
        openBtn.titleLabel.font = [UIFont systemFontOfSize: 12];
        [openBtn setTitleColor:[MyController colorWithHexString:@"a3a8b8"] forState:UIControlStateNormal];
        [view addSubview:openBtn];
    }else{
        UILabel *title = [MyController createLabelWithFrame:CGRectMake(20, 0, 60, 20) Font:12 Text:@"聊天信息"];
        title.textAlignment = NSTextAlignmentLeft;
        title.textColor = [MyController colorWithHexString:@"a3a8b8"];
        [view addSubview:title];
        
    }
    return view ;
}
#pragma mark - 是否展开
- (void)OpenAction:(UIButton *)btn{
    open  = !open;
    //    [_tableView reloadData];
    if (open) {
        
        [UIView transitionWithView: self.tableView
                          duration: 0.35f
                           options: UIViewAnimationOptionTransitionCurlDown
                        animations: ^(void)
         {
             [self.tableView reloadData];
         }
                        completion: ^(BOOL isFinished)
         {
             
         }];
    }else{
        [UIView transitionWithView: self.tableView
                          duration: 0.35f
                           options: UIViewAnimationOptionTransitionCurlUp
                        animations: ^(void)
         {
             [self.tableView reloadData];
         }
                        completion: ^(BOOL isFinished)
         {
             
         }];
    }
}
#pragma mark -section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
#pragma mark -section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (open) {
            if (indexPath.row == 0) {
                [self.navigationController pushViewController:[[DailyViewController alloc] init] animated:YES];
            }else if (indexPath.row == 1){
                [self.navigationController pushViewController:[[SignIndexViewController alloc] init] animated:YES];

            }else if (indexPath.row == 2){
                [self.navigationController pushViewController:[[SaleDetailViewController alloc] init] animated:YES];

            }
        }else{
            
        }
    }else{
        
        if (_delegate && [_delegate respondsToSelector:@selector(conversationListViewController:didSelectConversationModel:)]) {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
            [_delegate conversationListViewController:self didSelectConversationModel:model];
        } else {
            EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
            EaseMessageViewController *viewController = [[EaseMessageViewController alloc] initWithConversationChatter:model.conversation.conversationId conversationType:model.conversation.type];
            viewController.title = model.title;
            NSDictionary *ext = model.conversation.latestMessage.ext;
            
            if (model.conversation.latestMessage.direction) {
                viewController.selfHeadImageStr = ext[@"friendHeadImageStr"];
                viewController.friendHeadImageStr = ext[@"selfHeadImageStr"];
                viewController.selfNickName = ext[@"friendNickName"];
                viewController.friendNickName = ext[@"selfNickName"];

            }else{
                viewController.selfHeadImageStr = ext[@"selfHeadImageStr"];
                viewController.friendHeadImageStr = ext[@"friendHeadImageStr"];
                viewController.selfNickName = ext[@"selfNickName"];
                viewController.friendNickName = ext[@"friendNickName"];
            }

            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return NO;
    }
    return YES;
}


- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
   
    //添加一个删除按钮
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleDestructive) title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
        
        EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        [[EMClient sharedClient].chatManager deleteConversation:model.conversation.conversationId isDeleteMessages:YES completion:nil];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }];
  
    //添加一个置顶按钮
    NSString *titleStr;
    EaseConversationModel *model = [self.dataArray objectAtIndex:indexPath.row];
        if (model.isTop) {
                titleStr = @"取消置顶";
            }else{
                titleStr = @"聊天置顶";
            }


    UITableViewRowAction *topRowAction =[UITableViewRowAction rowActionWithStyle:(UITableViewRowActionStyleNormal) title:titleStr handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了置顶");
        [model setIsTop:!model.isTop];
        [self reloadAllConversations];


    }];

    //将设置好的按钮方到数组中返回
    return @[deleteAction,topRowAction];
        
    }else{
        return nil;
    }
    
}
#pragma mark - data

-(void)refreshAndSortView
{
    if ([self.dataArray count] > 1) {
        if ([[self.dataArray objectAtIndex:0] isKindOfClass:[EaseConversationModel class]]) {
            NSArray* sorted = [self.dataArray sortedArrayUsingComparator:
                               ^(EaseConversationModel *obj1, EaseConversationModel* obj2){
                                   EMMessage *message1 = [obj1.conversation latestMessage];
                                   EMMessage *message2 = [obj2.conversation latestMessage];
                                   if(message1.timestamp > message2.timestamp) {
                                       return(NSComparisonResult)NSOrderedAscending;
                                   }else {
                                       return(NSComparisonResult)NSOrderedDescending;
                                   }
                               }];
            [self.dataArray removeAllObjects];
            [self.dataArray addObjectsFromArray:sorted];
        }
    }
    [self.tableView reloadData];
}

/*!
 @method
 @brief 加载会话列表
 @discussion
 @result
 */
- (void)tableViewDidTriggerHeaderRefresh
{
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           EMMessage *message1 = [obj1 latestMessage];
                           EMMessage *message2 = [obj2 latestMessage];
                           if(message1.timestamp > message2.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    
    
    [self.dataArray removeAllObjects];
    for (EMConversation *converstion in sorted) {
        EaseConversationModel *model = nil;
        if (self.dataSource && [self.dataSource respondsToSelector:@selector(conversationListViewController:modelForConversation:)]) {
            model = [self.dataSource conversationListViewController:self
                                                   modelForConversation:converstion];
        }
        else{
            model = [[EaseConversationModel alloc] initWithConversation:converstion];
        }
        
        if (model) {
            if (model.conversation.latestMessage.direction) {
                if ([model.conversation.latestMessage.ext[@"selfTop"] isEqualToString:@"1"]) {
                    [self.dataArray insertObject:model atIndex:0];
                }else{
                    [self.dataArray addObject:model];
                }
            }else{
                if ([model.conversation.latestMessage.ext[@"friendTop"] isEqualToString:@"1"]) {
                    [self.dataArray insertObject:model atIndex:0];
                }else{
                    [self.dataArray addObject:model];

                }
            }
            
        }
    }
    
    [self.tableView reloadData];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}

- (void)reloadAllConversations {
    // 获取所有会话，转化成model并排序，之后添加到datasource中
    [self.dataArray removeAllObjects];
    // [[EMClient sharedClient].chatManager getAllConversations] 获取所有已存在的会话。
    [self.dataArray addObjectsFromArray:[self conversationModelsWithConversations:[[EMClient sharedClient].chatManager getAllConversations]]];
    [self.tableView reloadData];
    [self tableViewDidFinishTriggerHeader:YES reload:NO];
}
- (NSArray *)conversationModelsWithConversations:(NSArray *)conversations {
    NSArray* sorted = [conversations sortedArrayUsingComparator:
                       ^(EMConversation *obj1, EMConversation* obj2){
                           if(obj1.latestMessage.timestamp > obj2.latestMessage.timestamp) {
                               return(NSComparisonResult)NSOrderedAscending;
                           }else {
                               return(NSComparisonResult)NSOrderedDescending;
                           }
                       }];
    
    NSMutableArray *tmpAry = [NSMutableArray array];
    NSMutableArray *topAry = [NSMutableArray array];
    NSMutableArray *ret = [NSMutableArray array];
    
    for (EMConversation *conversation in sorted) {
        EaseConversationModel *model = [self.dataSource conversationListViewController:self
                                   modelForConversation:conversation];
        // 如果conversationModel有其他信息，也可以在此处处理。
        if (model.isTop) {
            [topAry addObject:model];
        }else {
            [tmpAry addObject:model];
        }
    }
    
    [ret addObjectsFromArray:topAry];
    [ret addObjectsFromArray:tmpAry];
    
    return ret;
}
#pragma mark - EMGroupManagerDelegate

- (void)didUpdateGroupList:(NSArray *)groupList
{
//    [self tableViewDidTriggerHeaderRefresh];
    [self reloadAllConversations];
}

#pragma mark - registerNotifications
-(void)registerNotifications{
    [self unregisterNotifications];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications{
    [[EMClient sharedClient].chatManager removeDelegate:self];
    [[EMClient sharedClient].groupManager removeDelegate:self];
}

- (void)dealloc{
    [self unregisterNotifications];
}

#pragma mark - private

/*!
 @method
 @brief 获取会话最近一条消息内容提示
 @discussion
 @param conversationModel  会话model
 @result 返回传入会话model最近一条消息提示
 */
- (NSString *)_latestMessageTitleForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTitle = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];
    if (lastMessage) {
        EMMessageBody *messageBody = lastMessage.body;
        switch (messageBody.type) {
            case EMMessageBodyTypeImage:{
                latestMessageTitle = NSEaseLocalizedString(@"message.image1", @"[image]");
            } break;
            case EMMessageBodyTypeText:{
                NSString *didReceiveText = [EaseConvertToCommonEmoticonsHelper
                                            convertToSystemEmoticons:((EMTextMessageBody *)messageBody).text];
                latestMessageTitle = didReceiveText;
            } break;
            case EMMessageBodyTypeVoice:{
                latestMessageTitle = NSEaseLocalizedString(@"message.voice1", @"[voice]");
            } break;
            case EMMessageBodyTypeLocation: {
                latestMessageTitle = NSEaseLocalizedString(@"message.location1", @"[location]");
            } break;
            case EMMessageBodyTypeVideo: {
                latestMessageTitle = NSEaseLocalizedString(@"message.video1", @"[video]");
            } break;
            case EMMessageBodyTypeFile: {
                latestMessageTitle = NSEaseLocalizedString(@"message.file1", @"[file]");
            } break;
            default: {
            } break;
        }
    }
    return latestMessageTitle;
}

/*!
 @method
 @brief 获取会话最近一条消息时间
 @discussion
 @param conversationModel  会话model
 @result 返回传入会话model最近一条消息时间
 */
- (NSString *)_latestMessageTimeForConversationModel:(id<IConversationModel>)conversationModel
{
    NSString *latestMessageTime = @"";
    EMMessage *lastMessage = [conversationModel.conversation latestMessage];;
    if (lastMessage) {
        double timeInterval = lastMessage.timestamp ;
        if(timeInterval > 140000000000) {
            timeInterval = timeInterval / 1000;
        }
        NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        latestMessageTime = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:timeInterval]];
    }
    return latestMessageTime;
}



#pragma mark - EaseConversationListViewControllerDataSource
- (id<IConversationModel>)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
                                    modelForConversation:(EMConversation *)conversation{
    EaseConversationModel *model = [[EaseConversationModel alloc] initWithConversation:conversation];
    if (model.conversation.type == EMConversationTypeChat) {
        
       
        
        EMConversation *conversation = model.conversation;
        EMMessage* lastMessage = [conversation latestMessage];
        
        if (lastMessage.direction) {
            model.title = lastMessage.ext[@"selfNickName"];
            model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
            model.avatarURLPath = lastMessage.ext[@"selfHeadImageStr"];
        }else{
            model.title = lastMessage.ext[@"friendNickName"];
            model.avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
            model.avatarURLPath = lastMessage.ext[@"friendHeadImageStr"];
        }
    }
    return model;

}

#pragma mark - 获取消息请求
- (void)getMessageRequest{
    [HUD loading];
    [requestService postCreateTokenWithUserId:[MyController getUserid] cname:[MyController getCName] complate:^(id responseObject) {
        NSDictionary* souDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
        NSString* requestAddress = Message;
        AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
        [manager POST:requestAddress parameters:@{
                                                  @"token":[MyController returnStr:souDic[@"token"]],
                                                  @"userId":[MyController getUserid],
                                                  }
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  NSLog(@"获取消息请求请求----%@",responseObject);
                  NSLog(@"获取消息请求data----%@",[responseObject objectForKey:@"data"]);
                  if ([[responseObject objectForKey:@"result"] intValue]) {
                      [HUD hide];
                      [self.dataSourceItem removeAllObjects];
                      NSArray *arr = [MyController arraryWithJsonString:[responseObject objectForKey:@"data"]];
                      for (int i = 0; i < arr.count; i ++) {
                          NSDictionary *dic = arr[i];
                          LingXinModel *model = [[LingXinModel alloc] init];
                          model.name = [MyController returnStr:dic[@"username"]];
                          model.title = [MyController returnStr:dic[@"mtype"]];
                          model.message = [MyController returnStr:dic[@"description"]];
                          model.time = [MyController returnStr:dic[@"createdate"]];
                          model.flag = [NSString stringWithFormat:@"%d",i];
                          [self.dataSourceItem addObject:model];
                      }
                      [self.tableView reloadData];
                  }else{
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
