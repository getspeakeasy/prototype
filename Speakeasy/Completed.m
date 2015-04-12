//
//  CompletedSpeak.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "Completed.h"
#import "ChangeImage.h"
#import "Share.h"
#import "Screen.h"

@interface Completed ()

@property (weak, nonatomic) ChangeImage *changeImage;

@end

@implementation Completed

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        [self loadImage:@"completed_text"];
        
        Layer *screen = [Screen layer];
        
        Layer *imageButton = [[Layer alloc] initWithParent:self];
        [imageButton loadImage:@"image_button"];
        imageButton.x = 174;
        imageButton.y = 507;
        imageButton.onTouchUp = ^(NSSet *touches) {
          [UIView animateWithDuration:0.4 animations:^{
              if (self.showingImage) {
                  self.changeImage.alpha = 0;
                  self.showingImage = NO;
              } else {
                  self.changeImage.hidden = NO;
                  self.changeImage.alpha = 1;
                  self.showingImage = YES;
              }
          } completion:^(BOOL finished) {
              if (!self.addedImage) {
                  [self loadImage:@"completed"];
                  self.addedImage = YES;
              }
              if (self.showingImage == NO) {
                  self.changeImage.hidden = YES;
              }
          }];
        };
        
        Layer *fontButton = [[Layer alloc] initWithParent:self];
        [fontButton loadImage:@"font_button"];
        fontButton.x = 100.0;
        fontButton.y = 507.0;
        fontButton.onTouchUp = ^(NSSet *touches) {
            if (self.showingAltImage) {
                [self loadImage:(self.addedImage ? @"completed" : @"completed_text")];
                self.showingAltImage = NO;
            } else {
                [self loadImage:(self.addedImage ? @"completed_alt" : @"completed_text_alt")];
                self.showingAltImage = YES;
            }
        };
        
        ChangeImage *changeImage = [[ChangeImage alloc] initWithParent:self];
        changeImage.hidden = YES;
        changeImage.alpha = 0;
        _changeImage = changeImage;
        
        Layer *closeButton = [[Layer alloc] initWithParent:self];
        [closeButton loadImage:@"close_button"];
        closeButton.x = 10;
        closeButton.y = 10;
        closeButton.onTouchUp = ^(NSSet *touches) {
            [UIView animateWithDuration:0.4 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        };
        
        Layer *nextButton = [[Layer alloc] initWithParent:self];
        [nextButton loadImage:@"next_button"];
        nextButton.x = 280;
        nextButton.y = 10;
        nextButton.onTouchUp = ^(NSSet *touches) {
            Share *share = [[Share alloc] initWithParent:screen];
            share.alpha = 0;
            [UIView animateWithDuration:0.4 animations:^{
                share.alpha = 1;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
        };
    }
    return self;
}

@end
