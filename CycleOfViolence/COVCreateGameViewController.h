//
//  COVCreateGameViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 2/23/14.
//
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "COVGame.h"

@interface COVCreateGameViewController : UIViewController

//@property

- (IBAction) unwindToMainWithGame:(UIStoryboardSegue *)segue;

@end
