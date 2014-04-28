//
//  COVHomeScreenViewController.h
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"
#import "COVLogInViewController.h"
#import "COVSignUpViewController.h"

@interface COVHomeScreenViewController : COVViewController

// Method overrides from COVViewController and UIViewController.
- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;
- (void)checkForGameStateSegue;


// Used to handle response to Log Out button.
- (IBAction)logOutButtonTapped:(id)sender;

// Displays the modal logIn view.
- (void)bringUpLogIn;

// Used by logIn view.
- (void)logInViewController:(COVLogInViewController *)controller
               didLogInUser:(PFUser *)user;

// Used by signUp view.
- (void)signUpViewController:(PFSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user;

// Check to see if we should start signing up the user.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info;


// Unwind methods
- (IBAction)unwindToMain:(UIStoryboardSegue *)segue;
- (IBAction)unwindAndLogOut:(UIStoryboardSegue *)segue;


@end
