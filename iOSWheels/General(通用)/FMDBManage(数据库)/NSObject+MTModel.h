//
//  NSObject+MTModel.h
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MTProtocol <NSObject>

@optional


/**
 自定义 “联合主键” 函数, 如果需要自定义 “联合主键”,则在类中自己实现该函数.
 @return 返回值是 “联合主键” 的字段名(即相对应的变量名).
 注：当“联合主键”和“唯一约束”同时定义时，“联合主键”优先级大于“唯一约束”.
 */
+ (NSArray* _Nonnull)mt_unionPrimaryKeys;


/**
 自定义 “唯一约束” 函数,如果需要 “唯一约束”字段,则在类中自己实现该函数.
 @return 返回值是 “唯一约束” 的字段名(即相对应的变量名).
 */
+ (NSArray* _Nonnull)mt_uniqueKeys;


/**
 @return 返回不需要存储的属性.
 */
+ (NSArray* _Nonnull)mt_ignoreKeys;


/**
 *  数组中需要转换的模型类(‘字典转模型’ 或 ’模型转字典‘ 都需要实现该函数)
 *  @return 字典中的key是数组属性名，value是数组中存放模型的Class
 */
+ (NSDictionary *_Nonnull)mt_objectClassInArray;


/**
 如果模型中有自定义类变量,则实现该函数对应进行集合到模型的转换.
 字典转模型用.
 */
+ (NSDictionary *_Nonnull)mt_objectClassForCustom;


/**
 将模型中对应的自定义类变量转换为字典.
 模型转字典用.
 */
+ (NSDictionary *_Nonnull)mt_dictForCustomClass;


/**
 替换变量的功能(及当字典的key和属性名不一样时，进行映射对应起来)
 */
+ (NSDictionary *_Nonnull)mt_replacedKeyFromPropertyName;

@end


@interface NSObject (MTMode)<MTProtocol>

//MARK:- 关联对象
///自定义表名 （如果不设置 默认为类名）
@property (nonatomic, copy) NSString * _Nonnull mt_tableName;
/// 本库自带的自动增长主键.
@property(nonatomic, strong) NSNumber * _Nonnull mt_id;
///为了方便开发者，特此加入以下两个字段属性供开发者做参考.(自动记录数据的存入时间和更新时间)
@property(nonatomic, copy) NSString * _Nonnull mt_createTime;//数据创建时间(即存入数据库的时间)
@property(nonatomic, copy) NSString * _Nonnull mt_updateTime;//数据最后那次更新的时间.



/**
 @tablename 此参数为nil时，判断以当前类名为表名的表是否存在; 此参数非nil时,判断以当前参数为表名的表是否存在.
 */
+ (BOOL)mt_isExistForTableName:(NSString* _Nullable)tablename;


#pragma mark ---- 保存数据 ---

/**
 同步存储.
 当表存在时 直接保存数据。 当表不存在时，先建表再保存数据
 提示：当“唯一约束”数据已经存在时  存储失败
 */
- (BOOL)mt_save;
///异步存储
- (void)mt_saveAsync:(void(^_Nullable)(BOOL isSuccess))complete;



/**
 同步存储或更新.
 当"唯一约束"或"主键"存在时，此接口会更新旧数据,没有则存储新数据.
 提示：“唯一约束”优先级高于"主键".
 */
- (BOOL)mt_saveOrUpdate;
///异步存储更新
- (void)mt_saveOrUpdateAsync:(void(^_Nullable)(BOOL isSuccess))complete;




/**
 同步 存储或更新 数组元素.
 @array 存放对象的数组.(数组中存放的是同一种类型的数据)
 当"唯一约束"或"主键"存在时，此接口会更新旧数据,没有则存储新数据.
 提示：“唯一约束”优先级高于"主键".
 */
+ (BOOL)mt_saveOrUpdateArray:(NSArray* _Nonnull)array;
/// 异步 存储或更新数组元素
+ (void)mt_saveOrUpdateArrayAsync:(NSArray* _Nonnull)array complete:(void(^_Nullable)(BOOL isSuccess))complete;




#pragma mark --- 查找数据
/**
 同步查询所有结果.   返回对象数组  conditions = nil  表示查询所有数据
 @conditions 条件语句.例如:@"where name = '标哥' or name = '小马哥' and age = 26 order by age desc limit 6" 即查询name等于标哥或小马哥和age等于26的数据通过age降序输出,只查询前面6条.
 */
+ (NSArray *_Nonnull)mt_queryWithConditions:(NSString* _Nullable)conditions;
///异步查询所有数据， 返回对象数组
+ (void)mt_queryWithConditionsAsync:(NSString* _Nullable)conditions
                           complete:(void(^_Nullable)(BOOL isSuccess))complete;











#pragma mark --- 更新数据








#pragma mark --- 删除数据



@end
