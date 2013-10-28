//
//  ViewController.m
//  MyFourthApp
//
//  Created by Miwa Oshiro on 2013/10/21.
//  Copyright (c) 2013年 Miwa Oshiro. All rights reserved.
//

#import "ViewController.h"
#import "FMDatabase.h"

@interface ViewController ()

@end

@implementation ViewController;
@synthesize weight;


sqlite3* db;




- (void)viewDidLoad
{
    [super viewDidLoad];

    weight.delegate = self;

    //DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"weight.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"weight.db"]];

        NSString *sql = @"CREATE TABLE weight (id INTEGER PRIMARY KEY AUTOINCREMENT,weight TEXT,date TEXT);";
        
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行
        [db close];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


- (IBAction)savebutton:(id)sender {
    
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.weight.text forKey:@"my_weight"];
    
    
    float weight_f = [userDefaults floatForKey:@"my_weight"];
    NSNumber *weight_num = [NSNumber numberWithFloat:weight_f];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"weight.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"weight.db"]];
        
        [db open]; //DB開く
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        df.dateFormat  = @"yyyy-MM-dd";
        NSString *strDate = [df stringFromDate:[NSDate date]];
        
        [db executeUpdate:@"insert into weight (weight,date) values (?,?);",weight_num,strDate];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    
    BOOL successful = [userDefaults synchronize];
    if (successful){
        NSLog(@"%@", @"データの保存に成功しました。");
    }
    
    
}
@end
