//
//  NewYorkSampleAppTests.m
//  NewYorkSampleAppTests
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import <XCTest/XCTest.h>
#import "APIManager.h"
#import "MostViewArticlesViewController.h"
#import "ArticleDetailViewController.h"
#import "Constant.h"
@interface NewYorkSampleAppTests : XCTestCase
{
    MostViewArticlesViewController *objMostViewArticlesVC;
    ArticleDetailViewController *objArticleDetailViewController;
    NSMutableString *strArticleDetailUrl;
}
@end

@implementation NewYorkSampleAppTests

- (void)setUp {
    [super setUp];
    
    // Creating object of Viewcontroller
    UIStoryboard* storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    objMostViewArticlesVC = [storyBoard instantiateViewControllerWithIdentifier:@"MostViewArticlesViewControllerIdentifier"];
    
    objMostViewArticlesVC.title=KHeaderTitle;
    
    objArticleDetailViewController=[storyBoard instantiateViewControllerWithIdentifier:@"ArticleDetailViewControllerIdentifier"];
    objArticleDetailViewController.title=KHeaderTitle;
    
    // Setting dummy url in for article detail
    strArticleDetailUrl=[[NSMutableString alloc]initWithString:@"WwW.google.com"];
    objArticleDetailViewController.strArticleDetailURl = strArticleDetailUrl;
}

- (void)tearDown {
    // clearing the objects
    objArticleDetailViewController = nil;
    objMostViewArticlesVC = nil;
    [super tearDown];
}

-(void)testNavigationTitleMostViewArticlesVC{
    // Checking the header of MostViewArticle viewcontroller
    XCTAssertEqualObjects(objMostViewArticlesVC.title,KHeaderTitle);
}
-(void)testNavigationTitleArticleDetailViewController{
   
     // Checking the header of ArticleDetail viewcontroller
    XCTAssertEqualObjects(objArticleDetailViewController.title,KHeaderTitle);
}

-(void)testArticleURL{
     // Checking the header of Article Detail URl
 XCTAssertEqual(objArticleDetailViewController.strArticleDetailURl ,strArticleDetailUrl);
}
-(void)testAPI{
    
     // Checking the API is getting call
    [[APIManager sharedAPIManager] getMostPopularArticalFromServerwithCompletion:^(id response, NSError *error) {
        XCTAssertEqual(error, nil);
    }];
}


@end
