//
//  ScrollerItemControl.h
//  ulta
//
//  Created by Sreeram Ramji on 17/07/12.
//  Copyright (c) 2012 Infosys. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrollerItem.h"


typedef enum {
    ULHorizontalScrollViewTypeAdControl,
} ULHorizontalScrollViewType;

@protocol ProductScrollViewDelegate;

@interface ScrollerItemControl : UIScrollView<UIScrollViewDelegate>
@property (nonatomic, retain)   NSArray*     products;
@property (nonatomic, weak)   id<ProductScrollViewDelegate> scrollViewDelegate;
//@property (nonatomic, strong) ASIHTTPRequest *requestForPromoSliderImages;
@property(nonatomic) BOOL isOlapicCarousel;
-(void)scrollViewforFrame:(CGRect )scrollFrame withObjects:(NSArray *)arrModelObjects withImageSize:(CGSize) imgSize forType:(ULHorizontalScrollViewType)horizontalScrollViewType withOffset:(float)offset withSpacingBetweenObjects:(float)spacingBetweenObjects;

@end

@protocol ProductScrollViewDelegate <NSObject>

@optional

- (void)cellselectedProduct:(ScrollerItem *) objScrollerItem andForType:(NSString *)forType;

@end