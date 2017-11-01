//
//  monthCalenbarview.m
//  CYHcalendar
//
//  Created by Macx on 16/3/28.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "monthCalenbarview.h"
#import "cyhCalenbardate.h"
#import "calenCollectionViewCell.h"

@interface monthCalenbarview ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic , strong)UICollectionView * monthcollectionview;
@property (nonatomic , strong)cyhCalenbardate * cyhcalendate;
@property (nonatomic , strong)NSDate * mydate;
@property (nonatomic , strong)NSDateComponents * todaycomp ;




@end

@implementation monthCalenbarview

-(id)initM_calenbarviewframe:(CGRect)frame
{
    if (!_monthcalenbarview) {
        
        _monthcalenbarview = [[monthCalenbarview alloc] init];
       
    }
    
    self.monthcalenbarview.frame = frame;
    
    return self;
}


- (void)monthcalenbarviewNSdate
{
     self.cyhcalendate = [[cyhCalenbardate alloc] init];
    self.mydate = [NSDate date];
    self.todaycomp = [[NSDateComponents alloc] init];
    self.todaycomp = [self.cyhcalendate year_month_todayInthisMonth:[NSDate date]];
    
    [self getdatesource:self.mydate];
    [self creatCollectionview];
    [self add_Y_M_Dlabel];
    
    
}

- (void)creatCollectionview
{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    if (self.monthcalenbarview.frame.size.height < 120.0) {
        CGRect  frame = self.monthcalenbarview.frame;
        frame.size.height = 120.0;
        self.monthcalenbarview.frame = frame;
    }
    
    CGFloat  S_bottom = 28.0/120.0;
    CGFloat  S_top = 12.0/120.0;
    
    layout.sectionInset = UIEdgeInsetsMake(self.monthcalenbarview.frame.size.height * S_top, 0, self.monthcalenbarview.frame.size.height * S_bottom, 0);
    
    self.monthcollectionview = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0, self.monthcalenbarview.frame.size.width,self.monthcalenbarview.frame.size.height) collectionViewLayout:layout];
    
    [self.monthcollectionview  setContentOffset:CGPointMake(self.monthcalenbarview.frame.size.width * self.offpage, 0)];//偏移量
    
//    CGFloat R = 241.0/255.0;
//    CGFloat G = 241.0/255.0;
//    CGFloat B = 241.0/255.0;
//    self.monthcollectionview.backgroundColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
    self.monthcollectionview.pagingEnabled = YES;
    self.monthcollectionview.delegate = self;
    self.monthcollectionview.dataSource = self;
    [self.monthcollectionview registerClass:[calenCollectionViewCell class] forCellWithReuseIdentifier:@"mcellID"];
    //==
    
    self.monthcollectionview.showsHorizontalScrollIndicator = NO;
    
    [self.monthcalenbarview addSubview:self.monthcollectionview];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    cyhCalenbardate * daycalen = [[cyhCalenbardate alloc] init];
    self.todaycomp = [[NSDateComponents alloc] init];
    self.todaycomp = [daycalen year_month_todayInthisMonth:[NSDate date]];
    
    calenCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mcellID" forIndexPath:indexPath];
    if (cell.Monthnumberlabel) {
        
        [cell.Monthnumberlabel removeFromSuperview];
    }
    
    

    if (indexPath.row >= 4 && indexPath.row < 16) {
        NSString * strnumber = [NSString stringWithFormat:@"%ld",indexPath.row + 1 - 4];
        //    [cell MonthLabel:indexPath comp_month:_comp.month number:strnumber];
        
        
    
//        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber];
        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber thisMonthNumBGcolor:_thisMonthNumBGcolor];
        if ((indexPath.row + 1 - 4) == _comp.month && _comp.year == _todaycomp.year&&_comp.month==_todaycomp.month && _comp.day == _todaycomp.day){
           
            NSIndexPath *monthindexPath =[NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self.monthcollectionview selectItemAtIndexPath:monthindexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone ];
            
        }
        
        
    }
    
 //前面一排与后面一排
    if (indexPath.row >= 0 && indexPath.row <=3 ) {
        
         NSString * strnumber = [NSString stringWithFormat:@"%ld",indexPath.row + 9];
//        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber];
        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber thisMonthNumBGcolor:_thisMonthNumBGcolor];
    }
    if (indexPath.row >= 16 && indexPath.row < 20 ) {
        
        NSString * strnumber = [NSString stringWithFormat:@"%ld",indexPath.row - 15];
//        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber];
        [cell MonthLabel:indexPath comp:_comp todaycomp:_todaycomp number:strnumber thisMonthNumBGcolor:_thisMonthNumBGcolor];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.monthcalenbarview.frame.size.width/4, self.monthcalenbarview.frame.size.width/4 );
    
}

