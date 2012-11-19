//
//  ViewController.m
//  JsonTutorial
//
//  Created by MAC on 11/18/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableData *webData;
    NSURLConnection *connection;
    NSMutableArray *array;

}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [[self myTableView]setDelegate:self];
    [[self myTableView]setDataSource:self];
    array = [[NSMutableArray alloc]init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [webData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Fail with error");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *allDataDictionary = [NSJSONSerialization JSONObjectWithData:webData options:0 error:nil];
    NSDictionary *feed = [allDataDictionary objectForKey:@"feed"];
    
    NSArray *arrayOfEntry = [feed objectForKey:@"entry"];
    
    for (NSDictionary *dictionary in arrayOfEntry) {
        NSDictionary *title = [dictionary objectForKey:@"title"];
        NSString *label = [title objectForKey:@"label"];
        
        [array addObject:label];
    }
    [[self myTableView]reloadData];
}

- (IBAction)getTop10AlbumButton:(id)sender {
    [array removeAllObjects];
    
    NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/us/rss/topalbums/limit=10/json"];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    connection = [NSURLConnection connectionWithRequest:request delegate:self];
    
    if(connection){
        webData = [[NSMutableData alloc]init];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [array objectAtIndex:indexPath.row];
    return cell;
}

@end
