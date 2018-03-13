//
//  MostViewArticlesViewController.m
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import "MostViewArticlesViewController.h"
#import "MostViewArticlesTableViewCell.h"
#import "ArticleInfoModal+Actions.h"
#import "APIManager.h"
#import "ArticleDetailViewController.h"
#import "Reachability.h"
#import "Constant.h"
@interface MostViewArticlesViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *arrArticlesInfo;
}
@property(nonatomic,weak)IBOutlet UITableView *tblArticles;
@property(nonatomic,weak)IBOutlet UIActivityIndicatorView *activityIndicatorObj;
@end

@implementation MostViewArticlesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Setting Screen header
   self.title=KHeaderTitle;
    // Do any additional setup after loading the view.
    
    /*******************Checking Internet connection******************/
    if ([[Reachability reachabilityForInternetConnection]currentReachabilityStatus]==NotReachable)
    {
        // To error pop up when there is no network
        [self showNetworkPop];
    }
    else
    {
        // Calling List of  most popular article and starting indicator
        [self.activityIndicatorObj startAnimating];
        [[APIManager sharedAPIManager] getMostPopularArticalFromServerwithCompletion:^(id response, NSError *error) {
            if(!error)
            {
                arrArticlesInfo=[ArticleInfoModal parseArticleInfomationWith:response];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //Stoping indicator
                [self.activityIndicatorObj stopAnimating];
                //Reloding TableView
                [self.tblArticles reloadData];
            });
            
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.tblArticles.rowHeight = UITableViewAutomaticDimension;
    self.tblArticles.estimatedRowHeight = 120;
   
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
#pragma mark  TableView Delegate and DataSource Methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  arrArticlesInfo.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MostViewArticlesTableViewCell *articleCell=[tableView dequeueReusableCellWithIdentifier:kArticleTableViewIdentifier];
    
    articleCell.selectionStyle=UITableViewCellSelectionStyleNone;
    articleCell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if(arrArticlesInfo.count>indexPath.row)
    {
        // Setting Article vlaues
        ArticleInfoModal *articleInfoModalObj=[arrArticlesInfo objectAtIndex:indexPath.row];
        
        articleCell.lblTitle.text=articleInfoModalObj.strArticleTitle;
        articleCell.lblByLine.text=articleInfoModalObj.strArticleByline;
        articleCell.lblPublishDate.text=articleInfoModalObj.strArticlePublishDate;
        
        // Downloading and showing Article icon
        NSURLSessionTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:articleInfoModalObj.strArticleThumbnailUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (data) {
                UIImage *iconImage = [UIImage imageWithData:data];
                if (iconImage) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [articleCell.imgArticleIcon setImage:iconImage];
                    });
                }
            }
        }];
        [task resume];

    }
    
    return  articleCell;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 120;
//}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(arrArticlesInfo.count>indexPath.row)
    {
        // Code to navigate to Article detail screen
        ArticleInfoModal *articleInfoModalObj=[arrArticlesInfo objectAtIndex:indexPath.row];
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ArticleDetailViewController *articleDetailVC = [storyBoard instantiateViewControllerWithIdentifier:kArticleDetailViewIdentifier];
        articleDetailVC.strArticleDetailURl = [[NSMutableString alloc]initWithString:articleInfoModalObj.strArticleDetailUrl];
        [self.navigationController pushViewController:articleDetailVC animated:YES];
    }
}



@end
