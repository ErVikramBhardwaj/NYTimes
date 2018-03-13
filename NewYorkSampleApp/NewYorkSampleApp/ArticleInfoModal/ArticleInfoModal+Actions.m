//
//  ArticleInfoModal+Actions.m
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import "ArticleInfoModal+Actions.h"
#import "NSDictionary+Validator.h"
#import "Constant.h"

@implementation ArticleInfoModal (Actions)
+(NSArray *)parseArticleInfomationWith:(NSDictionary *)dicArticleInfo
{
    NSMutableArray *arrArticleInformation;
    if(dicArticleInfo)
    {
       
        NSArray *arrResult=[dicArticleInfo objectForKey:kResults];
        if(arrResult.count>0)
        {
            arrArticleInformation=[[NSMutableArray alloc]init];
            for(NSDictionary *dicArticle in arrResult)
            {
                if(dicArticle)
                {
                    ArticleInfoModal *articleInfoModalObj=[[ArticleInfoModal alloc]init];
                    
                    articleInfoModalObj.strArticleTitle=[dicArticle getStringDataForKey:kTitle];
                    articleInfoModalObj.strArticleByline=[dicArticle getStringDataForKey:kByline];
                    articleInfoModalObj.strArticlePublishDate=[dicArticle getStringDataForKey:kPublished_date];
                    articleInfoModalObj.strArticleDetailUrl=[dicArticle getStringDataForKey:kArticleDetailUrl];
                    
                    NSArray *arrMedia=[dicArticle objectForKey:kMedia];
                    if(arrMedia.count>0)
                    {
                        NSDictionary *dicThumb=arrMedia[0];
                        if(dicThumb)
                        {
                         NSArray *arrThubNail=[dicThumb objectForKey:kMediaMetadata];
                            if(arrThubNail.count>0)
                            {
                                articleInfoModalObj.strArticleThumbnailUrl=[[arrThubNail objectAtIndex:1] getStringDataForKey:kArrticleThumbURl];
                            }
                            
                        }
                    }
                    
                  [arrArticleInformation addObject:articleInfoModalObj];
                }
                
            }
            
        }
        
    }
    return arrArticleInformation;
}
@end
