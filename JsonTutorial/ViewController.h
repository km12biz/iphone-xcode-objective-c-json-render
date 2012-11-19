//
//  ViewController.h
//  JsonTutorial
//
//  Created by MAC on 11/18/12.
//  Copyright (c) 2012 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

@property (weak, nonatomic) IBOutlet UITableView *myTableView;
- (IBAction)getTop10AlbumButton:(id)sender;

@end
