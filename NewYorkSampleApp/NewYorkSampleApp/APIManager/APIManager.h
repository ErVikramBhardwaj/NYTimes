//
//  APIManager.h
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import <Foundation/Foundation.h>

@interface APIManager : NSObject
+ (instancetype)sharedAPIManager;
-(void)getMostPopularArticalFromServerwithCompletion:(void (^)(id response, NSError *error))completionHandler;
@end
