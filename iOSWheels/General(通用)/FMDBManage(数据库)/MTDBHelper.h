//
//  MTDBManager.h
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDB.h>


@class MTModel;
@interface MTDBHelper : NSObject

///获取单例对象
+ (_Nonnull instancetype)shareManager;

///关闭数据库
- (void)closeDB;


/**数据库中是否存在表.*/
- (BOOL)mt_isIfExistWithTableName:(NSString *_Nullable)tableName;





//MARK:-  创建表格
/**
 创建表(如果存在则不创建)
 @name 表名称.
 @keys 数据存放要求@[字段名称1,字段名称2].
 @uniqueKeys '唯一约束'集合.
 @complete 回调的block
 */
- (void)mt_createTableWithTableName:(NSString* _Nonnull)name
                               keys:(NSArray<MTModel*>* _Nonnull)keysModel
                   unionPrimaryKeys:(NSArray* _Nullable)unionPrimaryKeys
                         uniqueKeys:(NSArray* _Nullable)uniqueKeys
                           complete:(void(^_Nullable)(BOOL isSuccess))complete;




/**
 存储一个对象.
 @object 将要存储的对象.
 @ignoreKeys 忽略掉模型中的哪些key(即模型变量)不要存储,nil时全部存储.
 @complete 回调的block.
 */
- (void)mt_saveObject:(id _Nonnull)object
             complete:(void(^_Nullable)(BOOL isSuccess))complete;






/**
 批量插入或更新.
 */
- (void)mt_saveOrUpateArray:(NSArray* _Nonnull)array
                   complete:(void(^_Nullable)(BOOL isSuccess))complete;




//MARK:-  删除表格
/**
 删除表格
 @param tablename 表名称
 @param complete 删除结果回调
 */
- (void)mt_dropWithTableName:(NSString* _Nonnull)tablename
                    complete:(void(^_Nullable)(BOOL isSuccess))complete;





/**
 从数据库删除某个对象

 @param object 要删除的对象
 @param complete 删除结果回调
 */
- (void)mt_removeWithObject:(id _Nonnull)object
                   complete:(void(^_Nullable)(BOOL isSuccess))complete;




//MARK:-  插入数据
/**
 插入数据.
 @name 表名称.
 @dict 插入的数据,只关心key和value 即@{key:value,key:value}.
 @complete 回调的block
 */
- (void)mt_insertIntoTableName:(NSString * _Nonnull)name
                          dict:(NSDictionary* _Nonnull)dict
                      complete:(void(^_Nullable)(BOOL isSuccess))complete;




/**
 插入对象.
 @object 
 @complete 回调的block
 */
- (void)mt_insertWithObject:(id _Nonnull )object
                   complete:(void(^_Nullable)(BOOL isSuccess))complete;




//MARK:- 查询数据
/**
 直接传入条件sql语句查询.
 @name 表名称.
 @conditions 条件语句.例如:@"where name = '标哥' or name = '小马哥' and age = 26 order by age desc limit 6" 即查询name等于标哥或小马哥和age等于26的数据通过age降序输出,只查询前面6条.
 更多条件语法,请查询sql的基本使用语句.
 */
- (void)mt_queryWithTableName:(NSString* _Nonnull)name
                   conditions:(NSString* _Nullable)conditions
                     complete:(void(^_Nullable)(NSArray <NSDictionary *>* _Nullable result))complete;





- (void)mt_queryWithTableName:(NSString* _Nonnull)name
                        class:(__unsafe_unretained _Nonnull Class)cla
                   conditions:(NSString* _Nullable)conditions
                     complete:(void(^_Nullable)(NSArray<NSObject *> * _Nullable result))complete;







//MARK:- 更新数据
/**
 更新数据.
 @name 表名称.
 @dict 插入的数据,只关心key和value 即@{key:value,key:value}.
 @complete 回调的block
 */
- (void)mt_updateWithTableName:(NSString * _Nonnull)name
                          dict:(NSDictionary* _Nonnull)dict
                    conditions:(NSString* _Nullable)conditions
                      complete:(void(^_Nullable)(BOOL isSuccess))complete;














@end
