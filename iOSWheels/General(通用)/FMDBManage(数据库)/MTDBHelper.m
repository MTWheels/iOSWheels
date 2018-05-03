//
//  MTDBManager.m
//  iOSWheels
//
//  Created by liyan on 2018/4/8.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "MTDBHelper.h"
#import "NSString+MTFileManager.h"
#import "MTDBUtils.h"
#import <MJExtension/MJExtension.h>

/**默认数据库名称*/
#define SQLITE_NAME @"MTFMDB.db"

@interface MTDBHelper()

///信号量线程锁
@property (nonatomic, strong) dispatch_semaphore_t semaphore;
///数据库队列
@property (nonatomic, strong) FMDatabaseQueue *queue;
///数据库对象
@property (nonatomic, strong) FMDatabase *db;
///是否
@property (nonatomic, assign) BOOL inTransaction;




@end


@implementation MTDBHelper

///获取单例对象
static MTDBHelper *_dbHelper = nil;

+ (_Nonnull instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _dbHelper = [[MTDBHelper alloc] init];
    });
    return _dbHelper;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        //创建信号量.
        self.semaphore = dispatch_semaphore_create(1);
    }
    return self;
}




- (FMDatabaseQueue *)queue{
    if(_queue) return _queue;
    //获得沙盒中的数据库文件名
    NSString *filePath = [[NSString mt_cachesPath] stringByAppendingPathComponent:SQLITE_NAME];
    //NSLog(@"数据库路径 = %@",filename);
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    return _queue;
}




///关闭数据库
- (void)closeDB {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    if(!_inTransaction && _queue) {//没有事务的情况下就关闭数据库.
        [_queue close];//关闭数据库.
        _queue = nil;
    }
    dispatch_semaphore_signal(self.semaphore);
}





/**
 为了对象层的事物操作而封装的函数.
 */
- (void)executeDB:(void (^_Nonnull)(FMDatabase *_Nonnull db))block{
    NSAssert(block, @"block is nil!");
    
    if (_db){//为了事务操作防止死锁而设置.
        block(_db);
        return;
    }
    __weak typeof(self) weakSelf = self;
    [self.queue inDatabase:^(FMDatabase *db){
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.db = db;
        block(db);
        strongSelf.db = nil;
    }];
    
}
















/**数据库中是否存在表.*/
- (BOOL)mt_isIfExistWithTableName:(NSString *)tableName {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    NSAssert(tableName,@"表名不能为空!");
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        result = [db tableExists:tableName];
    }];
    dispatch_semaphore_signal(self.semaphore);
    return result;
}





/**
 数据库中是否存在表.
 */
- (void)isExistWithTableName:(NSString* _Nonnull)name complete:(void(^_Nullable)(BOOL isExist))complete{
    NSAssert(name,@"表名不能为空!");
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        result = [db tableExists:name];
    }];
    !complete ?: complete(result);
}









#pragma mark ---- 非对象处理
//MARK:-  创建表(如果存在则不创建)
- (void)mt_createTableWithTableName:(NSString* _Nonnull)name
                               keys:(NSArray<MTModel*>* _Nonnull)keysModel
                   unionPrimaryKeys:(NSArray* _Nullable)unionPrimaryKeys
                         uniqueKeys:(NSArray* _Nullable)uniqueKeys
                           complete:(void(^_Nullable)(BOOL isSuccess))complete {
    NSAssert(name,@"表名不能为空!");
    NSAssert(keysModel,@"字段数组不能为空!");
    
    //创表
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        NSString *header = [NSString stringWithFormat:@"create table if not exists %@ (",name];
        NSMutableString* sql = [[NSMutableString alloc] init];
        [sql appendString:header];
        //不能为空字段
        NSInteger uniqueKeyFlag = uniqueKeys.count;
        NSMutableArray* tempUniqueKeys = [NSMutableArray arrayWithArray:uniqueKeys];
        //以星号分割字符串
        for (int i = 0; i < keysModel.count; i++) {
            MTModel *model = keysModel[i];
            
            if(tempUniqueKeys.count && [tempUniqueKeys containsObject:model.key]) {
                for(NSString* uniqueKey in tempUniqueKeys){
                    if([model.key isEqualToString:uniqueKey]){
                        [sql appendFormat:@"%@ unique",[MTDBUtils keyAndType:model]];
                        [sql appendString:@" not null"];
                        [tempUniqueKeys removeObject:uniqueKey];
                        uniqueKeyFlag--;
                        break;
                    }
                }
            } else {
                if ([model.key isEqualToString:mt_primaryKey] && !unionPrimaryKeys.count){
                    [sql appendFormat:@"%@ primary key autoincrement",[MTDBUtils keyAndType:model]];
                }else{
                    [sql appendString:[MTDBUtils keyAndType:model]];
                }
            }
            
            
            
            if (i == (keysModel.count - 1)) {
                if(unionPrimaryKeys.count) {
                    [sql appendString:@",primary key ("];
                    [unionPrimaryKeys enumerateObjectsUsingBlock:^(id  _Nonnull unionKey, NSUInteger idx, BOOL * _Nonnull stop) {
                        if(idx == 0){
                            [sql appendString:unionKey];
                        }else{
                            [sql appendFormat:@",%@",unionKey];
                        }
                    }];
                    [sql appendString:@")"];
                }
                [sql appendString:@");"];
            } else {
                [sql appendString:@","];
            }
            
            
            
            
        }//for over
        
        if(uniqueKeys.count){
            NSAssert(!uniqueKeyFlag,@"没有找到设置的'唯一约束',请检查模型类.m文件的bg_uniqueKeys函数返回值是否正确!");
        }
        
        
        NSLog(@"sql === %@",sql);
        //该执行 如果表已经存在 不再创建新表
        result = [self.db executeUpdate:sql];
    }];
    
    
    NSLog(@"path == %@",[NSString mt_cachesPath]);
    if (result) {
        NSLog(@"建表成功");
    }
    
    !complete ?: complete(result);

}





