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
    [self.signUpView setLogo:[[UIImageView alloc]
                              initWithImage:[UIImage imageNamed:@"COVTitle.png"]]];
    
    // Make image for normal button appearance.
    UIImage *defaultButtonImage = [UIImage imageNamed:@"fatbutton.png"];
    defaultButtonImage = [defaultButtonImage
                          resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    // Make image for highlighted button appearance.
    UIImage *highlightedButtonImage = [UIImage imageNamed:@"fatredbutton.png"];
    highlightedButtonImage = [defaultButtonImage
                              resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20.0, 0, 20.0)];
    
    // Set the backgrounds for the signUp button.
    [self.signUpView.signUpButton setBackgroundImage:defaultButtonImage
                                            forState:UIControlStateNormal];
    [self.signUpView.signUpButton setBackgroundImage:highlightedButtonImage
                                            forState:UIControlStateHighlighted];
    [self.signUpView.dismissButton
     setBackgroundImage:[UIImage imageNamed:@"clearButton.png"] forState:UIControlStateNormal];
    [self.signUpView.dismissButton
     setBackgroundImage:[UIImage imageNamed:@"clearButton.png"]forState:UIControlStateNormal];
    
    // Rename the textfields and and change the text color to white, background color to black
    self.signUpView.usernameField.attributedPlaceholder = [[NSAttributedString alloc]
                            initWithString:@"Email"
                                attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.signUpView.passwordField.attributedPlaceholder = [[NSAttributedString alloc]
                            initWithString:@"Password"
                                attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.signUpView.additionalField.attributedPlaceholder = [[NSAttributedString alloc]
                            initWithString:@"Full Name"
                                attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    self.signUpView.usernameField.backgroundColor = [UIColor blackColor];
    self.signUpView.passwordField.backgroundColor = [UIColor blackColor];
    self.signUpView.additionalField.backgroundColor = [UIColor blackColor];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // Set frame for elements. 
    [self.signUpView.logo setFrame:CGRectMake(66.5f, 45.0f, 200.0f, 80.5f)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
