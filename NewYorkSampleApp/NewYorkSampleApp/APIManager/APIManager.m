//
//  APIManager.m
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import "APIManager.h"
#import "ArticleInfoModal+Actions.h"
#import "Constant.h"

@implementation APIManager
static APIManager *_sharedManager = nil;
static dispatch_once_t onceToken;
+ (instancetype)sharedAPIManager
{
    dispatch_once(&onceToken, ^{
        _sharedManager = [[APIManager alloc] init];
    });
    
    return _sharedManager;
}

-(void)getMostPopularArticalFromServerwithCompletion:(void (^)(id, NSError *))completionHandler
{
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kArticleURl]];
    
    //create the Method "GET"
    [urlRequest setHTTPMethod:kMethod];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            completionHandler(responseDictionary,error);
        }
        else
        {
            completionHandler(nil,error);
        }
    }];
    [dataTask resume];
}
@end
