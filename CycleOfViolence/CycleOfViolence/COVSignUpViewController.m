//
//  COVSignUpViewController.m
//  CycleOfViolence
//
//  Created by John Phillpot on 4/20/14.
//
//

#import "COVSignUpViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface COVSignUpViewController ()

@end

@implementation COVSignUpViewController

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
    [self.signUpView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]]];
    
    // Add the logo
    [self.signUpView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Placeholder.png"]]];
    
    // Set the backgrounds for the signUp button. The latter background appears when the button is pressed.
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:[UIImage imageNamed:@"BlackBackground.png"] forState:UIControlStateHighlighted];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Set frame for elements.
    [self.signUpView.logo setFrame:CGRectMake(66.5f, 45.0f, 187.0f, 58.5f)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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