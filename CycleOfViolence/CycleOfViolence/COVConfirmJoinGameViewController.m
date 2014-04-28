//
//  COVConfirmJoinGameViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import "COVConfirmJoinGameViewController.h"

@interface COVConfirmJoinGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *gameInfo;
@property (weak, nonatomic) IBOutlet UILabel *countdown;
@property (weak, nonatomic) IBOutlet UITextView *rules;
@property (weak, nonatomic) IBOutlet UIButton *joinGameButton;

@end

@implementation COVConfirmJoinGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    // Set the view controller to display information about its current game.
    self.gameInfo.text = [NSString stringWithFormat:@"Game name: %@\n",
                          self.currentGame.name];
    
    // Calculate time left to game start.
    NSTimeInterval timeToStart = [self.currentGame.startTime timeIntervalSinceNow];
    if (timeToStart <= 0) {
        self.countdown.text = @"Starting soon...";
    } else {
        NSInteger days = (int) ( timeToStart / (3600*24) );
        NSInteger hours = ( (int) timeToStart % (3600*24) ) / 3600;
        self.countdown.text = [NSString stringWithFormat:@"Starting in %ld days, %ld hours.",
                               (long)days, (long)hours];
    }
    
    self.rules.text = self.currentGame.rules;
}

// Handle joining game and unwinding to home screen after saving user
// (so checkForGameStateSegue will have accurate information).
- (IBAction)buttonTapped:(id)sender
{
    if (sender == self.joinGameButton) {
        NSLog(@"Called prepareForSegue from Join Game button.");
        // Disable button during operation (so that users cannot press it more than once).
        [self.joinGameButton setEnabled:NO];
        
        PFUser *currentUser = [PFUser currentUser];
        [self.currentGame addPlayer:currentUser];
        
        // Save the game and manually and return to the home screen when finished.
        [self.currentGame saveInBackground];
        [currentUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
                
                // Since user is now in the game, return them to the home screen.
                // (The homescreen redirects users appropriately based on their game status.)
                [self performSegueWithIdentifier:@"toHomeScreenFromConfirm" sender:self];
                
            } else {
                NSLog(@"Failed to save in background.");
                [[[UIAlertView alloc] initWithTitle:@"Cloud save failed"
                                            message:@"Please try again some other time."
                                           delegate:nil
                                  cancelButtonTitle:@"ok"
                                  otherButtonTitles:nil] show];
            }
        }];
        
        // Re-enable button if save failed.
        [self.joinGameButton setEnabled:NO];
    } else {
        return;
    }
}

@end
