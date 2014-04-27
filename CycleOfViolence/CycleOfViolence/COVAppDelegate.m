//
//  COVAppDelegate.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import "COVAppDelegate.h"

@implementation COVAppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Set up interaction with Parse.
    [Parse setApplicationId:@"G2COjJL1DD77K0V0up4a7nJnlcNjYdziTC9J0Pow"
                  clientKey:@"H8WAWNmWVPFKQCfQWwQBtrCQ6kswGOGW5d1HXPef"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [[UIButton appearance] setTintColor: [UIColor blackColor]];
    
    // Add image for button appearance.
    UIImage *defaultButtonImage = [UIImage imageNamed:@"button.png"];
    defaultButtonImage = [defaultButtonImage
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    [[UIButton appearance] setBackgroundImage:defaultButtonImage forState:UIControlStateNormal];
        
    // Make Parse recognized COVGame as a real subclass of PFObject.
    [COVGame registerSubclass];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state.
    // Pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Release shared resources, save user data, invalidate timers, and store enough application
    // state information to restore your application to its current state if it is terminated later.
    // If your application supports background execution, this method is called instead of
    // applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; undo many of the
    // changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate.
}

@end
