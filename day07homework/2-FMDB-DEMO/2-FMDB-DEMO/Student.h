//
//  Student.h
//  2-FMDB-DEMO
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student : NSObject


//  NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL ,s_age INTERGER ,s_name TEXT ,s_sex INTERGER, s_score INTERGER)";
@property(nonatomic,assign)NSInteger stu_id;
@property(nonatomic,assign)NSInteger stu_age;
@property(nonatomic,assign)NSString *  stu_name;
@property(nonatomic,assign)NSInteger stu_sex;
@property(nonatomic,assign)NSInteger stu_score;


@end
