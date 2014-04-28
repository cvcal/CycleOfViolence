//
//  COVGameMainViewController.h
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 3/6/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVGameMainViewController : COVViewController

// Track the game locally for convenience.
@property COVGame *currentGame;

// Method overrides from COVViewController and UIViewController.
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

// Handle the various button inputs (identified by sender).
- (IBAction)buttonTapped:(id)sender;
// Update the user's target and declare them winner if they are the last alive.
- (void)refreshTarget;


@end
