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
@synthesize field;


sqlite3* db;




- (void)viewDidLoad
{
    [super viewDidLoad];

    //DBファイルのパス
    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString *dir   = [paths objectAtIndex:0];
    //DBファイルがあるかどうか確認
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        //なければ新規作成
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];

        NSString *sql = @"CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT,testname TEXT);";
        
        [db open]; //DB開く
        [db executeUpdate:sql]; //SQL実行

        
        [db close];
        
    }
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
    
    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {
        FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
        
        [db open]; //DB開く
        
        [db executeUpdate:@"insert into test (testname) values (?);",weight_num];
        
        NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
        [db close];
    }
    
    BOOL successful = [userDefaults synchronize];
    if (successful){
        NSLog(@"%@", @"データの保存に成功しました。");
    }
    
    
}
@end
