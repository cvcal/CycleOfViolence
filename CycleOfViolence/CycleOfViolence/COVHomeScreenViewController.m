//
//  COVHomeScreenViewController.m
//  CycleOfViolence
//
//  Created by Reyna Hulett on 2/23/14.
//
//

#import "COVHomeScreenViewController.h"

@interface COVHomeScreenViewController ()

// This is a private property, the button on the storyboard we need to interact with.
@property (weak, nonatomic) IBOutlet UIButton *logOutButton;
@property (weak, nonatomic) IBOutlet UIButton *createGameButton;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;

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
    [super viewDidAppear:NO];
    // Make sure this is the right screen to be displaying.
    if ([PFUser currentUser]) {
        [self checkForGameStateSegue];
    } else {
        [self bringUpLogIn];
    }
}

- (void)checkForGameStateSegue
{
    PFUser *currUser = [PFUser currentUser];
    
    [currUser refresh];
    
    if (currUser[@"currentGameID"] != [NSNull null] && currUser[@"currentGameID"] != nil) {
        NSLog(@"The user is in a game.");
        
        // Retrieve the game.
        PFQuery *game = [PFQuery queryWithClassName: @"COVGame"];
        [game getObjectInBackgroundWithId:currUser[@"currentGameID"]
                                             block:^(PFObject* returnObj, NSError *error) {
            COVGame *currGame = (COVGame *)returnObj;
            // Since we don't notify users if their game is aborted, we need to check that
            // now.
            if (currGame.state == aborted) {
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
                // A game has either started, or it hasn't, and they should go to different views.
                if (currGame.state == inProgress) {
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
    if (sender != self.logOutButton) {
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
    COVLogInViewController *logInViewController = [[COVLogInViewController alloc] init];
    logInViewController.fields = PFLogInFieldsUsernameAndPassword
    | PFLogInFieldsLogInButton
    | PFLogInFieldsSignUpButton
    | PFLogInFieldsPasswordForgotten;
    
    [logInViewController setDelegate:(id)self]; // Set ourselves as the delegate
    
    // Create the sign up view controller
    COVSignUpViewController *signUpViewController = [[COVSignUpViewController alloc] init];
    signUpViewController.fields = PFSignUpFieldsUsernameAndPassword
    | PFSignUpFieldsSignUpButton
    | PFSignUpFieldsAdditional
    | PFSignUpFieldsDismissButton;
    [signUpViewController setDelegate:(id)self]; // Set ourselves as the delegate
    
    // Assign our sign up controller to be displayed from the login controller
    [logInViewController setSignUpController:signUpViewController];
    
    // Present the log in view controller
    [self presentViewController:logInViewController animated:NO completion:NULL];
}

// Dismiss the modal login after successful login.
- (void)logInViewController:(COVLogInViewController *)controller
               didLogInUser:(PFUser *)user
{
    [self dismissViewControllerAnimated:NO completion:NULL];
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(COVSignUpViewController *)signUpController
               didSignUpUser:(PFUser *)user
{
    user[@"currentGameID"] = [NSNull null];
    user[@"gameHistory"] = [[NSMutableArray alloc] init];
    // Since we use the email as the username, we only need to request it once
    // as a username and then set the two equal here.
    user[@"email"] = [user username];
    user[@"fullName"] = signUpController.signUpView.additionalField.text;
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            NSLog(@"Sucessfully saved user in background after dismissing sign up");
            // Dismiss the COVSignUpViewController. We do this last so that
            // viewDidAppear is called after we've saved our new user.
            [self dismissViewControllerAnimated:NO completion:NULL];
        } else {
            NSLog(@"Failed to save in background after dismissing sigh up.");
            [[[UIAlertView alloc]
                       initWithTitle:@"Cloud save failed"
                             message:@"Which is sad. Your user values weren't initialized properly."
                            delegate:nil
                   cancelButtonTitle:@"ok"
                   otherButtonTitles:nil] show];
        }
    }];
}

- (BOOL)signUpViewController:(COVSignUpViewController *)signUpController
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
}

@end
