//
//  ChangeImage.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "ChangeImage.h"

@interface ChangeImage ()

@property (weak, nonatomic) Layer *imagePreview;
@property (weak, nonatomic) Layer *picker;

@property (assign, nonatomic) BOOL showingKeyboard;
@property (assign, nonatomic) BOOL showingAltFont;
@property (assign, nonatomic) BOOL showingAltImage;

@end

@implementation ChangeImage

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        [self loadImage:@"change_image"];
        self.backgroundColor = [UIColor whiteColor];
        
        Layer *imageButton = [[Layer alloc] initWithParent:self];
        [imageButton loadImage:@"image_button_active"];
        imageButton.x = 174;
        imageButton.y = 507;
        imageButton.onTouchUp = ^(NSSet *touches) {
            [UIView animateWithDuration:0.4 animations:^{
                self.alpha = 0;
            } completion:^(BOOL finished) {
                self.hidden = YES;
            }];
        };
        
        Layer *fontButton = [[Layer alloc] initWithParent:self];
        [fontButton loadImage:@"font_button"];
        fontButton.x = 100.0;
        fontButton.y = 507.0;
        fontButton.onTouchUp = ^(NSSet *touches) {
            self.showingAltFont = self.showingAltFont ? NO : YES;
        };
        [self addObserver:self forKeyPath:@"showingAltFont" options:0 context:nil];

        Layer *keyboard = [[Layer alloc] initWithParent:self];
        [keyboard loadImage:@"keyboard"];
        keyboard.y = self.height;
        
        Layer *imagePreview = [[Layer alloc] initWithParent:self];
        [imagePreview loadImage:@"picker_image"];
        _imagePreview = imagePreview;
        imagePreview.onTouchUp = ^(NSSet *touches) {
            if (self.showingKeyboard) {
                [UIView animateWithDuration:0.4 animations:^{
                    self.picker.y = 334.5;
                    keyboard.y = self.height;
                } completion:^(BOOL finished) {
                    self.showingKeyboard = NO;
                }];
            } else {
                [UIView animateWithDuration:0.4 animations:^{
                    self.alpha = 0;
                } completion:^(BOOL finished) {
                    self.hidden = YES;
                }];
            }
        };
        
        Layer *picker = [[Layer alloc] initWithParent:self];
        [picker loadImage:@"picker"];
        picker.y = 334.5;
        _picker = picker;
        picker.onTouchUp = ^(NSSet *touches) {
            UITouch *touch = [touches anyObject];
            CGPoint location = [touch locationInView:self.picker];
            if (location.y >= 131 && self.showingKeyboard == NO) {
                self.showingKeyboard = YES;
                [UIView animateWithDuration:0.4 animations:^{
                    self.picker.y = 185;
                    keyboard.y = 185 + self.picker.height;
                }];
            } else {
                self.showingAltImage = self.showingAltImage ? NO : YES;
            }
        };
        [self addObserver:self forKeyPath:@"showingAltImage" options:0 context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"showingAltImage"] || [keyPath isEqualToString:@"showingAltFont"]) {
        if (self.showingAltImage) {
            [self.picker loadImage:(self.showingAltFont ? @"picker_alt" : @"picker")];
            [self.imagePreview loadImage:(self.showingAltFont ? @"picker_image_alt" : @"picker_image")];
        } else {
            [self.picker loadImage:(self.showingAltFont ? @"picker_alt_second" : @"picker_second")];
            [self.imagePreview loadImage:(self.showingAltFont ? @"picker_image_second_alt" : @"picker_image_second")];
        }
    }
}

@end
