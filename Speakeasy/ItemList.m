//
//  ItemList.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "ItemList.h"
#import "Screen.h"

@implementation ItemList

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (!self) return self;
    
    Screen *screen = [Screen layer];
    
    for (int i = 0; i < 8; i++) {
        Layer *item1 = [[Layer alloc] initWithParent:self];
        if (i % 2 == 0) {
            [item1 loadImage:@"item_1"];
        } else {
            [item1 loadImage:@"item_3"];
        }
        item1.x = 8;
        item1.y = i * (item1.height + 8) + 8;

        Layer *item2 = [[Layer alloc] initWithParent:self];
        if (i % 2 == 0) {
            [item2 loadImage:@"item_2"];
        } else {
            [item2 loadImage:@"item_4"];
        }
        item2.x = screen.width - item2.width - 8;
        item2.y = i * (item2.height + 8) + 8;
    }
    
    self.height = 8 * (((Layer *)self.subviews.firstObject).height + 8) + 8;

    return self;
}

@end
