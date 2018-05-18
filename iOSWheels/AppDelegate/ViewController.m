//
//  ViewController.m
//  iOSWheels
//
//  Created by 方新俊 on 2018/3/29.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "ViewController.h"
#import "TestViewController.h"

#import "Student.h"
#import "MTDBUtils.h"
#import "MTDBHelper.h"
#import "NSObject+MTModel.h"
#import "NSObject+MTExtension.h"

@interface ViewController ()

- (IBAction)ClickEvent:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
//    [MTNetworkHelper GET:@"http.baidu.com" parameters:nil responseCache:nil success:nil failure:nil];
//    [MTNetworkHelper GET:@"http.baidu.com" parameters:nil responseCache:nil success:nil failure:nil];


    [[MTDBHelper shareManager] mt_dropWithTableName:@"Student" complete:nil];
//    [[MTDBHelper shareManager] mt_dropWithTableName:@"student" complete:nil];

    
//    NSArray *keys = [MTDBUtils getClassIvarList:[Student class] onlyKey:NO];
//    [[MTDBHelper shareManager] mt_createTableWithTableName:@"student" keys:keys unionPrimaryKeys:@[] uniqueKeys:@[@"dataString",@"address"] complete:nil];
//    [[MTDBHelper shareManager] mt_insertIntoTableName:@"student" dict:@{@"sex":@(1),@"address":@"背景",@"hhhh":@(3.557)} complete:nil];
//    [[MTDBHelper shareManager] mt_insertIntoTableName:@"student" dict:@{@"sex":@(1),@"address":@"hello world"} complete:nil];
    
    
    Student *stu = [[Student alloc] init];
    stu.mt_id = @(8);
    stu.sex = 1;
    stu.address = @"北京市 上海";
    stu.name = @"hh";
    stu.contentID = @"1258";
//    [stu mt_save];
    
    
    Student *stu2 = [[Student alloc] init];
    stu.mt_id = @(11);
    stu2.sex = 1;
    stu2.address = @"深圳";
    stu2.name = @"dav";
    stu2.contentID = @"1259";
    stu2.user_id = 1008;
//    [stu2 mt_save];
    

//    stu2.name = @"mmmmmmm";
//    [stu2 mt_saveOrUpdate];
    
    [Student mt_saveOrUpdateArray:@[stu,stu2,stu2]];
    
//    [Student mt_saveOrUpdateArrayAsync:@[stu,stu2,stu2] complete:^(BOOL isSuccess) {
//
//    }];


    
    
//    __block NSArray *resultM = nil;
//    [[MTDBHelper shareManager] mt_queryWithTableName:@"Student" class:[Student class] conditions:nil complete:^(NSArray * _Nullable result) {
//        resultM = result;
//    }];
//
//    NSLog(@"resultM == %@",resultM);

//    NSArray *resultM = [Student mt_queryWithConditions:nil];
//
//    for (Student *stu in resultM) {
//        NSLog(@"^^^^ === %@",stu.name);
//    }
    
    
    
    [[MTDBHelper shareManager] mt_updateWithTableName:@"Student" dict:@{@"address":@"12345678",@"name":@"fangxinjunjun"} conditions:nil complete:nil];
    
    
    __block NSArray *resultM = nil;
    [[MTDBHelper shareManager] mt_queryWithTableName:@"Student" conditions:@"where sex = 1" complete:^(NSArray<NSDictionary *> *result) {
        resultM = result;
    }];
    
    NSLog(@"resultM == %@",resultM);
    
    
    
    
    
    
    NSLog(@"%@",[NSObject mt_superClassName]);
    
    
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}







- (IBAction)ClickEvent:(id)sender {
    TestViewController *testVC = [[TestViewController alloc] init];
    [self.navigationController pushViewController:testVC animated:YES];
}
@end
