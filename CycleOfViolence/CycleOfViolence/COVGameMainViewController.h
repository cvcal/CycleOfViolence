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

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

// Track the game locally
@property COVGame *currGame;

@end
