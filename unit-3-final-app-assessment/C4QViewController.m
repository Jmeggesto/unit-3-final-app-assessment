//
//  ViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 11/30/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QViewController.h"
#import "C4QColorPickerViewController.h"
#import "C4QCatFactsDetailViewController.h"

@interface C4QViewController () <ColorPickerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *colorSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *onwardButton;


@end

@implementation C4QViewController



- (IBAction)selectAColorButtonTapped:(UIButton*)sender
{
    C4QColorPickerViewController *colorPickerViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ColorPickerViewController"];
    colorPickerViewController.delegate = self;
    [self.navigationController pushViewController:colorPickerViewController animated:YES];
    
    
    
}
-(void)colorPickerViewDidSelectColor:(UIColor *)color  {
    
    [self.colorSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.view.backgroundColor = color;
   
}
- (IBAction)onwardButtonTapped:(UIButton*)sender
{
    
    C4QCatFactsDetailViewController* catFactsController = [self.storyboard instantiateViewControllerWithIdentifier:@"C4QCatFactsTableViewController"];
    [self.navigationController pushViewController:catFactsController animated:YES];
    
    
}






@end