/**
 如果表格不存在就新建.
 */
+ (BOOL)ifNotExistWillCreateTableWithObject:(id)object{
    //检查是否建立了跟对象相对应的数据表
    NSString* tableName = [MTDBUtils getTableNameWithObject:object];
    //获取"唯一约束"字段名
    NSArray* uniqueKeys = [MTDBUtils executeSelector:mt_uniqueKeysSelector forClass:[object class]];
    //获取“联合主键”字段名
    NSArray* unionPrimaryKeys = [MTDBUtils executeSelector:mt_unionPrimaryKeysSelector forClass:[object class]];
    //忽略key
    NSArray* ignoredKeys = [MTDBUtils executeSelector:mt_ignoreKeysSelector forClass:[object class]];
    __block BOOL isExistTable;
    [[MTDBHelper shareManager] isExistWithTableName:tableName complete:^(BOOL isExist) {
        if (!isExist){//如果不存在就新建
            
            NSArray* createKeys = [MTDBUtils mt_filtCreateKeys:[MTDBUtils getClassIvarList:[object class] onlyKey:NO] ignoredkeys:ignoredKeys];
            [[MTDBHelper shareManager] mt_createTableWithTableName:tableName keys:createKeys unionPrimaryKeys:unionPrimaryKeys uniqueKeys:uniqueKeys complete:^(BOOL isSuccess) {
                isExistTable = isSuccess;
            }];
        }
    }];
    
    return isExistTable;
}











//MARK:- 删除表格。
- (void)mt_dropWithTableName:(NSString* _Nonnull)tablename
                    complete:(void(^_Nullable)(BOOL isSuccess))complete {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    
    __weak typeof(self) weakSelf = self;
    [self isExistWithTableName:tablename complete:^(BOOL isExist) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!isExist) {
            !complete ?: complete(NO);
        } else {
            [strongSelf dropTable:tablename complete:complete];
        }
    }];
    
    dispatch_semaphore_signal(self.semaphore);
}



/**
 删除表.
 */
- (void)dropTable:(NSString* _Nonnull)name complete:(void(^_Nullable)(BOOL isSuccess))complete{
    NSAssert(name,@"表名不能为空!");
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        NSString* sql = [NSString stringWithFormat:@"drop table %@",name];
        result = [db executeUpdate:sql];
    }];
    
    //数据监听执行函数
    !complete ?: complete(result);
}






/**
 从数据库删除某个对象
 */
- (void)mt_removeWithObject:(id _Nonnull)object
                   complete:(void(^_Nullable)(BOOL isSuccess))complete {
    
}





