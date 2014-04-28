//
//  COVConfirmJoinGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 3/1/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVConfirmJoinGameViewController : COVViewController

// Store game locally for convenience.
@property COVGame *currentGame;

// Method overrides from COVViewController and UIViewController.
- (void)viewDidLoad;

// Handle input from buttons on storyboard.
- (IBAction)buttonTapped:(id)sender;

@end
