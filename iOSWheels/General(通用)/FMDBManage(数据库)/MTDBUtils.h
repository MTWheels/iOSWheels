//
//  MTDBTool.h
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>


#define mt_tableNameKey @"mt_tableName"  //关联表名

#define mt_uniqueKeysSelector NSSelectorFromString(@"mt_uniqueKeys")
#define mt_ignoreKeysSelector NSSelectorFromString(@"mt_ignoreKeys")
#define mt_unionPrimaryKeysSelector NSSelectorFromString(@"mt_unionPrimaryKeys")

#define mt_primaryKey @"mt_id"
#define mt_createTimeKey @"mt_createTime"
#define mt_updateTimeKey @"mt_updateTime"


#define SqlText @"text" //数据库的字符类型
#define SqlReal @"real" //数据库的浮点类型
#define SqlInteger @"integer" //数据库的整数类型
//#define SqlBlob @"blob" //数据库的二进制类型


typedef void (^MTClassesEnumeration)(Class _Nullable c, BOOL * _Nonnull stop);


@class MTModel;
@interface MTDBUtils : NSObject


/**
 判断并执行类方法.
 */
+ (id _Nonnull)executeSelector:(SEL _Nonnull)selector forClass:(__unsafe_unretained _Nonnull Class)cla;

/**
 判断并执行对象方法.
 */
+ (id _Nonnull)executeSelector:(SEL _Nonnull)selector forObject:(id _Nonnull)object;


/**
 根据类获取变量名列表  为了创建表格时 提取关键字
 @onlyKey YES:紧紧返回key,NO:在key后面添加type.
 */
+ (NSArray<MTModel *>* _Nonnull)getClassIvarList:(__unsafe_unretained _Nonnull Class)cla
                                         onlyKey:(BOOL)onlyKey;


/**
 根据类属性类型返回数据库存储类型.
 */
+ (NSString *_Nonnull)sqlTypeFromObjcType:(NSString* _Nonnull)type;


/**
 判断并获取字段类型
 */
+ (NSString *_Nullable)keyAndType:(MTModel *_Nonnull)model;



/**
 根据传入的对象获取表名.
 */
+ (NSString* _Nonnull)getTableNameWithObject:(id _Nonnull)object;


/**
 过滤建表的key.
 */
+ (NSArray<MTModel *>*_Nullable)mt_filtCreateKeys:(NSArray<MTModel *>*_Nonnull)mt_createkeys
                                      ignoredkeys:(NSArray<NSString *>*_Nonnull)mt_ignoredkeys;




/**
 根据对象获取要更新或插入的字典. 过滤建表的key
 */
+ (NSDictionary* _Nonnull)getDictWithObject:(id _Nonnull)object;




/**
 根据对象获取要更新或插入的字典数组. 过滤建表的key
 */
+ (NSArray<NSDictionary*> *)getDictArray:(NSArray *)array;


@end





@interface MTModel : NSObject

/*key*/
@property (nonatomic, copy) NSString * _Nullable key;
/*objc type*/
@property (nonatomic, copy) NSString * _Nullable objcType;
/*sql type*/
@property (nonatomic, copy) NSString * _Nonnull sqlType;

@end
