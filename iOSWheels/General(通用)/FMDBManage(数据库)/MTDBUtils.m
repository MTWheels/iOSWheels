//
//  MTDBTool.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTDBUtils.h"
#import "NSCache+MTCache.h"
#import "MTFoundation.h"



@implementation MTDBUtils

/**
 判断类是否实现了某个类方法.
 */
+ (id)executeSelector:(SEL)selector forClass:(Class)cla{
    id obj = nil;
    if([cla respondsToSelector:selector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        obj = [cla performSelector:selector];
#pragma clang diagnostic pop
    }
    return obj;
}
/**
 判断对象是否实现了某个方法.
 */
+ (id)executeSelector:(SEL)selector forObject:(id)object{
    id obj = nil;
    if([object respondsToSelector:selector]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        obj = [object performSelector:selector];
#pragma clang diagnostic pop
    }
    return obj;
}




/**
 根据类获取变量名列表
 @onlyKey YES:紧紧返回key,NO:在key后面添加type.
 */
+ (NSArray<MTModel *>* _Nonnull)getClassIvarList:(__unsafe_unretained _Nonnull Class)cla
                              onlyKey:(BOOL)onlyKey {
    //获取缓存的属性信息
    NSCache *cache = [NSCache mt_cache];
    NSString* cacheKey = onlyKey ? [NSString stringWithFormat:@"%@_IvarList_yes",NSStringFromClass(cla)]:[NSString stringWithFormat:@"%@_IvarList_no",NSStringFromClass(cla)];
    NSArray* cachekeys = [cache objectForKey:cacheKey];
    if(cachekeys){ return cachekeys; }
    
    NSMutableArray* keysM = [NSMutableArray array];
    
    MTModel *primaryKeyM = [[MTModel alloc] init];
    primaryKeyM.key = mt_primaryKey;
    primaryKeyM.objcType = @"NSInteger";
    primaryKeyM.sqlType = SqlInteger;
    [keysM addObject:primaryKeyM];
    
    MTModel *createTimeM = [[MTModel alloc] init];
    createTimeM.key = mt_createTimeKey;
    createTimeM.objcType = @"NSString";
    createTimeM.sqlType = SqlText;
    [keysM addObject:createTimeM];

    MTModel *updateTimeM = [[MTModel alloc] init];
    updateTimeM.key = mt_updateTimeKey;
    updateTimeM.objcType = @"NSString";
    updateTimeM.sqlType = SqlText;
    [keysM addObject:updateTimeM];
    
  
    
    [self mt_enumerateClasses:cla complete:^(__unsafe_unretained Class c, BOOL *stop) {
        unsigned int numIvars; //成员变量个数
        Ivar *vars = class_copyIvarList(c, &numIvars);
        
        for(int i = 0; i < numIvars; i++) {
            Ivar thisIvar = vars[i];
            NSString* key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];//获取成员变量的名
            if ([key hasPrefix:@"_"]) {
                key = [key substringFromIndex:1];
            }
            MTModel *model = [[MTModel alloc] init];
            model.key = key;
            
            if (!onlyKey) {
                //获取成员变量的数据类型
                NSString* type = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];
                model.objcType = type;
            }
            model.sqlType = [self sqlTypeFromObjcType:model.objcType];
            [keysM addObject:model];//存储对象的变量名
        }
        free(vars);//释放资源
    }];
    
    [cache setObject:keysM forKey:cacheKey];
    
    return keysM;
    
}




+ (void)mt_enumerateClasses:(__unsafe_unretained Class)srcCla complete:(MTClassesEnumeration)enumeration
{
    // 1.没有block就直接返回
    if (enumeration == nil) return;
    // 2.停止遍历的标记
    BOOL stop = NO;
    // 3.当前正在遍历的类
    Class c = srcCla;
    // 4.开始遍历每一个类
    while (c && !stop) {
        // 4.1.执行操作
        enumeration(c, &stop);
        // 4.2.获得父类
        c = class_getSuperclass(c);
        if ([MTFoundation isClassFromFoundation:c]) break;
    }
}





