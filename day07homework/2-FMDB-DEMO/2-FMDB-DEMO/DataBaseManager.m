//
//  DataBaseManager.m
//  2-FMDB-DEMO
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"
//可以防止相互引用
#import "Student.h"
@interface DataBaseManager ()
//数据库
@property (nonatomic, strong)FMDatabase *dbBase;
//数据库地址
@property (nonatomic, copy)NSString *dbPath;
@end

@implementation DataBaseManager
+(instancetype)shareManager {
//    非线程安全的
//    static DataBaseManager *manager = nil;
//    if (manager == nil) {
//        manager = [[DataBaseManager alloc]init];
//        
//    }
//    return manager;
    
    static DataBaseManager *manager = nil;
//    dispatch_once_t   只执行一次
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSLog(@"只执行一次");
        manager = [[DataBaseManager alloc]init];
        
    });
    return manager;
}
-(instancetype)init {

    if (self = [super init]) {
//        初始化数据库
//        dbPath
//        沙盒地址
        NSString *libraryPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
//        数据库地址
        _dbPath = [libraryPath stringByAppendingPathComponent:@"my.sqlite"];
        _dbBase = [FMDatabase databaseWithPath:_dbPath];
        
//        如果数据库打了 就去创建表
        if ([_dbBase open]) {
            NSString *sql = @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL ,s_age INTERGER ,s_name TEXT ,s_sex INTERGER, s_score INTERGER)";
            if ([_dbBase executeUpdate:sql]) {
                NSLog(@"创建表成功");
               
            }else {
                NSLog(@"创建表失败");
            }
        }
    }
    return self;
}

/**
 插入数据
 */
-(void)insertStudent:(Student*)stu {
//    @"CREATE TABLE IF NOT EXISTS T_Student(s_id INTERGER PRIMARY KEY NOT NULL ,s_age INTERGER ,s_name TEXT ,s_sex INTERGER, s_score INTERGER)";

    NSString *sql = @"INSERT INTO T_Student(s_id,s_age,s_name,s_sex,s_score) VALUES (?,?,?,?,?)";
    
    NSString * stu_id = [NSString stringWithFormat:@"%ld",stu.stu_id];
    NSString * stu_age = [NSString stringWithFormat:@"%ld",stu.stu_age];
    NSString * stu_sex = [NSString stringWithFormat:@"%ld",stu.stu_sex];
    NSString * stu_score = [NSString stringWithFormat:@"%ld",stu.stu_score];
    if([_dbBase executeUpdate:sql,stu_id,stu_age,stu.stu_name, stu_sex,stu_score])
    {
        NSLog(@"插入数据成功");
    }else {
        NSLog(@"插入数据失败");
    }


}
/**
 修改数据
 */
-(void)updateStudent:(Student*)stu{
    NSString * stu_id = [NSString stringWithFormat:@"%ld",stu.stu_id];
    NSString * stu_age = [NSString stringWithFormat:@"%ld",stu.stu_age];
    NSString * stu_sex = [NSString stringWithFormat:@"%ld",stu.stu_sex];
    NSString * stu_score = [NSString stringWithFormat:@"%ld",stu.stu_score];
    NSString *sql = @"UPDATE T_Student SET s_age = ?,s_name = ?,s_sex = ?,s_score = ?";
    if([_dbBase executeUpdate:sql,stu_id,stu_age ,stu.stu_name,stu_sex,stu_score])
    {
        NSLog(@"修改数据成功");
    }else {
        NSLog(@"修数据失败");
    }


}
/**
 删除数据
 */
-(void)deleteStudent:(Student*)stu {
    NSString *sql = @"DELETE FROM T_Student WHERE s_id = ?";
    NSString * stu_id = [NSString stringWithFormat:@"%ld",stu.stu_id];
    BOOL res = [_dbBase executeUpdate:sql,stu_id];
    if (res) {
        NSLog(@"删除成功");
    }else {
        NSLog(@"删除失败");
        
    }
}
/**
 查询数据
 */
-(Student*)selectStudentByID:(NSInteger)stuID{
    
    NSString *sql = @"SELECT * FROM T_Student WHERE s_id = ?";
    NSString * stu_id = [NSString stringWithFormat:@"%ld",stuID];
    FMResultSet *resultSet =  [_dbBase executeQuery:sql,stu_id];
    
    Student * stu = [[Student alloc]init];
    while ([resultSet next]) {
        stu.stu_id =  [resultSet intForColumn:@"s_id"];
        stu.stu_name = [resultSet stringForColumn:@"s_name"];
        stu.stu_age = [resultSet intForColumn:@"s_age"];
        stu.stu_sex =  [resultSet intForColumn:@"s_sex"];
        stu.stu_score = [resultSet intForColumn:@"s_score"];
    }
    return stu;
}
/**
 查询数据   按照年龄
 */
-(NSArray*)selectStudentByAge:(NSInteger)stuAge
{
    NSString *sql = @"SELECT * FROM T_Student WHERE s_age = ?";
    NSString * stu_Age = [NSString stringWithFormat:@"%ld",stuAge];
    FMResultSet *resultSet =  [_dbBase executeQuery:sql,stu_Age];
    NSMutableArray * result = [NSMutableArray array];
   
    while ([resultSet next]) {
        Student * stu = [[Student alloc]init];
        stu.stu_id =  [resultSet intForColumn:@"s_id"];
        stu.stu_name = [resultSet stringForColumn:@"s_name"];
        stu.stu_age = [resultSet intForColumn:@"s_age"];
        stu.stu_sex =  [resultSet intForColumn:@"s_sex"];
        stu.stu_score = [resultSet intForColumn:@"s_score"];
        [result addObject:stu];
    }
    return result;
}
/**
 查询数据   按照年龄 和 多少条数据
 */
-(NSArray*)selectStudentByAge:(NSInteger)stuAge andLimit:(NSInteger)limit {

    NSString *sql = @"SELECT * FROM T_Student WHERE s_age = ? LIMIT ?";
    NSString * stu_Age = [NSString stringWithFormat:@"%ld",stuAge];
    NSString * stu_Num = [NSString stringWithFormat:@"%ld",limit];
    FMResultSet *resultSet =  [_dbBase executeQuery:sql,stu_Age,stu_Num];
    
    
    NSMutableArray * result = [NSMutableArray array];
    
    while ([resultSet next]) {
        Student * stu = [[Student alloc]init];
        stu.stu_id =  [resultSet intForColumn:@"s_id"];
        stu.stu_name = [resultSet stringForColumn:@"s_name"];
        stu.stu_age = [resultSet intForColumn:@"s_age"];
        stu.stu_sex =  [resultSet intForColumn:@"s_sex"];
        stu.stu_score = [resultSet intForColumn:@"s_score"];
        [result addObject:stu];
    }
    return result;


}
@end