- (void)add_Y_M_Dlabel
{
    _Y_M_Dlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.monthcalenbarview.bounds.size.width/2 - 75, self.monthcalenbarview.bounds.size.height - 20, 150, 20)];
    _Y_M_Dlabel.font = [UIFont systemFontOfSize:17];
    _Y_M_Dlabel.text = [NSString stringWithFormat:@"%ld—%ld",self.comp.year,self.comp.month];
    _Y_M_Dlabel.textAlignment = 1;
    //    _Y_M_Dlabel.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.2 alpha:0.5];
    [self.monthcalenbarview addSubview:_Y_M_Dlabel];
    
    
}

- (void)getdatesource:(NSDate *)date
{
    cyhCalenbardate * daycalen = [[cyhCalenbardate alloc] init];
   
    NSDateComponents * today_month = [[NSDateComponents alloc] init];
    today_month = [daycalen year_month_todayInthisMonth:[NSDate date]];
    NSDateComponents * allday_month = [[NSDateComponents alloc] init];
    allday_month = [daycalen year_month_todayInthisMonth:date];
    if (today_month.year == allday_month.year) {
        date = [NSDate date];
    }
     
    self.comp = [[NSDateComponents alloc] init];
    self.comp = [daycalen year_month_todayInthisMonth:date];
    
    if (_comp.month <= 4) {
        self.offpage = 1;
    }
    if (_comp.month > 4 && _comp.month <= 8) {
        
        self.offpage = 2;
    }
    if (_comp.month > 8 && _comp.month <= 12) {
        
        self.offpage = 3;
    }
    
     [self.monthcollectionview reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    calenCollectionViewCell * cell = (calenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    cell.Monthnumberlabel.backgroundColor = _MSelecNumBGcolor;
    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM"];
//    NSDate *date = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld",_comp.year,(indexPath.row + 1)]];
    

//
    
    NSString * datestr = [NSString stringWithFormat:@"%ld—%ld",_comp.year,(indexPath.row + 1 - 4)];
    _Y_M_Dlabel.text = datestr;
    
    NSString * gobackDate = [NSString stringWithFormat:@"%ld-%ld-01",_comp.year,(indexPath.row + 1 - 4)];
    [self.monthdelegate getmonthString:gobackDate];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    calenCollectionViewCell * cell = (calenCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.Monthnumberlabel.backgroundColor = [UIColor clearColor];
    NSString * strnumber = [NSString stringWithFormat:@"%ld",indexPath.row + 1 - 4];
//    [cell MonthLabeltextcolor:indexPath comp:_comp todaycomp:_todaycomp number:strnumber];
    [cell MonthLabelindexPath:indexPath comp:_comp todaycomp:_todaycomp number:strnumber textcolor:_thisMonthTextColor];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
}




- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    scrollView.delegate = self;
    if (self.monthcollectionview.contentOffset.x == 0) {
        
        [self lastYeasCalendar];
    }
    else if (self.monthcollectionview.contentOffset.x == self.monthcalenbarview.frame.size.width * 4) {
        
        [self nextYeasCalendar];
    }
   
}

#pragma mark 上一年

- (void)lastYeasCalendar
{
    [self.monthcollectionview setContentOffset:CGPointMake(self.monthcalenbarview.frame.size.width * 2, 0)];
    self.cyhcalendate = [[cyhCalenbardate alloc] init];
    
    NSDate * lastMonthdate = [self.cyhcalendate lastYeasDate:_mydate];
    _mydate = lastMonthdate;
    
    [self getdatesource:_mydate];
    
    if (_Y_M_Dlabel) {
        
        [_Y_M_Dlabel removeFromSuperview];
    }
    [self add_Y_M_Dlabel];
    [self.monthcollectionview reloadData];
 [self.monthcollectionview setContentOffset:CGPointMake(self.monthcalenbarview.bounds.size.width * 3, 0)];
}
#pragma mark 下一年
- (void)nextYeasCalendar
{
    NSDate * nextMonthdate = [self.cyhcalendate nextyeasDate:_mydate];
    
    _mydate = nextMonthdate;
    //    NSLog(@"%@",lastMonthdate);
    
    [self getdatesource:_mydate];
    
    if (_Y_M_Dlabel) {
        
        [_Y_M_Dlabel removeFromSuperview];
    }
    [self add_Y_M_Dlabel];
    [self.monthcollectionview reloadData];
    [self.monthcollectionview setContentOffset:CGPointMake(self.monthcalenbarview.bounds.size.width, 0)];
}

- (void)setMcalenbarBGcolor:(UIColor *)McalenbarBGcolor
{
    self.monthcollectionview.backgroundColor = McalenbarBGcolor ;
    _McalenbarBGcolor = McalenbarBGcolor;
}

- (void)setMSelecNumBGcolor:(UIColor *)MSelecNumBGcolor
{
    _MSelecNumBGcolor = MSelecNumBGcolor;

}

- (void)setThisMonthNumBGcolor:(UIColor *)thisMonthNumBGcolor
{
    _thisMonthNumBGcolor = thisMonthNumBGcolor;

}

- (void)setThisMonthTextColor:(UIColor *)thisMonthTextColor
{
    _thisMonthTextColor = thisMonthTextColor;
}
@end
