//
//  ViewController.m
//  MyFourthApp
//
//  Created by Miwa Oshiro on 2013/10/21.
//  Copyright (c) 2013年 Miwa Oshiro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController;
@synthesize field;


#define MY_KEY @"mykey"

// 体重
#define MY_WEHGHT @"mywhight"
// 身長
#define MY_HIGHT @"myhight"


- (void)viewDidLoad
{
    [super viewDidLoad];
    

    // 体重入力フィールド
    
    field = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
    
    field.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:field];
    
    
    // 身長入力フィールド

    /*
    field = [[UITextField alloc] initWithFrame:CGRectMake(150, 20, 100, 30)];
    
    field.borderStyle = UITextBorderStyleRoundedRect;
    
    [self.view addSubview:field];
*/

    
    // UserDefaults に値があれば、セットする
    
    field.text = [[NSUserDefaults standardUserDefaults] valueForKey:MY_KEY];

    
    
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

}

- (void)store:(id)sender
{
    // UserDefaults に TextFieldの値を保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:field.text forKey:MY_KEY];

    
    int i = [userDefaults integerForKey:MY_KEY];
    NSLog(@"%d",i);
    

    BOOL successful = [userDefaults synchronize];
    if (successful){
        NSLog(@"%@", @"データの保存に成功しました。");
    }

}

- (void)delete:(id)sender
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:MY_KEY];

    BOOL successful = [defaults synchronize];
    if (successful) {
        NSLog(@"%@", @"データの削除に成功しました。");
    } else {
        NSLog(@"%@", @"削除するデータがありません。");
        return;
    }
    
    NSArray *array = [defaults arrayForKey:MY_KEY];
    NSLog(@"%d:%@", successful, array);
    if (!array) {
        NSLog(@"%@", @"データは削除されました。");
    }
}


@end
