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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Add the bloody background image
    [self.logInView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"blood_splatter_transparency_by_sagacious-d3h1yw6.png"]]];
    
    // Add the logo
    [self.logInView setLogo:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"COVTitle.png"]]];
    
    // Make image for normal button appearance.
    UIImage *defaultButtonImage = [UIImage imageNamed:@"fatbutton.png"];
    defaultButtonImage = [defaultButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    // Make image for highlighted button appearance.
    UIImage *highlightedButtonImage = [UIImage imageNamed:@"fatredbutton.png"];
    highlightedButtonImage = [defaultButtonImage resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];

    // Set the backgrounds for the signUp button. The latter background appears when the button is pressed.
    [self.logInView.signUpButton setBackgroundImage:defaultButtonImage forState:UIControlStateNormal];
    [self.logInView.signUpButton setBackgroundImage:highlightedButtonImage forState:UIControlStateHighlighted];
    
    // Set the backgrounds for the logIn button. The latter background appears when the button is pressed.
    [self.logInView.logInButton setBackgroundImage:defaultButtonImage forState:UIControlStateNormal];
    [self.logInView.logInButton setBackgroundImage:highlightedButtonImage forState:UIControlStateHighlighted];
    
    // Rename the textfields and and change the text color to white.
    self.logInView.usernameField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.logInView.passwordField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.logInView.usernameField.backgroundColor = [UIColor blackColor];
    self.logInView.passwordField.backgroundColor = [UIColor blackColor];
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Set frame for elements
    [self.logInView.logo setFrame:CGRectMake(66.5f, 45.0f, 200.0f, 80.5f)];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



@end
