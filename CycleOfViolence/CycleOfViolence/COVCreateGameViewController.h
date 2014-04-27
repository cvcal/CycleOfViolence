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

// Own methods
- (IBAction)buttonTapped:(id)sender;
// Called when return is pressed in one of the text fields.
- (BOOL)textFieldShouldReturn:(UITextField *)textField;

@end
