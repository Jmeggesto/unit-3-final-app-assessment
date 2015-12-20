//
//  C4QCatsTableViewController.m
//  unit-3-final-assessment
//
//  Created by Michael Kavouras on 12/17/15.
//  Copyright © 2015 Michael Kavouras. All rights reserved.
//

#import "C4QCatFactsTableViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "CatFactTableViewCell.h"
#import "SavedCatFactsTableViewController.h"
#import "C4QCatFactsDetailViewController.h"

#define CAT_API_URL @"http://catfacts-api.appspot.com/api/facts?number=100"

@interface C4QCatFactsTableViewController ()
@property (nonatomic) NSMutableArray* catFactsArray;


@end

@implementation C4QCatFactsTableViewController

- (void)viewDidLoad
{
    
    NSLog(@"%@", [[NSUserDefaults standardUserDefaults] arrayForKey:@"SavedCatFacts"]);
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Saved"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(transitionToSavedFactsTableView)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 12.0;
    
    
    
    
    [super viewDidLoad];
}

-(void)transitionToSavedFactsTableView {
    
    SavedCatFactsTableViewController* savedFacts = [self.storyboard instantiateViewControllerWithIdentifier:@"SavedCatFacts"];
    [self.navigationController pushViewController:savedFacts animated:YES];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [C4QCatFactsTableViewController requestForURL:CAT_API_URL WithCompletion:^(id response) {
        
        
        self.catFactsArray = [[NSMutableArray alloc]init];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
        NSArray* facts = [json objectForKey:@"facts"];
        for(NSString* fact in facts){
            
            [self.catFactsArray addObject:fact];
            
        }
        
      
        [self.tableView reloadData];
       
        
    }];
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.catFactsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CatFactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CatFactIdentifier" forIndexPath:indexPath];
    
    
    cell.catFactLabel.text = self.catFactsArray[indexPath.row];
    
    return cell;
}
+(void)requestForURL:(NSString*)string WithCompletion:(void (^)(id response))completionBlock {
    
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:CAT_API_URL
     
        parameters:nil
        progress:nil
        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        
        completionBlock(responseObject);
        
    }
    failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error)
    {
        NSLog(@"An error has occurred with this HTTPSession. Error is as follows: %@", error);
        
    }];
   
    
}
- (IBAction)saveFactButtonTapped:(UIButton *)sender {
    UIAlertController *factSavedAlertController = [UIAlertController alertControllerWithTitle:@"Saved"
                                                                                      message:@"New cat fact saved!"
                                                                               preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    [factSavedAlertController addAction:defaultAction];
    [self presentViewController:factSavedAlertController animated:YES completion:nil];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AFHTTPSessionManager* manager = [AFHTTPSessionManager manager];
    
    [manager GET:@"http://api.giphy.com/v1/gifs/search?q=funny+cat&api_key=dc6zaTOxFJmzC" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSArray* data = responseObject[@"data"];
        
        NSUInteger randomIndex = arc4random() % [data count];
        
        NSDictionary* randomPost = data[randomIndex];
        
        NSString* imageURL = randomPost[@"images"][@"fixed_height_still"][@"url"];
        
        C4QCatFactsDetailViewController* detailViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"CatFactDetailViewController"];
        detailViewController.catFactString = self.catFactsArray[indexPath.row];
        detailViewController.catImageURLString = imageURL;
        [self.navigationController pushViewController:detailViewController animated:YES];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
    
}



@end
