/*
 Copyright (C) 2014 Apple Inc. All Rights Reserved.
 See LICENSE.txt for this sample’s licensing information
 
 Abstract:
 
  The entry point to our project where we setup all layers / pictures (see setup function).
  Screen is also the base layer and parent layer to most other layers (pictures).
  The dimensions of the screen layer correspond to the dimensions of the real screen.
  
  The commented out code in the setup function corresponds to the code snippets that we showed in our presentation.
  Uncommenting these code snippets requires commenting out the other parts in the setup function.
  
 */

#import "ToastKit.h"
#import "Screen.h"
#import "SectionsBrowser.h"
#import "Create.h"
#import "List.h"
#import "ItemList.h"

@interface Screen ()

@property (weak, nonatomic) Layer *trendingButton;
@property (weak, nonatomic) Layer *mineButton;
@property (weak, nonatomic) Layer *trendingScroll;
@property (weak, nonatomic) Layer *mineScroll;
@property (weak, nonatomic) Layer *activeNavBar;

@property (weak, nonatomic) Create *create;

@end

@implementation Screen
{
}

//====================================================================================
//
//  setup your own picture layers here
//

- (void) setup {
    self.backgroundColor = [UIColor whiteColor];
    
    Layer *screen = [Screen layer];
    
//    Layer *sections = [[SectionsBrowser alloc] initWithParent:screen];
//    sections.y = 65;
//    

    List *trendingScroll = [[List alloc] initWithParent:screen];
    trendingScroll.max = 0;
    trendingScroll.min = -1380;
    trendingScroll.backgroundColor = [UIColor whiteColor];
    Layer *trending = [[ItemList alloc] initWithParent:trendingScroll];
    trending.y = 65;
    trendingScroll.size = CGSizeMake(screen.width, trending.height);
    _trendingScroll = trendingScroll;

    List *mineScroll = [[List alloc] initWithParent:screen];
    [mineScroll loadImage:@"mine_list"];
    mineScroll.max = 65;
    mineScroll.min = 65;
    mineScroll.x = trendingScroll.width;
    mineScroll.y = 65;
    _mineScroll = mineScroll;
    
    Layer *header = [[Layer alloc] initWithParent:screen];
    [header loadImage:@"header"];
    
    Layer *trendingButton = [[Layer alloc] initWithParent:header];
    [trendingButton loadImage:@"trending_button_active"];
    trendingButton.x = 65;
    trendingButton.y = 34;
    _trendingButton = trendingButton;
    
    Layer *mineButton = [[Layer alloc] initWithParent:header];
    [mineButton loadImage:@"mine_button"];
    mineButton.x = 186;
    mineButton.y = 34;
    _mineButton = mineButton;
    
    Layer *mineCount = [[Layer alloc] initWithParent:header];
    [mineCount loadImage:@"mine_count"];
    mineCount.x = 228;
    mineCount.y = 22;
    
    Layer *activeNavBar = [[Layer alloc] initWithParent:header];
    activeNavBar.backgroundColor = [UIColor colorWithRed:105.5/255.0 green:210.0/255.0 blue:231.0/255.0 alpha:1.0];
    activeNavBar.frame = CGRectMake(trendingButton.x, 62.5, trendingButton.width, 2);
    _activeNavBar = activeNavBar;
    
    mineButton.onTouchUp = ^(NSSet* touches) {
        [self selectMine:YES];
    };
    
    __weak Layer *weakTrending = trendingButton;
    trendingButton.onTouchUp = ^(NSSet* touches) {
        [weakTrending loadImage:@"trending_button_active"];
        [mineButton loadImage:@"mine_button"];
        [UIView animateWithDuration:0.4 animations:^{
            activeNavBar.frame = CGRectMake(weakTrending.x, 62.5, weakTrending.width, 2);
            trendingScroll.x = 0;
            mineScroll.x = trendingScroll.width;
        }];
    };
    
    Create *create = [[Create alloc] initWithParent:screen];
    create.hidden = YES;
    _create = create;
    
    Layer *addButton = [[Layer alloc] initWithParent:header];
    [addButton loadImage:@"add_button"];
    addButton.x = 280;
    addButton.y = 25.5;
    addButton.onTouchUp = ^(NSSet* touches) {
        self.create.alpha = 0;
        [UIView animateWithDuration:0.4 animations:^{
            self.create.hidden = NO;
            self.create.alpha = 1.0;
        }];
    };
    
}

- (void)selectMine:(BOOL)animated
{
    [self.trendingButton loadImage:@"trending_button"];
    [self.mineButton loadImage:@"mine_button_active"];
    if (animated) {
        [UIView animateWithDuration:0.4 animations:^{
            self.activeNavBar.frame = CGRectMake(self.mineButton.x, 62.5, self.mineButton.width, 2);
            self.trendingScroll.x = -(self.trendingScroll.width);
            self.mineScroll.x = 0;
        }];
    } else {
        self.activeNavBar.frame = CGRectMake(self.mineButton.x, 62.5, self.mineButton.width, 2);
        self.trendingScroll.x = -(self.trendingScroll.width);
        self.mineScroll.x = 0;
    }
}

//====================================================================================
//
// screen initialization
//

static Screen* gScreen; // global screen layer

+ (void) initWithWindow:(UIWindow*)window
{
    gScreen = [Screen layerWithParent:window];
    gScreen.size = window.frame.size;
    [gScreen setup];
}

+ (Layer*) layer {
    return gScreen;
}

@end
