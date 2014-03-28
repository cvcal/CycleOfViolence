//
//  COVHomeScreenViewController.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import "COVHomeScreenViewController.h"

@interface COVHomeScreenViewController ()

// These is a private propertie, the button on the storyboard we need to interact with.
@property (weak, nonatomic) IBOutlet UIButton *logOut;

@end


@implementation COVHomeScreenViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    // Users can only access the app if they are logged in.
    if (![PFUser currentUser]) {
        [self bringUpLogIn];
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    // Make sure this is the right screen to be displaying.
    [self checkForGameStateSegue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkForGameStateSegue
{
    PFUser *currUser = [PFUser currentUser];
    [currUser refresh];
    if (currUser[@"currentGameID"] != [NSNull null] && currUser[@"currentGameID"] != nil) {
        NSLog(@"The user is in a game.");
        COVGame *currGame = (COVGame *)[PFQuery getObjectOfClass:@"COVGame"
                                                         objectId:currUser[@"currentGameID"]];
        
        // A game has either started, or it hasn't.
        if (currGame.gameStarted) {
            [self performSegueWithIdentifier:@"ToActiveGame" sender:self];
        } else {
            [self performSegueWithIdentifier:@"ToInactiveGame" sender:self];
        }
        
    } else {
        NSLog(@"The user is not in a game yet.");
    }
}

- (void)buttonTapped:(UIButton *)sender
{
    if (sender != self.logOut) {
        return;
    } else {
        // Log out the user and return to the log in/sign up modal.
        [PFUser logOut];
        [self bringUpLogIn];
    }
}

- (void)bringUpLogIn
{
    // Create the log in view controller.
    PFLogInViewController *logInViewController = [[PFLogInViewController alloc] init];
    logInViewController.fields = PFLogInFieldsUsernameAndPassword
    | PFLogInFieldsLogInButton
    | PFLogInFieldsSignUpButton
    | PFLogInFieldsPasswordForgotten;
    
    [logInViewController setDelegate:(id)self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    PFSignUpViewController *signUpViewController = [[PFSignUpViewController alloc] init];
    [signUpViewController setDelegate:(id)self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:YES completion:NULL];
}

// Dismiss the modal login after successful login.
- (void)logInViewController:(PFLogInViewController *)controller
               didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:YES completion:NULL]; // Dismiss the PFSignUpViewController
}

// Verify hmc email address. Otherwise, display an alert.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
           shouldBeginSignUp:(NSDictionary *)info
{
    NSString *email = info[@"email"];
    NSString *requiredEnding = @"@hmc.edu";
    BOOL returnVal;
    if ([email length] > [requiredEnding length]) {
        NSString *ending = [email substringFromIndex:[email length] - [requiredEnding length]];
        returnVal = [ending isEqual: @"@hmc.edu"]; // prevent sign up if not HMC email
    } else {
        returnVal = NO;
    }
    
    // Invalid email, so display alert.
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
- (IBAction)unwindToMain:(UIStoryboardSegue *)segue
{
    // Nothing else to do. Actions handled in prepareForSegue.
}

- (IBAction)unwindAndLogOut:(UIStoryboardSegue *)segue
{
    [PFUser logOut];
    [self bringUpLogIn];
}

@end
