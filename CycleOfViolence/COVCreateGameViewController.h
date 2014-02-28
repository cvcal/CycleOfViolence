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

@property NSString *inputName;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
- (void)viewDidLoad;
- (void)didReceiveMemoryWarning;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;


@end
