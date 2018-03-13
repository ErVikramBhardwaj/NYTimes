//
//  MostViewArticlesTableViewCell.h
//  NewYorkSampleApp
//
//  Created by Vikram Bhardwaj  on 13/03/18.
//

#import <UIKit/UIKit.h>

@interface MostViewArticlesTableViewCell : UITableViewCell
@property(nonatomic,weak)IBOutlet UIImageView *imgArticleIcon;
@property(nonatomic,weak)IBOutlet UILabel *lblTitle;
@property(nonatomic,weak)IBOutlet UILabel *lblByLine;
@property(nonatomic,weak)IBOutlet UILabel *lblPublishDate;
@end
