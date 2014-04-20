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

- (void)viewDidLoad;
- (void)viewDidAppear:(BOOL)animated;

- (void)checkForGameStateSegue;

// Used to handle response to Log Out button.
- (void)buttonTapped:(UIButton *)sender;

- (void)bringUpLogIn;
- (void)logInViewController:(COVLogInViewController *)controller
               didLogInUser:(PFUser *)user;
- (void)signUpViewController:(PFSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user;
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info;

- (IBAction)unwindToMain:(UIStoryboardSegue *)segue;
- (IBAction)unwindAndLogOut:(UIStoryboardSegue *)segue;

@end
