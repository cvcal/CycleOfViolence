//
//  COVCreateGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import "COVViewController.h"
#import "COVGame.h"

@interface COVCreateGameViewController : COVViewController

// Method overrides from COVViewController and UIViewController
- (id)initWithCoder:(NSCoder *)aDecoder;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender;

// Own methods
- (IBAction)buttonTapped:(id)sender;

@end
