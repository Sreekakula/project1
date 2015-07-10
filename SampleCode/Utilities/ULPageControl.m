//
//  ULPageControl.m
//  SampleCode
//
//  Created by Kiranmai Sreekakula on 08/07/15.
//  Copyright (c) 2015 Kiranmai Sreekakula01. All rights reserved.
//

#import "ULPageControl.h"


@interface ULPageControl(){
    UIImage* activeImage;
    UIImage* inactiveImage;
}

-(void) updateDots;

@end
@implementation ULPageControl

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

#pragma mark - Initialization functions
-(id) initWithCoder:(NSCoder *)aDecoder {
self = [super initWithCoder:aDecoder];
activeImage = [UIImage imageNamed:@"Page_Hover.png"];
inactiveImage = [UIImage imageNamed:@"Page.png"];
self.currentPage = 0;
[self updateDots];
return self;
}
-(void) setCurrentPage:(NSInteger)page {
[super setCurrentPage:page];
[self updateDots];
}

#pragma mark - private function
-(void) updateDots {
    for (int i = 0; i < [self.subviews count]; i++)
    {
        UIView* dotView = [self.subviews objectAtIndex:i];
        UIImageView* dot = nil;
        
        for (UIView* subview in dotView.subviews)
        {
            if ([subview isKindOfClass:[UIImageView class]])
            {
                dot = (UIImageView*)subview;
                break;
            }
        }
        
        if (dot == nil)
        {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, dotView.frame.size.width, dotView.frame.size.height)];
            [dotView addSubview:dot];
        }
        
        if (i == self.currentPage)
        {
            if(activeImage)
                [dot setImage:activeImage]; ;
        }
        else
        {
//            if (inactiveImage)
               [dot setImage:inactiveImage];;
        }
    }
}


@end