//MARK:- 插入数据. eg:insert into student(sex,address) values(?,?)
- (void)mt_insertIntoTableName:(NSString * _Nonnull)name
                          dict:(NSDictionary* _Nonnull)dict
                      complete:(void(^_Nullable)(BOOL isSuccess))complete {
    NSAssert(name,@"表名不能为空!");
    NSAssert(dict,@"插入值字典不能为空!");
    
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        NSArray* keys = dict.allKeys;
        //主键
        if ([keys containsObject:mt_primaryKey]) {
            NSInteger num = [self getKeyMaxNumsForTable:name key:mt_primaryKey db:db];
            [dict setValue:@(num+1) forKey:mt_primaryKey];
        }
        
        
        NSArray* values = dict.allValues;
        NSMutableString* sql = [[NSMutableString alloc] init];
        [sql appendFormat:@"insert into %@(",name];
        //keys
        for (int i = 0; i < keys.count; i++) {
            [sql appendFormat:@"%@",keys[i]];
            if (i == (keys.count-1)) {
                [sql appendString:@") "];
            } else {
                [sql appendString:@","];
            }
        }
        //values
        [sql appendString:@"values("];
        for (int i = 0; i < values.count; i++) {
            [sql appendString:@"?"];
            if(i == (keys.count-1)){
                [sql appendString:@");"];
            } else {
                [sql appendString:@","];
            }
        }
        
        NSLog(@"insertSql === %@",sql);
        result = [db executeUpdate:sql withArgumentsInArray:values];

    }];
    
    if (result) {
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
    }
    
    !complete ?: complete(result);

}




/**
 插入对象.
 @object
 @complete 回调的block
 */
- (void)mt_insertWithObject:(id)object
                   complete:(void(^_Nullable)(BOOL isSuccess))complete {
    NSDictionary *dictM = [MTDBUtils getDictWithObject:object];
    NSString *tableName = [MTDBUtils getTableNameWithObject:object];
    [self mt_insertIntoTableName:tableName dict:dictM complete:complete];
}





- (NSInteger)getKeyMaxNumsForTable:(NSString*)name key:(NSString*)key db:(FMDatabase*)db{
    __block NSInteger num = 0;
    [db executeStatements:[NSString stringWithFormat:@"select max(%@) from %@",key,name] withResultBlock:^int(NSDictionary *resultsDictionary){
        id dbResult = [resultsDictionary.allValues lastObject];
        if(dbResult && ![dbResult isKindOfClass:[NSNull class]]) {
            num = [dbResult integerValue];
        }
        return 0;
    }];
    return num;
}



//MARK:- 存储数据
/**
 存储一个对象.
 @object 将要存储的对象.
 @ignoreKeys 忽略掉模型中的哪些key(即模型变量)不要存储,nil时全部存储.
 @complete 回调的block.
 */
- (void)mt_saveObject:(id _Nonnull)object
             complete:(void(^_Nullable)(BOOL isSuccess))complete {
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    @autoreleasepool {
        [[self class] ifNotExistWillCreateTableWithObject:object];
        [self mt_insertWithObject:object complete:complete];
    }
    dispatch_semaphore_signal(self.semaphore);
}




- (void)mt_saveOrUpateArray:(NSArray* _Nonnull)array
                   complete:(void(^_Nullable)(BOOL isSuccess))complete {
    
    
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    @autoreleasepool {
        //判断是否建表.
        [[self class] ifNotExistWillCreateTableWithObject:array.firstObject];
        //检查是否建立了跟对象相对应的数据表
        NSString *tableName = [MTDBUtils getTableNameWithObject:array.firstObject];
        //转换模型数据
        NSArray<NSDictionary*>* dictArray = [MTDBUtils getDictArray:array];
        
        [self mt_saveOrUpdateWithTableName:tableName class:[array.firstObject class] dictArray:dictArray complete:complete];
        
    }
    dispatch_semaphore_signal(self.semaphore);
    
}



/**
 批量插入或更新.
 */
