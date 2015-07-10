//
//  HomeViewController.m
//  SampleCode
//
//  Created by Kiranmai Sreekakula01 on 07/07/15.
//  Copyright (c) 2015 Kiranmai Sreekakula01. All rights reserved.
//

#import "HomeViewController.h"
#import "ScrollerItemControl.h"
#import "ULSlideDetailsObject.h"
#import "FXImageView.h"


#define SLIDES_TIMER 10.0

@interface HomeViewController ()
{
    NSMutableArray *promoDetailsArray;
    NSTimer *promotionsTimer;
    NSInteger numberOfSlides;
    
    
    
}

@property (nonatomic, strong) NSMutableArray *carouselItems;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    // Do any additional setup after loading the view.
    promoDetailsArray = [NSMutableArray arrayWithObjects:@"object1",@"object2",@"object3",@"object4",@"object5" ,nil];
    [self setSlideShowUsing:promoDetailsArray];
    self.carouselView.type = iCarouselTypeCoverFlow2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)awakeFromNib {
    [self setUp];
}

#pragma mark-carousel related.
- (void)setUp
{
    //set up data
    _carouselItems = [NSMutableArray array];
    for (int i = 0; i < 5; i++)
    {
        [_carouselItems addObject:@(i)];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
-(void)setSlideShowUsing:(NSArray *)slideDetails {
    NSMutableArray *promoProductsArray = [[NSMutableArray alloc]init];
    for (int iCount=0; iCount<[slideDetails count]; iCount++) {
        ScrollerItem *scrollerItemForPromos = [[ScrollerItem alloc] init];
        scrollerItemForPromos.textOfThePromotion =[slideDetails objectAtIndex:iCount];
        [promoProductsArray addObject:scrollerItemForPromos];
    }
    //Setting the number of pages for the adPageController
    self.adPageControl.numberOfPages = [slideDetails count];
    self.adPageControl.hidden = NO;
    self.adPageControl.currentPage = 0;
    numberOfSlides =[promoDetailsArray count];
    // Temporary fix. have to remove the view
    for (UIView *view in [self.adScrollView subviews]) {
        if (![view isKindOfClass:[UIPageControl class]]) {
            view.hidden = YES;
        }
    }
    //Removing the previous Scroller view if any
    [self.adScroller removeFromSuperview];
    //  [self.adScrollView removeFromSuperview:adScroller];
    
    //Initilaizing the Horizontal Scroller for Promotions with the scroller objects
    self.adScroller =[[ScrollerItemControl alloc]init];
    self.adScroller.delegate =self;
    [self.adScroller scrollViewforFrame:CGRectMake(0, 0, 375,218) withObjects:promoProductsArray withImageSize:CGSizeMake(320, 218) forType:ULHorizontalScrollViewTypeAdControl withOffset:0 withSpacingBetweenObjects:0];
    self.adPageControl.frame = CGRectMake(100, 193, 54, 36);
    
    promotionsTimer =[NSTimer scheduledTimerWithTimeInterval:SLIDES_TIMER target:self selector:@selector(setAdScrollPositionWithTime:) userInfo:nil repeats:YES];
    self.adScroller.scrollViewDelegate = self;
    [self.adScrollView addSubview:_adScroller];
    [self.adScrollView bringSubviewToFront:_adScroller];
    [self.adScrollView addSubview:self.adPageControl];
}


#pragma mark- Set Promotions Scroller With Time
-(void)setAdScrollPositionWithTime:(id)sender{
    
    CGFloat pageWidthForAdScroller = self.adScroller.frame.size.width;
    int pageForAdScroller = floor((self.adScroller.contentOffset.x - pageWidthForAdScroller / 2) / pageWidthForAdScroller) + 1;
    
    if(pageForAdScroller == (numberOfSlides-1)){
        [self.adScroller setContentOffset:CGPointMake(0, 0) animated:NO];
    }
    else{
        [self.adScroller setContentOffset:CGPointMake(((pageForAdScroller+1)*pageWidthForAdScroller), 0) animated:YES];
        
    }
}


#pragma mark - scrollview pagination implementation
- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // Setting the page number for the ad page control whenever the image shown is changed
    
    CGFloat pageWidthForAdScroller = self.adScroller.frame.size.width;
    int pageForAdScroller = floor((self.adScroller.contentOffset.x - pageWidthForAdScroller / 2) / pageWidthForAdScroller) + 1;
    self.adPageControl.currentPage = pageForAdScroller;
    
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(__unused iCarousel *)carousel
{
    return (NSInteger)[_carouselItems count];
}


- (UIView *)carousel:(__unused iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UILabel *label = nil;
    
    //create new view if no view is available for recycling
    if (view == nil)
    {
        view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200.0f, 200.0f)];
        ((UIImageView *)view).image = [UIImage imageNamed:@"page.png"];
        view.contentMode = UIViewContentModeCenter;
        label = [[UILabel alloc] initWithFrame:view.bounds];
        label.backgroundColor = [UIColor clearColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [label.font fontWithSize:50];
        label.tag = 1;
        [view addSubview:label];
    }
    else {
        label = [[view subviews] lastObject];
    }    //set item label
    //remember to always set any properties of your carousel item
    //views outside of the `if (view == nil) {...}` check otherwise
    //you'll get weird issues with carousel item content appearing
    //in the wrong place in the carousel
    label.text = [_carouselItems[(NSUInteger)index] stringValue];
    return view;
}


#pragma mark -
#pragma mark iCarousel taps

- (void)carousel:(__unused iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    NSNumber *item = (_carouselItems)[(NSUInteger)index];
    NSLog(@"Tapped view number: %@", item);
}

- (void)carouselCurrentItemIndexDidChange:(__unused iCarousel *)carousel
{
    NSLog(@"Index: %@", @(self.carouselView.currentItemIndex));
}
- (CGFloat)carousel:(__unused iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    return value;
    
}



@end
