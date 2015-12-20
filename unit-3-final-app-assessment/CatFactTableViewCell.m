//
//  CatFactTableViewCell.m
//  unit-3-final-app-assessment
//
//  Created by Jackie Meggesto on 12/19/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "CatFactTableViewCell.h"

@implementation CatFactTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}
- (IBAction)saveFactButtonTapped:(UIButton*)sender {
    
    
    if(![[NSUserDefaults standardUserDefaults] objectForKey:@"SavedCatFacts"]){
        
        NSMutableArray* savedCatFacts = [[NSMutableArray alloc]initWithObjects:self.catFactLabel.text, nil];
        [[NSUserDefaults standardUserDefaults] setObject:savedCatFacts forKey:@"SavedCatFacts"];
        
    } else {
        
    
        NSMutableArray* savedCatFactsCopy = [[[NSUserDefaults standardUserDefaults] arrayForKey:@"SavedCatFacts"] mutableCopy];
        [savedCatFactsCopy addObject:self.catFactLabel.text];
        [[NSUserDefaults standardUserDefaults] setObject:savedCatFactsCopy forKey:@"SavedCatFacts"];
        
        
    }
    
    
    NSLog(@"the cat fact label text be %@", self.catFactLabel.text);
    
}



@end
