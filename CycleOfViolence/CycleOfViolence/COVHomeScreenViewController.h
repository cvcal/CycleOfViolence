//
//  COVHomeScreenViewController.h
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface COVHomeScreenViewController : UIViewController

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

// Used to handle response to Log Out button.
- (void)buttonTapped:(UIButton *)sender;

- (void)bringUpLogIn;
- (void)logInViewController:(PFLogInViewController *)controller;
- (void)signUpViewController:(PFSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user;
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info;

-(IBAction)unwindToMain:(UIStoryboardSegue *)segue;

@end
