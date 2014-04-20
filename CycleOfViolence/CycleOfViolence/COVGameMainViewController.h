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

// Method overrides from COVViewController and UIViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

// Own methods
- (IBAction)buttonTapped:(id)sender;

// Track the game locally
@property COVGame *currGame;

@end
