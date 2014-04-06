//
//  COVGameMainViewController.h
//  CycleOfViolence
//
//  Created by Chloé Calvarin on 3/6/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "COVGame.h"

@interface COVGameMainViewController : UIViewController

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;

// Track the game locally
@property COVGame *currGame;

@end
