
#import "ProgressBarShowHideViewController.h"
#import "MONActivityIndicatorView.h"


@interface ProgressBarShowHideViewController ()<MONActivityIndicatorViewDelegate>
{
    MONActivityIndicatorView *indicatorView;
    UIImageView *bg;
}
@end

@implementation ProgressBarShowHideViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
-(void)progressBarShow
{
    bg=[[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
    bg.image=[UIImage imageNamed:@"indicatorNew.png"];
    indicatorView = [[MONActivityIndicatorView alloc] init];
    indicatorView.delegate= self;
    indicatorView.numberOfCircles = 6;
    indicatorView.radius = 10;
    indicatorView.internalSpacing = 2;
    indicatorView.center = self.view.center;
    bg.hidden=NO;
    [bg addSubview:indicatorView];
    [self.view addSubview:bg];
    [indicatorView startAnimating];
}
-(void)progressBarHide
{
    bg.hidden=YES;
    [indicatorView stopAnimating];
}
//
@end



