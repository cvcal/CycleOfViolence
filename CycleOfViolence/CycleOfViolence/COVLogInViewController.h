//
//  COVLogInViewController.h
//  CycleOfViolence
//
//  Created by Laptop 16 on 4/17/14.
//
//

#import <Parse/Parse.h>

@interface COVLogInViewController : PFLogInViewController

// Method overrides from PFLogInViewController and UIViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)viewDidLoad;
- (void)viewDidLayoutSubviews;
- (void)didReceiveMemoryWarning;
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

@property (nonatomic, strong) UIImageView *fieldsBackground;

@end