- (void)mt_saveOrUpdateWithTableName:(NSString* _Nonnull)tablename
                               class:(__unsafe_unretained _Nonnull Class)cla
                           dictArray:(NSArray<NSDictionary*>* _Nonnull)dictArray
                            complete:(void(^_Nullable)(BOOL isSuccess))complete{
    __block BOOL result;
    [self executeDB:^(FMDatabase * _Nonnull db) {
        [db beginTransaction];
        __block NSInteger counter = 0;
        [dictArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull dict, NSUInteger idx, BOOL * _Nonnull stop) {
            @autoreleasepool {
                //获得"唯一约束"
                NSArray* uniqueKeys = [MTDBUtils executeSelector:mt_uniqueKeysSelector forClass:cla];
                //获得"联合主键"
                NSArray* unionPrimaryKeys =[MTDBUtils executeSelector:mt_unionPrimaryKeysSelector forClass:cla];
                NSMutableDictionary* tempDict = [[NSMutableDictionary alloc] initWithDictionary:dict];
                NSMutableString* where = [NSMutableString new];
                BOOL isSave = NO;//是否存储还是更新.
                if(uniqueKeys.count || unionPrimaryKeys.count){
                    NSArray* tempKeys;
                    NSString* orAnd;
                    
                    if(unionPrimaryKeys.count){
                        tempKeys = unionPrimaryKeys;
                        orAnd = @"and";
                    }else{
                        tempKeys = uniqueKeys;
                        orAnd = @"or";
                    }
                    
                    if(tempKeys.count == 1){
                        NSString* tempkey = [tempKeys firstObject];
                        id tempkeyVlaue = tempDict[tempkey];
                        [where appendFormat:@" where %@=%@",tempkey,tempkeyVlaue];
                    }else{
                        [where appendString:@" where"];
                        [tempKeys enumerateObjectsUsingBlock:^(NSString*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop){
                            NSString* tempkey = obj;
                            id tempkeyVlaue = tempDict[tempkey];
                            if(idx < (tempKeys.count-1)){
                                [where appendFormat:@" %@=%@ %@",tempkey,tempkeyVlaue,orAnd];
                            }else{
                                [where appendFormat:@" %@=%@",tempkey,tempkeyVlaue];
                            }
                        }];
                    }
                    NSString* dataCountSql = [NSString stringWithFormat:@"select count(*) from %@%@",tablename,where];
                    __block NSInteger dataCount = 0;
                    [db executeStatements:dataCountSql withResultBlock:^int(NSDictionary *resultsDictionary) {
                        dataCount = [[resultsDictionary.allValues lastObject] integerValue];
                        return 0;
                    }];
                    NSLog(@"%@",dataCountSql);
                    if(dataCount){
                        //更新操作
                        [tempKeys enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                            [tempDict removeObjectForKey:obj];
                        }];
                    }else{
                        //插入操作
                        isSave = YES;
                    }
                }else{
                    if([tempDict.allKeys containsObject:mt_primaryKey]){
                        //更新操作
                        id primaryKeyVlaue = tempDict[mt_primaryKey];
                        [where appendFormat:@" where %@=%@",mt_primaryKey,primaryKeyVlaue];
                    }else{
                        //插入操作
                        isSave = YES;
                    }
                }
                
                NSMutableString* SQL = [[NSMutableString alloc] init];
                NSMutableArray* arguments = [NSMutableArray array];
                if(isSave){//存储操作
                    NSInteger num = [self getKeyMaxForTable:tablename key:mt_primaryKey db:db];
                    [tempDict setValue:@(num+1) forKey:mt_primaryKey];
                    [SQL appendFormat:@"insert into %@(",tablename];
                    NSArray* keys = tempDict.allKeys;
                    NSArray* values = tempDict.allValues;
                    for(int i=0;i<keys.count;i++){
                        [SQL appendFormat:@"%@",keys[i]];
                        if(i == (keys.count-1)){
                            [SQL appendString:@") "];
                        }else{
                            [SQL appendString:@","];
                        }
                    }
                    [SQL appendString:@"values("];
                    for(int i=0;i<values.count;i++){
                        [SQL appendString:@"?"];
                        if(i == (keys.count-1)){
                            [SQL appendString:@");"];
                        }else{
                            [SQL appendString:@","];
                        }
                        [arguments addObject:values[i]];
                    }
                }else{//更新操作
                    if([tempDict.allKeys containsObject:mt_primaryKey]){
                        [tempDict removeObjectForKey:mt_primaryKey];//移除主键
                    }
                    [tempDict removeObjectForKey:mt_createTimeKey];//移除创建时间
                    [SQL appendFormat:@"update %@ set ",tablename];
                    [tempDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
                        [SQL appendFormat:@"%@=?,",key];
                        [arguments addObject:obj];
                    }];
                    SQL = [NSMutableString stringWithString:[SQL substringToIndex:SQL.length-1]];
                    if(where.length) {
                        [SQL appendString:where];
                    }
                }
                
                
                NSLog(@"%@",SQL);
                BOOL flag = [db executeUpdate:SQL withArgumentsInArray:arguments];
                if(flag){
                    counter++;
                }
            }
        }];
        
        if (dictArray.count == counter){
            result = YES;
            [db commit];
        }else{
            result = NO;
            [db rollback];
        }
        
    }];
    //数据监听执行函数
    !complete ?: complete(result);
}





