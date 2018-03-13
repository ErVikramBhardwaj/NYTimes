//
//  ArticleInfoModal.h
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import <Foundation/Foundation.h>
#import "Constant.h"

@interface ArticleInfoModal : NSObject
@property(nonatomic,strong) NSString *strArticleDetailUrl;
@property(nonatomic,strong) NSString *strArticleByline;
@property(nonatomic,strong) NSString *strArticleTitle;
@property(nonatomic,strong) NSString *strArticlePublishDate;
@property(nonatomic,strong) NSString *strArticleThumbnailUrl;

@end
