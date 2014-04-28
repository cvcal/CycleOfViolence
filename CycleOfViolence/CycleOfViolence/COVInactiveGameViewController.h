//
//  COVInactiveGameViewController.h
//  CycleOfViolence
//
//  Created by Reyna Hulett on 3/6/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVInactiveGameViewController : COVViewController

- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;

// Handle various button presses.
- (IBAction)buttonTapped:(id)sender;

@end
