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

// Method overrides from COVViewController and UIViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;

// Own methods
- (IBAction)buttonTapped:(id)sender;

@end
