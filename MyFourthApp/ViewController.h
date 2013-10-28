//
//  ViewController.h
//  MyFourthApp
//
//  Created by Miwa Oshiro on 2013/10/21.
//  Copyright (c) 2013年 Miwa Oshiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "FMDatabase.h"

@interface ViewController : UIViewController


@property (nonatomic, strong) UITextField *field;

@property (strong, nonatomic) IBOutlet UITextField *weight;

- (IBAction)savebutton:(id)sender;

@end
