//
//  PieChartViewController.m
//  WYChart
//
//  Created by yingwang on 16/8/22.
//  Copyright © 2016年 yingwang. All rights reserved.
//

#import "PieChartViewController.h"
#import "WYChartCategory.h"
#import "WYPieChartView.h"
#import "MyCell.h"
@interface PieChartViewController ()<WYPieChartViewDelegate, WYPieChartViewDatasource>

@property (nonatomic, strong) WYPieChartView *pieView;

@end

@implementation PieChartViewController
@synthesize tableviewNew;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WYPieChart";
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
        [tableviewNew reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
  
   // [_pieView update];
}



#pragma mark - Pie Chart View Delegate
//- (NSInteger)numberOfLabelOnPieChartView:(WYPieChartView *)pieChartView {
//    
//    return 3;
//}

#pragma mark - Pie Chart View Datasource

- (NSString *)pieChartView:(WYPieChartView *)pieChartView textForLabelAtIndex:(NSInteger)index {
    
    return @"73.21312%";
}

- (NSInteger)pieChartView:(WYPieChartView *)pieChartView valueIndexReferToLabelAtIndex:(NSInteger)index {
    return index;
}

- (UIColor *)pieChartView:(WYPieChartView *)pieChartView sectorColorAtIndex:(NSInteger)index {
    
    UIColor *color;
    
    switch (index) {
        case 0:
            color = [UIColor wy_colorWithHexString:@"#D65F5F"];
            break;
        case 1:
            color = [UIColor wy_colorWithHexString:@"#696969"];
            break;
        case 2:
            color = [UIColor wy_colorWithHexString:@"#A1F6B6"];
            break;
        case 3:
            color = [UIColor wy_colorWithHexString:@"#78D8D0"];
            break;
        case 4:
            color = [UIColor wy_colorWithHexString:@"#0C4762"];
            break;
        default:
            break;
    }
    return color;
}
////////-----------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;    //count number of row from counting array hear cataGorry is An Array
}
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    static NSString *CellIdentifier = @"MyIdentifier";
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                   forIndexPath:indexPath];
    
//    for(UIView *view in cell.contentView.subviews){
//        if ([view isKindOfClass:[UIView class]]) {
//            [view removeFromSuperview];
//        }
//    }
   // cell.removeFromSuperview();
    _pieView = [[WYPieChartView alloc] initWithFrame:CGRectMake(0, 50, 300, 200)];
    _pieView.delegate = self;
    _pieView.datasource = self;
    _pieView.backgroundColor = [UIColor clearColor];
    
    if(indexPath.row==1)
    {
    _pieView.values = @[@70, @30];
        
    }
    else{
        _pieView.values = @[@30, @70];
    }
    
    [cell.viewMain addSubview:_pieView];
    
    [_pieView update];
    cell.clipsToBounds = YES;
    return cell;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 300;
}

@end