/**
 根据类属性类型返回数据库存储类型.
 */
+ (NSString *)sqlTypeFromObjcType:(NSString* _Nonnull)type {
    
    if([type isEqualToString:@"i"]||
       [type isEqualToString:@"I"]||
       [type isEqualToString:@"s"]||
       [type isEqualToString:@"S"]||
       [type isEqualToString:@"q"]||
       [type isEqualToString:@"Q"]||
       [type isEqualToString:@"b"]||
       [type isEqualToString:@"B"]||
       [type isEqualToString:@"c"]||
       [type isEqualToString:@"C"]|
       [type isEqualToString:@"l"]||
       [type isEqualToString:@"L"]) {
        return SqlInteger;
    } else if ([type isEqualToString:@"f"]||
               [type isEqualToString:@"F"]||
             [type isEqualToString:@"d"]||
               [type isEqualToString:@"D"]){
        return SqlReal;
    } else {
        return SqlText;
    }
}




/**
 判断并获取字段类型
 */
+ (NSString *)keyAndType:(MTModel *)model {
    //设置列名(MT_ + 属性名),加MT_是为了防止和数据库关键字发生冲突.
    return [NSString stringWithFormat:@"%@ %@",model.key,model.sqlType];
}



/**
 根据传入的对象获取表名.
 */
+ (NSString* _Nonnull)getTableNameWithObject:(id _Nonnull)object {
    NSString* tablename = [object valueForKey:mt_tableNameKey];
    if(tablename == nil) {
        tablename = NSStringFromClass([object class]);
    }
    return tablename;
}



/**
 过滤建表的key.
 */
+ (NSArray<MTModel *>*)mt_filtCreateKeys:(NSArray<MTModel *>*)mt_createkeys
                             ignoredkeys:(NSArray<NSString *>*)mt_ignoredkeys {
    
    NSMutableArray* createKeys = [NSMutableArray arrayWithArray:mt_createkeys];
    NSMutableArray* ignoredKeys = [NSMutableArray arrayWithArray:mt_ignoredkeys];
    //判断是否有需要忽略的key集合.
    if (ignoredKeys.count){
        for(__block int i = 0; i < createKeys.count;i++){
            if(ignoredKeys.count){
                MTModel *createM = createKeys[i];
                [ignoredKeys enumerateObjectsUsingBlock:^(id  _Nonnull ignoreKey, NSUInteger idx, BOOL * _Nonnull stop) {
                    if([createM.key isEqualToString:ignoreKey]){
                        [createKeys removeObjectAtIndex:i];
                        [ignoredKeys removeObjectAtIndex:idx];
                        i--;
                        *stop = YES;
                    }
                }];
            }else{
                break;
            }
        }
    }
    return createKeys;
}





/**
 根据对象获取要更新或插入的字典. 过滤建表的key
 */
+ (NSDictionary* _Nonnull)getDictWithObject:(id _Nonnull)object{
    //忽略key
    NSArray *ignoredKeys = [MTDBUtils executeSelector:mt_ignoreKeysSelector forClass:[object class]];
    //获取
    NSArray *keyValues = [[self class] getClassIvarList:[object class] onlyKey:YES];
    
    NSMutableDictionary* valueDict = [NSMutableDictionary dictionary];

    if (ignoredKeys) {
        for (MTModel *model in keyValues) {
            if (![ignoredKeys containsObject:model.key]) {
                valueDict[model.key] = [object valueForKeyPath:model.key];
            }
        }
    } else {
        for (MTModel *model in keyValues) {
            valueDict[model.key] = [object valueForKeyPath:model.key];

        }
    }
    
    return valueDict;
}





/**
 根据对象获取要更新或插入的字典数组. 过滤建表的key
 */
+ (NSArray<NSDictionary*> *)getDictArray:(NSArray *)array {
    NSMutableArray* dictArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary* dict = [MTDBUtils getDictWithObject:object];
        [dictArray addObject:dict];
    }];
    return dictArray;
}



@end





@implementation MTModel

@end
