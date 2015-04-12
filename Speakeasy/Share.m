//
//  Share.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/19/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "Share.h"
#import "Screen.h"
#import "Completed.h"

@implementation Share

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        [self loadImage:@"share"];
        
        Screen *screen = [Screen layer];
        
        Layer *previousButton = [[Layer alloc] initWithParent:self];
        [previousButton loadImage:@"previous_button"];
        previousButton.x = 10;
        previousButton.y = 10;
        previousButton.onTouchUp = ^(NSSet *touches) {
            Completed *completed = [[Completed alloc] initWithParent:screen];
            completed.alpha = 0;
            [UIView animateWithDuration:0.4 animations:^{
                completed.alpha = 1;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        };
        
        Layer *overlay = [[Layer alloc] initWithParent:self];
        overlay.size = screen.size;
        overlay.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        overlay.hidden = YES;
        overlay.alpha = 0;
        
        Layer *posting = [[Layer alloc] initWithParent:self];
        [posting loadImage:@"posting_twitter"];
        posting.hidden = YES;
        
        Layer *keyboard = [[Layer alloc] initWithParent:self];
        [keyboard loadImage:@"keyboard"];
        keyboard.y = self.height;
        keyboard.hidden = YES;
        
        __weak typeof(self) weakSelf = self;
        
        self.caption = [[Layer alloc] initWithParent:self];
        [self.caption loadImage:@"share_caption_enabled"];
        [self insertSubview:self.caption belowSubview:keyboard];
        self.caption.y = self.height - self.caption.height;
        self.caption.onTouchUp = ^(NSSet *touches) {
            if (weakSelf.captionEnabled == NO && weakSelf.shareButtonsEnabled > 0) {
                UITouch *touch = [touches anyObject];
                CGPoint location = [touch locationInView:weakSelf.caption];
                
                // Pressed the done button
                if (location.y >= 141) {
                    posting.alpha = 0;
                    [UIView animateWithDuration:0.4 animations:^{
                        posting.hidden = NO;
                        posting.alpha = 1;
                    } completion:^(BOOL finished) {
                        [NSTimer scheduledTimerWithTimeInterval:2 target:weakSelf selector:@selector(navigateToProfile:) userInfo:nil repeats:NO];
                    }];
                    return;
                }

                [UIView animateWithDuration:0.6 animations:^{
                    weakSelf.caption.y = weakSelf.height - weakSelf.caption.height - 216.5 + 46;
                    keyboard.hidden = NO;
                    keyboard.y = weakSelf.height - keyboard.height;
                    overlay.hidden = NO;
                    overlay.alpha = 1;
                }];
                weakSelf.captionEnabled = YES;
            }
        };
        
        Layer *_overlay = overlay;
        overlay.onTouchUp = ^(NSSet *touches) {
            if (self.captionEnabled) {
                [UIView animateWithDuration:0.6 animations:^{
                    self.caption.y = self.height - self.caption.height;
                    keyboard.y = self.height;
                    _overlay.alpha = 0;
                } completion:^(BOOL finished) {
                    keyboard.hidden = YES;
                    _overlay.hidden = YES;
                }];
                self.captionEnabled = NO;
            }
        };
        
        self.shareButtonsEnabled = 1;
        [self addObserver:self forKeyPath:@"shareButtonsEnabled" options:NSKeyValueObservingOptionInitial context:nil];
        
        self.speakeasyButton = [[Layer alloc] initWithParent:self];
        [self.speakeasyButton loadImage:@"speakeasy_button_active"];
        [self insertSubview:self.speakeasyButton belowSubview:overlay];
        self.speakeasyButton.x = 223;
        self.speakeasyButton.y = 79;
        self.speakeasyEnabled = YES;
        self.speakeasyButton.onTouchUp = ^(NSSet *touches) {
            if (weakSelf.speakeasyEnabled == NO) {
                [weakSelf.speakeasyButton loadImage:@"speakeasy_button_active"];
                weakSelf.speakeasyEnabled = YES;
                weakSelf.shareButtonsEnabled++;
            } else {
                [weakSelf.speakeasyButton loadImage:@"speakeasy_button"];
                weakSelf.speakeasyEnabled = NO;
                weakSelf.shareButtonsEnabled--;
            }
        };
        
        self.twitterButton = [[Layer alloc] initWithParent:self];
        [self.twitterButton loadImage:@"twitter_button"];
        [self insertSubview:self.twitterButton belowSubview:overlay];
        self.twitterButton.x = 223;
        self.twitterButton.y = 148;
        self.twitterButton.onTouchUp = ^(NSSet *touches) {
            if (weakSelf.twitterEnabled == NO) {
                [weakSelf.twitterButton loadImage:@"twitter_button_active"];
                weakSelf.twitterEnabled = YES;
                weakSelf.shareButtonsEnabled++;
            } else {
                [weakSelf.twitterButton loadImage:@"twitter_button"];
                weakSelf.twitterEnabled = NO;
                weakSelf.shareButtonsEnabled--;
            }
        };

        self.facebookButton = [[Layer alloc] initWithParent:self];
        [self.facebookButton loadImage:@"facebook_button"];
        [self insertSubview:self.facebookButton belowSubview:overlay];
        self.facebookButton.x = 223;
        self.facebookButton.y = 220.5;
        self.facebookButton.onTouchUp = ^(NSSet *touches) {
            if (weakSelf.facebookEnabled == NO) {
                [weakSelf.facebookButton loadImage:@"facebook_button_active"];
                weakSelf.facebookEnabled = YES;
                weakSelf.shareButtonsEnabled++;
            } else {
                [weakSelf.facebookButton loadImage:@"facebook_button"];
                weakSelf.facebookEnabled = NO;
                weakSelf.shareButtonsEnabled--;
            }
        };
        
        self.saveButton = [[Layer alloc] initWithParent:self];
        [self.saveButton loadImage:@"save_button"];
        [self insertSubview:self.saveButton belowSubview:overlay];
        self.saveButton.x = 223;
        self.saveButton.y = 292.5;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"shareButtonsEnabled"]) {
        if (self.shareButtonsEnabled > 0) {
            [self.caption loadImage:(self.speakeasyEnabled ? @"share_caption_enabled" : @"share_caption_enabled_nolink")];
        } else {
            [self.caption loadImage:(self.speakeasyEnabled ? @"share_caption_disabled" : @"share_caption_disabled_nolink")];
        }
    }
}

- (void)navigateToProfile:(NSTimer *)timer
{
    [[Screen layer] selectMine:NO];
    [self removeFromSuperview];
}

@end
