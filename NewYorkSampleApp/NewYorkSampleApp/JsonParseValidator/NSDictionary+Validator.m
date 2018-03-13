//
//  NSDictionary+Validator.m
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import "NSDictionary+Validator.h"

@implementation NSDictionary (Validator)
-(NSString *)getStringDataForKey:(NSString *)strKey
{
    NSString *value;
    if([self valueForKey:strKey]!=nil&&(![[self valueForKey:strKey] isKindOfClass:[NSNull class]]))
    {
        value=[self valueForKey:strKey];
    }
    else
    {
        value=@"";
    }
    
    return value;
}
-(NSNumber *)getNumericDataForKey:(NSString *)strKey
{
    NSNumber *value;
    if([self valueForKey:strKey]!=nil&&(![[self valueForKey:strKey] isKindOfClass:[NSNull class]]))
    {
        value=[self valueForKey:strKey];
    }
    else
    {
        value=[NSNumber numberWithInt:0];
    }
    
    return value;
}
-(id)checkForNullObjectForKey:(NSString *)strKey
{
    if([[self objectForKey:strKey] isKindOfClass:[NSString class]])
    {
        if([[self objectForKey:strKey] isEqualToString:@"\"null\""]||[[self objectForKey:strKey] isEqualToString:@"<\"null\">"])
        {
            return nil;
        }
    }
    if([[self valueForKey:strKey] isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return [self objectForKey:strKey];
}

@end
