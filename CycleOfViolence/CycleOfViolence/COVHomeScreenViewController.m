//
//  COVHomeScreenViewController.m
//  CycleOfViolence
//
//  Created by Laptop 16 on 2/23/14.
//
//

#import "COVHomeScreenViewController.h"

@interface COVHomeScreenViewController ()
@property (weak, nonatomic) IBOutlet UIButton *logOut;

@end

@implementation COVHomeScreenViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self bringUpLoginIfNoUser];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)bringUpLoginIfNoUser {
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
        logInViewController.fields = PFLogInFieldsUsernameAndPassword
        | PFLogInFieldsLogInButton
        | PFLogInFieldsSignUpButton
        | PFLogInFieldsPasswordForgotten;
        
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        
        // Create the sign up view controller
        PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];
        
        // Present the log in view controller
        [self presentViewController:logInViewController animated:YES completion:NULL];
    }
}

- (void)buttonTapped:(UIButton *)sender {
    if (sender != self.logOut) {
        return;
    } else {
        [PFUser logOut];
        [self bringUpLoginIfNoUser];
    }
}

// If logOut is tapped, log out the user and bring up the modal login.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // do we still need this?
}

// Dismiss the modal login after successful login.
- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:NULL]; // Dismiss the PFSignUpViewController
}

// Verify hmc email address. Otherwise, display an alert.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info {
    NSString *email = info[@"email"];
    NSString *requiredEnding = @"@hmc.edu";
    BOOL returnVal;
    if ([email length] > [requiredEnding length]) {
        NSString *ending = [email substringFromIndex:[email length] - [requiredEnding length]];
        returnVal = [ending isEqual: @"@hmc.edu"]; // prevent sign up if not HMC email
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
}

// Allow COVHomeScreenViewController to be unwound to.
-(IBAction)unwindToMainWithGame:(UIStoryboardSegue *)segue {
    // Currently we do all of the work in prepareForSegue
    // It may be better style to do it here.
}

// Allow COVHomeScreenViewController to be unwound to.
-(IBAction)unwindToMainWithoutGame:(UIStoryboardSegue *)segue {
    //do stuff
}



@end
