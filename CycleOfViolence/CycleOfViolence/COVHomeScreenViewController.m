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

- (void)checkForGameStateSegue
{
    PFUser *currUser = [PFUser currentUser];
    
    [currUser refresh];
    
    if (currUser[@"currentGameID"] != [NSNull null]) {
        NSLog(@"The user is in a game.");
        
        // Since games can be deleted without notifying the users in the game, we need
        // to check if the game that currentGameID identifies still exists.
        PFQuery *gameExistence = [PFQuery queryWithClassName: @"COVGame"];
        [gameExistence getObjectInBackgroundWithId:currUser[@"currentGameID"]
                                             block:^(PFObject* returnObj, NSError *error) {
            if (returnObj == nil) {
                NSLog(@"Game has been deleted.");
                [[[UIAlertView alloc] initWithTitle:@"Game Deleted"
                                            message:@"The game you were in has been removed."
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
                currUser[@"currentGameID"] = [NSNull null];
                [currUser saveInBackground];
            } else {
                NSLog(@"User is STILL in a game!");
                COVGame * currGame = (COVGame *)returnObj;
                // A game has either started, or it hasn't, and they should go to different views.
                if (currGame.gameStarted) {
                    [self performSegueWithIdentifier:@"ToActiveGame" sender:self];
                } else {
                    [self performSegueWithIdentifier:@"ToInactiveGame" sender:self];
                }
            }
        }];
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
    user[@"currentGameID"] = [NSNull null];
    [user saveInBackground];
}

- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController
            shouldBeginSignUp:(NSDictionary *)info
{
    // We currently do not require a specific email address type
    return true;
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
