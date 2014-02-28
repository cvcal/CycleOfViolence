//
//  COVHomeScreenViewController.h
//  CycleOfViolence
//
//  Created by Laptop 16 on 2/23/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface COVHomeScreenViewController : UIViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

- (void)buttonTapped:(UIButton *)sender;

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (void)logInViewController:(PFLogInViewController *)controller;
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user;
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info;

-(IBAction)unwindToMainWithGame:(UIStoryboardSegue *)segue;
-(IBAction)unwindToMainWithoutGame:(UIStoryboardSegue *)segue;
@end
