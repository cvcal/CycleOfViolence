#import <Parse/Parse.h>
#import "ParseStarterProjectAppDelegate.h"
#import "ParseStarterProjectViewController.h"

@implementation ParseStarterProjectAppDelegate


#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Parse setApplicationId:@"BEVfOYy7YCJRCjgrOXtOTifPUOPS2TTfmg0CGIUB"
                  clientKey:@"Lz7BVLm3vv3JHM0BnC64wfA4galQATP5iNSkwFyD"];

    //[PFUser enableAutomaticUser];
    [PFUser logOut]; //log out user... until we have an actual logout button FIXME
    
    PFACL *defaultACL = [PFACL ACL];

    // If you would like all objects to be private by default, remove this line.
    [defaultACL setPublicReadAccess:YES];
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Override point for customization after application launch.
     
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword
            | PFLogInFieldsLogInButton
            | PFLogInFieldsSignUpButton
            | PFLogInFieldsPasswordForgotten;
        
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        
        // Create the sign up view controller
        // sign up is enabled even if you only have the logInViewController
        // but this way you can keep the dismiss button for signup, and return to login
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self.viewController presentModalViewController:logInViewController animated:YES];
    }

    
    if (application.applicationState != UIApplicationStateBackground) {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced
        // in iOS 7). In that case, we skip tracking here to avoid double
        // counting the app-open.
        BOOL preBackgroundPush = ![application respondsToSelector:@selector(backgroundRefreshStatus)];
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = ![launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (preBackgroundPush || oldPushHandlerOnly || noPushPayload) {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge|
                                                    UIRemoteNotificationTypeAlert|
                                                    UIRemoteNotificationTypeSound];
    return YES;
}

/*
 
///////////////////////////////////////////////////////////
// Uncomment this method if you are using Facebook
///////////////////////////////////////////////////////////
 
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
    sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [PFFacebookUtils handleOpenURL:url];
} 
 
*/

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)newDeviceToken {
    [PFPush storeDeviceToken:newDeviceToken];
    [PFPush subscribeToChannelInBackground:@"" target:self selector:@selector(subscribeFinished:error:)];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    if (error.code == 3010) {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    } else {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
	}
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];

    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark - ()

- (void)subscribeFinished:(NSNumber *)result error:(NSError *)error {
    if ([result boolValue]) {
        NSLog(@"ParseStarterProject successfully subscribed to push notifications on the broadcast channel.");
    } else {
        NSLog(@"ParseStarterProject failed to subscribe to push notifications on the broadcast channel.");
    }
}

- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    [self.viewController dismissModalViewControllerAnimated:YES];
    user[@"inGame"] = @YES;
    [user save];
    
    PFQuery *query = [PFQuery queryWithClassName:@"_User"];
    [query whereKey:@"inGame" equalTo:@NO];
    [query getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (!object) {
            NSLog(@"The getFirstObject request failed.");
        } else {
            // The find succeeded.
            NSLog(@"Successfully retrieved the object.");
            user[@"target"] = object;
            //object[@"target"] = user; // can't modify User if not loggedIn
            // or at least it doesn't work here and I couldn't get it to work
            // in CloudCode
            [user save];
        }
    }];
//    PFQuery *query = [PFQuery queryWithClassName:@"User"];
//    [query whereKey:@"inGame" equalTo:@YES];
//    [PFCloud callFunctionInBackground:@"makeTargetCycle"
//                       withParameters:@{@"query": query}
//                       block:^(NSNumber *success, NSError *error) {
//                           if (!error) {
//                               [user save]; // inGame changes, but target still doesn't (but no error?)
//                               NSLog(@"hey it worked");
//                           } else {
//                               NSLog(@"failure");
//                           }
//    }];
}


// I've been changing self to self.viewController all over the place, I think because
// this code could be written in a view controller or the app delegate
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self.viewController dismissModalViewControllerAnimated:YES];
}

// possible way to restrict email by 5C students?
// you can make it display an alert specific to a given error
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info {
    NSString *email = info[@"email"];
    BOOL returnVal;
    if ([email length] > 7) {
        NSString *ending = [email substringFromIndex:[email length] - 7];
        returnVal = [ending isEqual: @"hmc.edu"]; // prevent sign up if not HMC email
    } else {
        returnVal = NO;
    }
    
    // invalid email
    if (!returnVal) {
        [[[UIAlertView alloc] initWithTitle:@"Invalid Email Address"
                                    message:@"Make sure you use a Harvey Mudd account!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    return returnVal;
};


- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
    // Not sure how to make an alert like they have for incorrect login, even
}

@end
