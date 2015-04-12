//
//  Reply.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "Reply.h"

@implementation Reply

- (instancetype)initWithParent:(UIView *)parent
{
    self = [super initWithParent:parent];
    if (self) {
        [self loadImage:@"reply"];
    }
    return self;
}

@end
