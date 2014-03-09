//
//  COVHomeScreenViewController.h
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "COVGame.h"

@interface COVHomeScreenViewController : UIViewController

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)didReceiveMemoryWarning;

- (void)checkForGameStateSegue;

// Used to handle response to Log Out button.
- (void)buttonTapped:(UIButton *)sender;

- (void)bringUpLogIn;
- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user;
- (void)signUpViewController:(PFSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user;
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info;

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue;
- (IBAction)unwindAndLogOut:(UIStoryboardSegue *)segue;

@end
