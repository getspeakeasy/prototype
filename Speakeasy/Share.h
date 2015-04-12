//
//  Share.h
//  Speakeasy
//
//  Created by Levi McCallum on 8/19/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "ToastKit.h"

@interface Share : Layer

@property (assign, nonatomic) BOOL speakeasyEnabled;
@property (assign, nonatomic) BOOL twitterEnabled;
@property (assign, nonatomic) BOOL facebookEnabled;

@property (assign, nonatomic) BOOL captionEnabled;

@property (assign, nonatomic) int shareButtonsEnabled;

@property (strong, nonatomic) Layer *caption;
@property (strong, nonatomic) Layer *speakeasyButton;
@property (strong, nonatomic) Layer *twitterButton;
@property (strong, nonatomic) Layer *facebookButton;
@property (strong, nonatomic) Layer *saveButton;

@end
