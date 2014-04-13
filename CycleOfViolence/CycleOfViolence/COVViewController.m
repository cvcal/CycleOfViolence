//
//  COVViewController.m
//  CycleOfViolence
//
//  Created by Chloe Calvarin on 4/12/14.
//
//

#import "COVViewController.h"

@interface COVViewController ()

@end

@implementation COVViewController

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
    
    // Do any additional setup after loading the view.
    //[self.view setBackgroundColor:[UIColor whiteColor]];
    //UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"bloodsplatterSmaller.png"]];
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"whiteSplattered.png"]];
    //
    //    UIGraphicsBeginImageContext(self.view.frame.size);
    //    [[UIImage imageNamed:@"whiteSplattered.png"] drawInRect:self.view.bounds];
    //    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    //
    //    [self.view setBackgroundColor:[UIColor colorWithPatternImage:image]];
    
    //add background
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"whiteSplattered.png"]];
    [self.view addSubview:background];
    [self.view sendSubviewToBack:background];
    self.view.contentMode = UIViewContentModeScaleAspectFit;

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
