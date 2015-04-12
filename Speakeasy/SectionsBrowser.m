//
//  SectionsBrowser.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "SectionsBrowser.h"
#import "ItemList.h"
#import "List.h"

@implementation SectionsBrowser

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        List *list = [[List alloc] initWithParent:self];
        Layer *trending = [[ItemList alloc] initWithParent:list];
        list.height = trending.height;
//        Layer *mine = [[ItemList alloc] initWithParent:self];
//        mine.x = trending.width;
//
//        Layer *browser = self;
//        self.onTouchMove = ^(NSSet *touches) {
//            UITouch* touch = [touches anyObject];
//            CGPoint current = [touch locationInView:browser];
//            CGPoint previous = [touch previousLocationInView:browser];
//            
//            CGPoint delta;
//            delta.x = current.x - previous.x;
//            delta.y = current.y - previous.y;
//        };
    }
    return self;
}

@end
