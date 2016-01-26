//
//  Student.m
//  2-FMDB-DEMO
//
//  Created by qianfeng1 on 16/1/26.
//  Copyright © 2016年 陶星宇. All rights reserved.
//

#import "Student.h"

@implementation Student


- (NSString *)description {

    return [NSString stringWithFormat:@"%ld -- %ld -- %ld -- %ld --- %@",self.stu_id,self.stu_age,self.stu_sex,self.stu_score,self.stu_name];
}
@end
