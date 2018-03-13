//
//  ArticleDetailViewController.m
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj on 13/03/18.
//

#import "ArticleDetailViewController.h"
#import <WebKit/WebKit.h>
#import "Reachability.h"
#import "Constant.h"

@interface ArticleDetailViewController ()
@property(nonatomic,weak)IBOutlet WKWebView *articleDetailWebView;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *activityIndicatorObj;
@end

@implementation ArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setting screen title
    self.title=KHeaderTitle;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIImage* imgBack = [UIImage imageNamed:@"back"];
    CGRect frameback = CGRectMake(0, 0, imgBack.size.width,imgBack.size.height);
    UIButton *btnBack = [[UIButton alloc] initWithFrame:frameback];
    [btnBack setBackgroundImage:imgBack forState:UIControlStateNormal];
    
    [btnBack setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(backButtonAction) forControlEvents:UIControlEventTouchDown];
    [btnBack setShowsTouchWhenHighlighted:NO];
    
    UIBarButtonItem *btnBackNavigation =[[UIBarButtonItem alloc] initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem=btnBackNavigation;
    
    /*******************Checking Internet connection******************/
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        // To error pop up when there is no network
        [self showNetworkPop];
    }
    else
    {
        //Adding observer to monitor WKWebView progress
    [self.articleDetailWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:NULL];
    
    [self.activityIndicatorObj startAnimating];
    //Loading Article detail on WKWebView
    [self.articleDetailWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.strArticleDetailURl]]];
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.activityIndicatorObj stopAnimating];
}
//**** Back Button Action
-(void)backButtonAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
////********* Action Method to Show Alert When No Network is Availble
- (void)showNetworkPop
{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:kErrorMessageTitle
                                 message:kErrorMessage
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* btnOk = [UIAlertAction
                            actionWithTitle:@"Ok"
                            style:UIAlertActionStyleDefault
                            handler:^(UIAlertAction * action) {
                                
                                
                            }];
    
    [alert addAction:btnOk];
    
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    double progress=0.0;
    if([keyPath isEqualToString:@"estimatedProgress"])
    {
        progress=(float)self.articleDetailWebView.estimatedProgress;
        
        if(progress >= 0.50)
        {
            [self.activityIndicatorObj stopAnimating];
            
        }
    }
   
}

@end
