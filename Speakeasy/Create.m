//
//  CreateSpeak.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "Create.h"
#import "KeyboardTyping.h"
#import "Screen.h"
#import "Completed.h"

@interface Create ()

@property (weak, nonatomic) Layer *keyboard;
@property (weak, nonatomic) Layer *typing;
@property (weak, nonatomic) Layer *nextButton;
@property (weak, nonatomic) Layer *beginState;

@end

@implementation Create

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        [self loadImage:@"create"];
        
        Layer *screen = [Screen layer];
        
        Layer *imageButton = [[Layer alloc] initWithParent:self];
        [imageButton loadImage:@"image_button"];
        imageButton.x = 174;
        imageButton.y = 507;
        imageButton.onTouchUp = ^(NSSet *touches) {
            self.showingImage = self.showingImage ? NO : YES;
        };
        [self addObserver:self forKeyPath:@"showingImage" options:NSKeyValueObservingOptionInitial context:nil];
        
        Layer *fontButton = [[Layer alloc] initWithParent:self];
        [fontButton loadImage:@"font_button"];
        fontButton.x = 100.0;
        fontButton.y = 507.0;
        fontButton.onTouchUp = ^(NSSet *touches) {
            self.showingAltFont = self.showingAltFont ? NO : YES;
        };
        [self addObserver:self forKeyPath:@"showingAltFont" options:NSKeyValueObservingOptionInitial context:nil];
        
        Layer *keyboard = [[Layer alloc] initWithParent:self];
        [keyboard loadImage:@"keyboard"];
        keyboard.y = screen.height;
        _keyboard = keyboard;
        
        Layer *beginState = [[Layer alloc] initWithParent:self];
        [beginState loadImage:@"create_begin"];
        beginState.hidden = YES;
        _beginState = beginState;
        
        KeyboardTyping *typing = [[KeyboardTyping alloc] initWithParent:self];
        typing.hidden = YES;
        keyboard.onTouchUp = ^(NSSet *touches) {
            typing.hidden = NO;
        };
        _typing = typing;
        
        Layer *nextButton = [[Layer alloc] initWithParent:self];
        [nextButton loadImage:@"next_button"];
        nextButton.x = 280;
        nextButton.y = 10;
        nextButton.hidden = YES;
        _nextButton = nextButton;
        
        Layer *closeButton = [[Layer alloc] initWithParent:self];
        [closeButton loadImage:@"close_button"];
        closeButton.x = 10;
        closeButton.y = 10;
        closeButton.onTouchUp = ^(NSSet *touches) {
            [UIView animateWithDuration:0.4 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self cleanUp];
            }];
        };
        
        nextButton.onTouchUp = ^(NSSet *touches) {
            Completed *completed = [[Completed alloc] initWithParent:screen];
            completed.alpha = 0;
            [UIView animateWithDuration:0.4 animations:^{
                completed.alpha = 1;
            } completion:^(BOOL finished) {
                [self cleanUp];
            }];
        };
        
        self.onTouchUp = ^(NSSet *touches) {
            beginState.alpha = 0;
            [UIView animateWithDuration:0.6 animations:^{
                beginState.hidden = NO;
                beginState.alpha = 1.0;
                nextButton.hidden = NO;
                keyboard.y = screen.height - keyboard.height;
            }];
        };

    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"showingImage"]) {
        if (self.showingImage == NO) {
            [self loadImage:(self.showingAltFont ? @"create_alt" : @"create")];
        } else {
            [self loadImage:(self.showingAltFont ? @"create_alt_image" : @"create_image")];
        }
    } else if ([keyPath isEqualToString:@"showingAltFont"]) {
        if (self.showingAltFont == NO) {
            [self loadImage:(self.showingImage ? @"create_image" : @"create")];
        } else {
            [self loadImage:(self.showingImage ? @"create_alt_image" : @"create_alt")];
        }
    }
}

- (void)cleanUp
{
    self.hidden = YES;
    self.typing.hidden = YES;
    self.nextButton.hidden = YES;
    self.beginState.hidden = YES;
    self.keyboard.y = [Screen layer].height;
    
    self.showingImage = NO;
    self.showingAltFont = NO;
}

@end
