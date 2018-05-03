//
//  NSObject+MTModel.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "NSObject+MTModel.h"
#import <objc/message.h>
#import "MTDBUtils.h"
#import "MTDBHelper.h"


@implementation NSObject (MTMode)

#pragma mark --- 关联对象
- (NSString *)mt_tableName {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMt_tableName:(NSString *)mt_tableName {
    objc_setAssociatedObject(self, @selector(mt_tableName), mt_tableName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSNumber *)mt_id {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMt_id:(NSNumber *)mt_id {
    objc_setAssociatedObject(self, @selector(mt_id), mt_id, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)mt_createTime {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMt_createTime:(NSString *)mt_createTime {
    objc_setAssociatedObject(self, @selector(mt_createTime), mt_createTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


- (NSString *)mt_updateTime {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setMt_updateTime:(NSString *)mt_updateTime {
    objc_setAssociatedObject(self, @selector(mt_updateTime), mt_updateTime, OBJC_ASSOCIATION_COPY_NONATOMIC);
}




/**
 @tablename 此参数为nil时，判断以当前类名为表名的表是否存在; 此参数非nil时,判断以当前参数为表名的表是否存在.
 */
+ (BOOL)mt_isExistForTableName:(NSString* _Nullable)tablename {
    if (!tablename)  tablename = NSStringFromClass([self class]);
    
    BOOL result = [[MTDBHelper shareManager] mt_isIfExistWithTableName:tablename];
    
    [[MTDBHelper shareManager] closeDB];
    
    return result;
}


#pragma mark --- 保存数据


///同步存储
- (BOOL)mt_save {
    __block BOOL result;
    [[MTDBHelper shareManager] mt_saveObject:self complete:^(BOOL isSuccess) {
        result = isSuccess;
    }];
    //关闭数据库
    [[MTDBHelper shareManager] closeDB];
    return result;
    
}

///异步存储
- (void)mt_saveAsync:(void(^_Nullable)(BOOL isSuccess))complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        BOOL result = [self mt_save];
        !complete ?: complete(result);
    });
}




/**
 同步存储或更新.
 */
- (BOOL)mt_saveOrUpdate {
    return [[self class] mt_saveOrUpdateArray:@[self]];
}

///异步存储更新
- (void)mt_saveOrUpdateAsync:(void(^_Nullable)(BOOL isSuccess))complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        BOOL result = [self mt_saveOrUpdate];
        !complete ?: complete(result);
    });
}




/**
 同步 存储或更新 数组元素.
 */
+ (BOOL)mt_saveOrUpdateArray:(NSArray* _Nonnull)array {
    NSAssert(array && array.count,@"数组没有元素!");
    __block BOOL result;
    [[MTDBHelper shareManager] mt_saveOrUpateArray:array complete:^(BOOL isSuccess) {
        result = isSuccess;
    }];
    //关闭数据库
    [[MTDBHelper shareManager] closeDB];
    return result;
}


/// 异步 存储或更新数组元素
+ (void)mt_saveOrUpdateArrayAsync:(NSArray* _Nonnull)array complete:(void(^_Nullable)(BOOL isSuccess))complete {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        BOOL result = [self mt_saveOrUpdateArray:array];
        !complete ?: complete(result);
    });
}






#pragma mark --- 查找数据
/**
 同步查询所有结果.   返回对象数组
 温馨提示: 当数据量巨大时,请用范围接口进行分页查询,避免查询出来的数据量过大导致程序崩溃.
 */
+ (NSArray *)mt_queryWithConditions:(NSString* _Nullable)conditions {
    NSString *tableName = [MTDBUtils getTableNameWithObject:self];
    __block NSArray* results;
    [[MTDBHelper shareManager] mt_queryWithTableName:tableName class:[self class] conditions:conditions complete:^(NSArray<NSObject *> * _Nullable result) {
        results = result;
    }];
    //关闭数据库
    [[MTDBHelper shareManager] closeDB];
    return results;
}

///异步查询所有数据， 返回对象数组
+ (void)mt_queryWithConditionsAsync:(NSString* _Nullable)conditions
                           complete:(void(^_Nullable)(BOOL isSuccess))complete {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
        NSArray* array = [self mt_queryWithConditions:conditions];
        !complete ?: complete(array);
    });
    
}


@end
