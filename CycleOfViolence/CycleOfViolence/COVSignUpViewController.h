//
//  COVSignUpViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 4/20/14.
//
//

#import <Parse/Parse.h>

@interface COVSignUpViewController : PFSignUpViewController

// Method overrides from PFSignUpViewController and UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (void)didReceiveMemoryWarning;

@end
