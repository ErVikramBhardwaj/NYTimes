//
//  NSDictionary+Validator.h
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Validator)
-(NSString *)getStringDataForKey:(NSString *)strKey;
-(NSNumber *)getNumericDataForKey:(NSString *)strKey;
-(id)checkForNullObjectForKey:(NSString *)strKey;

@end
