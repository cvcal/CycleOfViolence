//
//  COVLogInViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 4/17/14.
//
//

#import "COVLogInViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface COVLogInViewController ()

@end

@implementation COVLogInViewController

@synthesize fieldsBackground;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add the bloody background image
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]]];
    
    // Add the logo
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Placeholder.png"]]];
    
    // Set the backgrounds for the signUp button. The latter background appears when the button is pressed.
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateHighlighted];
    
    // Set the backgrounds for the logIn button. The latter background appears when the button is pressed.
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateHighlighted];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    [self.logInView.logo setFrame:CGRectMake(66.5f, 45.0f, 187.0f, 58.5f)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
