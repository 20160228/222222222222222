//
//  DataBaseManager.h
//  2-FMDB-DEMO
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import <Foundation/Foundation.h>
//把Student当做一个类
@class Student;
/**
 数据库管理类
 */
@interface DataBaseManager : NSObject

/**
 获得数据库单例
 */
+(instancetype)shareManager;
/**
 插入数据
 */
-(void)insertStudent:(Student*)stu;
/**
 修改数据
 */
-(void)updateStudent:(Student*)stu;
/**
 删除数据
 */
-(void)deleteStudent:(Student*)stu;
/**
 查询数据
 */
-(Student*)selectStudentByID:(NSInteger)stuID;
/**
 查询数据   按照年龄
 */
-(NSArray*)selectStudentByAge:(NSInteger)stuAge;
/**
 查询数据   按照年龄 和 多少条数据
 */
-(NSArray*)selectStudentByAge:(NSInteger)stuAge andLimit:(NSInteger)limit;
@end
