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
    
    
    // save button
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [btn setTitle:@"SAVE" forState:UIControlStateNormal];
    
    btn.frame = CGRectMake(10, 50, 100, 30);
    
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(store:) forControlEvents:UIControlEventTouchUpInside];
    

    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];

    [button setTitle:@"DELETE" forState:UIControlStateNormal];
    
    button.frame = CGRectMake(70, 50, 100, 30);

    [self.view addSubview:button];

    [button addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];


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
    
    

    if ([fileManager fileExistsAtPath:[dir stringByAppendingPathComponent:@"file.db"]])
    {

    FMDatabase *db= [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"file.db"]];
    
    NSString *ins = @"insert into test (testname) values (1);";
    
    [db open]; //DB開く
    [db executeUpdate:ins];
    
    NSLog(@"Error %@ - %d", [db lastErrorMessage], [db lastErrorCode]);
    
    [db close];
    }
    

}



- (void)store:(id)sender
{
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:self.weight.text forKey:@"my_weight"];
    [userDefaults setValue:self.hight.text forKey:@"my_hight"];
    
    int i = [userDefaults integerForKey:@"my_weight"];
    NSLog(@"体重は%d",i);
    
    int s = [userDefaults integerForKey:@"my_hight"];
    NSLog(@"身長は%d",s);
    

    
    

    

    BOOL successful = [userDefaults synchronize];
    if (successful){
        NSLog(@"%@", @"データの保存に成功しました。");
    }

}

- (void)delete:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:@"my_weight"];
    [defaults removeObjectForKey:@"my_hight"];
    
    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"%@", @"データの削除に成功しました。");
    } else {
        NSLog(@"%@", @"削除するデータがありません。");
        return;
    }
    
    NSArray *array = [defaults arrayForKey:@"my_weight"];
    NSLog(@"%d:%@", successful, array);
    if (!array) {
        NSLog(@"%@", @"データは削除されました。");
    }
}


@end
