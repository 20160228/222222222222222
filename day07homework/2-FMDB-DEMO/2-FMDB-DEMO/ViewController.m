//
//  ViewController.m
//  2-FMDB-DEMO
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"
#import "Student.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DataBaseManager *manager = [DataBaseManager shareManager];
//    //增
//    Student * stu = [[Student alloc]init];
//    stu.stu_id = 13;
//    stu.stu_name = @"654364321";
//    stu.stu_age  = 12;
//    stu.stu_score = 13;
//    stu.stu_sex = 17;
//    
//    [manager insertStudent:stu];
    //查
//    Student * stu2 = [manager selectStudentByID:10];
//    NSLog(@"%ld -- %ld -- %ld -- %ld --- %@",stu2.stu_id,stu2.stu_age,stu2.stu_sex,stu2.stu_score,stu2.stu_name);
    
    //改
//    Student * stu2 = [[Student alloc]init];
//    stu2.stu_id = 10;
//    stu2.stu_name = @"2143212";
//    stu2.stu_age  = 18;
//    stu2.stu_score = 18;
//    stu2.stu_sex = 18;
//    [manager updateStudent:stu2];
    //删
//        Student * stu2 = [[Student alloc]init];
//        stu2.stu_id = 10;
//    [manager deleteStudent:stu2];
//
     NSLog(@"%@",NSHomeDirectory());
    NSArray * result = [manager selectStudentByAge:12 andLimit:2];
    for (Student * stu  in result) {
        NSLog(@"%@",stu);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
