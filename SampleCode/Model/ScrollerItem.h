//
//  ScrollerItem.h
//  SampleCode
//
//  Created by Kiranmai Sreekakula on 08/07/15.
//  Copyright (c) 2015 Kiranmai Sreekakula01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollerItem : NSObject
@property(nonatomic,retain) NSString *productOptionImageURL;
@property(nonatomic,retain) NSString *optionItemNumber;
@property(nonatomic,retain) NSString *categoryId;
@property(nonatomic,retain) NSString *productOptionName;
@property(nonatomic,retain) NSString *productOptionBrandName;
@property(nonatomic,retain) NSString *productOptionSalePrice;
@property(nonatomic,retain) NSString *productOptionListPrice;
@property(nonatomic,retain) NSString *productOptionId;
@property (nonatomic,retain) NSString *nameOfThePromotion;
@property (nonatomic,retain) NSString *textOfThePromotion;
@property (nonatomic,retain) NSString *alternateText;
@property (nonatomic,retain) NSString *paramsForPromotion;
@property(nonatomic,retain)NSString *badgeNameInSimilarSection;
@end
