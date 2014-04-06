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
	
    // Set the view controller to display information about its current game.
    self.gameInfo.text = [NSString stringWithFormat:@"Game name: %@\n",
                          self.currentGame.name];
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

// Handle joining game and unwinding to home screen after saving user
// (so checkForGameStateSegue will have accurate information).
- (IBAction)buttonTapped:(id)sender
{
    if (sender == self.joinGameButton) {
        NSLog(@"Called prepareForSegue from Join Game button.");
        PFUser *currUser = [PFUser currentUser];
        [self.currentGame addPlayer:currUser]; // This method also saves the game.
        
        // Save the game and manually return to the home screen when finished.
        [currUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (succeeded) {
                NSLog(@"Sucessfully saved in background.");
                
                // Since user is now in the game, return them to the home screen.
                [self performSegueWithIdentifier:@"toHomeScreenFromConfirm" sender:self];
                
            } else {
                NSLog(@"Failed to save in background.");
            }
        }];
    } else {
        return;
    }
}

// Add the user to the game if they selected Join Game.
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"Called prepareForSegue.");
}

@end
