//
//  COVLogInViewController.h
//  CycleOfViolence
//
//  Created by John Phillpot on 4/17/14.
//
//

#import <Parse/Parse.h>

@interface COVLogInViewController : PFLogInViewController

@property (nonatomic, strong) UIImageView *fieldsBackground;

// Method overrides from PFLogInViewController
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@end