- (NSInteger)getKeyMaxForTable:(NSString*)name key:(NSString*)key db:(FMDatabase*)db{
    __block NSInteger num = 0;
    [db executeStatements:[NSString stringWithFormat:@"select max(%@) from %@",key,name] withResultBlock:^int(NSDictionary *resultsDictionary){
        id dbResult = [resultsDictionary.allValues lastObject];
        if(dbResult && ![dbResult isKindOfClass:[NSNull class]]) {
            num = [dbResult integerValue];
        }
        return 0;
    }];
    return num;
}





//MARK:- 查询数据
/**
 直接传入条件sql语句查询.
 */
- (void)mt_queryWithTableName:(NSString* _Nonnull)name
                   conditions:(NSString* _Nullable)conditions
                     complete:(void(^_Nullable)(NSArray <NSDictionary *>* result))complete {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    @autoreleasepool {
        [self queryWithTableName:name conditions:conditions complete:complete];
    }
    dispatch_semaphore_signal(self.semaphore);
}


- (void)queryWithTableName:(NSString* _Nonnull)name
                conditions:(NSString* _Nullable)conditions
                  complete:(void(^_Nullable)(NSArray <NSDictionary *>* result))complete {
    NSAssert(name,@"表名不能为空!");
    __block  NSMutableArray *result = [[NSMutableArray alloc] init];
    [self executeDB:^(FMDatabase * _Nonnull db) {
       
        NSString* sql = conditions ? [NSString stringWithFormat:@"select * from %@ %@",name,conditions] : [NSString stringWithFormat:@"select * from %@",name];
        
        NSLog(@"sql == %@",sql);
        //查询数据
        FMResultSet *rs = [db executeQuery:sql];
        while (rs.next) {
            NSMutableDictionary* dictM = [[NSMutableDictionary alloc] init];
            for (int i=0;i<[[[rs columnNameToIndexMap] allKeys] count];i++) {
                id obj = [rs objectForColumnIndex:i];
                if ([obj isKindOfClass:[NSNull class]]) {
                    obj = @"";
                }
                
                dictM[[rs columnNameForIndex:i]] = obj;
            }
            [result addObject:dictM];
        }

        //查询完后要关闭rs，不然会报@"Warning: there is at least one open result set around after performing
        [rs close];
    }];
    
    !complete ?: complete(result);

}



- (void)mt_queryWithTableName:(NSString* _Nonnull)name
                        class:(__unsafe_unretained _Nonnull Class)cla
                   conditions:(NSString* _Nullable)conditions
                     complete:(void(^_Nullable)(NSArray<NSObject *> * _Nullable result))complete {
    __weak typeof (self) weakSelf = self;
    [self isExistWithTableName:name complete:^(BOOL isExist) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!isExist) {
            !complete ?: complete(nil);
        } else {
            [strongSelf queryWithTableName:name conditions:conditions complete:^(NSArray<NSDictionary *> *result) {
                if (result) {
                    NSArray *objArray = [cla mj_objectArrayWithKeyValuesArray:result];
                    !complete ?: complete(objArray);
                } else {
                    !complete ?: complete(nil);
                }
            }];
        }
        
    }];
    
}







//MARK: - 更新数据
/**
 更新数据.
 */
- (void)mt_updateWithTableName:(NSString * _Nonnull)name
                          dict:(NSDictionary* _Nonnull)dict
                    conditions:(NSString* _Nullable)conditions
                      complete:(void(^_Nullable)(BOOL isSuccess))complete {
    
    NSAssert(name,@"表名不能为空!");
    NSAssert(dict,@"更新数据集合不能为空!");
    __block BOOL result;
    NSMutableArray* arguments = [NSMutableArray array];
    [self executeDB:^(FMDatabase * _Nonnull db) {
        NSMutableString* SQL = [[NSMutableString alloc] init];
        [SQL appendFormat:@"update %@ set ",name];
        for(int i=0;i<dict.allKeys.count;i++){
            [SQL appendFormat:@"%@ = ?",dict.allKeys[i]];
            [arguments addObject:dict[dict.allKeys[i]]];
            if (i != (dict.allKeys.count-1)) {
                [SQL appendString:@","];
            }
        }
        
        if (conditions) [SQL appendString:[NSString stringWithFormat:@" %@",conditions]];
        NSLog(@"insert == %@",SQL);
        
        result = [db executeUpdate:SQL withArgumentsInArray:arguments];
    }];
    
    //数据监听执行函数
    !complete ?: complete(result);
    
}



@end
