//
//  AppDelegate.m
//  Speakeasy
//
//  Created by Levi McCallum on 8/18/14.
//  Copyright (c) 2014 Enigma Labs. All rights reserved.
//

#import "AppDelegate.h"
#import "Screen.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Initialize fullscreen window
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UIViewController alloc] init];
    [self.window makeKeyAndVisible];
    
    // Initialize screen
    [Screen initWithWindow:self.window];

    return YES;
}

@end
