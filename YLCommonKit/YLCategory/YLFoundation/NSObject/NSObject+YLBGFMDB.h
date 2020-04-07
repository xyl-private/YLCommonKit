//
//  NSObject+YLBGFMDB.h
//  YLCommonKit
//
//  Created by zjmac on 2019/7/2.
//  Copyright © 2019 xyanl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BGFMDBConfig.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSObject (YLBGFMDB)

#pragma mark - 对象操作
#pragma mark - 存储&更新
/**
 同步存储.
 */
- (BOOL)yl_save;
/**
 同步存储或更新.
 当"唯一约束"或"主键"存在时，此接口会更新旧数据,没有则存储新数据.
 提示：“唯一约束”优先级高于"主键".
 */
- (BOOL)yl_saveOrUpdate;
/**
 同步 存储或更新 数组元素.
 @array 存放对象的数组.(数组中存放的是同一种类型的数据)
 当"唯一约束"或"主键"存在时，此接口会更新旧数据,没有则存储新数据.
 提示：“唯一约束”优先级高于"主键".
 */
+ (BOOL)yl_saveOrUpdateArray:(NSArray* _Nonnull)array;
/**
 同上条件异步.
 */
+(void)yl_saveOrUpdateArrayAsync:(NSArray* _Nonnull)array complete:(bg_complete_B)complete;

#pragma mark - 更新
/**
 此接口不支持keyPath.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，更新以此参数为表名的数据.
 @where 条件参数,不能为nil.
 where使用规则请看demo或如下事例:
 1.将People类中name等于"马云爸爸"的数据的name更新为"马化腾":
 where = [NSString stringWithFormat:@"set %@=%@ where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(@"马化腾"),bg_sqlKey(@"name"),bg_sqlValue(@"马云爸爸")];
 */
+ (BOOL)yl_update:(NSString* _Nullable)tablename where:(NSString* _Nonnull)where;
/**
 同步覆盖存储.
 覆盖掉原来的数据,只存储当前的数据.
 */
- (BOOL)yl_cover;

#pragma mark - 删除
/**
 同步删除这个类的数据表.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，清除以此参数为表名的数据.
 */
+ (BOOL)yl_drop:(NSString* _Nullable)tablename;
/**
 异步删除这个类的数据表.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，清除以此参数为表名的数据.
 */
+ (void)yl_dropAsync:(NSString* _Nullable)tablename complete:(bg_complete_B)complete;

#pragma mark - 条件查询
/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 温馨提示: 当数据量巨大时,请用范围接口进行分页查询,避免查询出来的数据量过大导致程序崩溃.
 */
+ (NSArray* _Nullable)yl_findAll:(NSString* _Nullable)tablename;
/**
 查找第一条数据
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 */
+ (id _Nullable)yl_firstObjet:(NSString* _Nullable)tablename;
/**
 同步查询所有结果.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @orderBy 要排序的key.
 @limit 每次查询限制的条数,0则无限制.
 @desc YES:降序，NO:升序.
 */
+ (NSArray* _Nullable)yl_find:(NSString* _Nullable)tablename limit:(NSInteger)limit orderBy:(NSString* _Nullable)orderBy desc:(BOOL)desc;
/**
 支持keyPath.
 @tablename 当此参数为nil时,查询以此类名为表名的数据，非nil时，查询以此参数为表名的数据.
 @cla 模型类型
 @where 条件参数，可以为nil,nil时查询所有数据.
 where使用规则请看demo或如下事例:
 1.查询name等于爸爸和age等于45,或者name等于马哥的数据.  此接口是为了方便开发者自由扩展更深层次的查询条件逻辑.
 where = [NSString stringWithFormat:@"where %@=%@ and %@=%@ or %@=%@",bg_sqlKey(@"age"),bg_sqlValue(@(45)),bg_sqlKey(@"name"),bg_sqlValue(@"爸爸"),bg_sqlKey(@"name"),bg_sqlValue(@"马哥")];
 2.查询user.student.human.body等于小芳 和 user1.name中包含fuck这个字符串的数据.
 where = [NSString stringWithFormat:@"where %@",bg_keyPathValues(@[@"user.student.human.body",bg_equal,@"小芳",@"user1.name",bg_contains,@"fuck"])];
 3.查询user.student.human.body等于小芳,user1.name中包含fuck这个字符串 和 name等于爸爸的数据.
 where = [NSString stringWithFormat:@"where %@ and %@=%@",bg_keyPathValues(@[@"user.student.human.body",bg_equal,@"小芳",@"user1.name",bg_contains,@"fuck"]),bg_sqlKey(@"name"),bg_sqlValue(@"爸爸")];
 */
+ (NSArray* _Nullable)yl_find:(NSString* _Nullable)tablename class:(__unsafe_unretained _Nonnull Class)cla where:(NSString* _Nullable)where;
/**
 查询该表中有多少条数据.
 @tablename 当此参数为nil时,查询以此类名为表名的数据条数，非nil时，查询以此参数为表名的数据条数.
 @where 条件参数,nil时查询所有以tablename为表名的数据条数.
 支持keyPath.
 使用规则请看demo或如下事例:
 1.查询People类中name等于"美国队长"的数据条数.
 where = [NSString stringWithFormat:@"where %@=%@",bg_sqlKey(@"name"),bg_sqlValue(@"美国队长")];
 2.查询People类中user.student.human.body等于"小芳"的数据条数.
 where = [NSString stringWithFormat:@"where %@",bg_keyPathValues(@[@"user.student.human.body",bg_equal,@"小芳"])];
 3.查询People类中name等于"美国队长" 和 user.student.human.body等于"小芳"的数据条数.
 where = [NSString stringWithFormat:@"where %@=%@ and %@",bg_sqlKey(@"name"),bg_sqlValue(@"美国队长"),bg_keyPathValues(@[@"user.student.human.body",bg_equal,@"小芳"])];
 */
+ (NSInteger)yl_count:(NSString* _Nullable)tablename where:(NSString* _Nullable)where;

@end

@interface NSArray (JYFMDB)
#pragma mark - 数组操作
/**
 存储数组.
 @name 唯一标识名称.
 **/
- (BOOL)yl_saveArrayWithName:(NSString* const _Nonnull)name;
/**
 添加数组元素.
 @name 唯一标识名称.
 @object 要添加的元素.
 */
+ (BOOL)yl_addObjectWithName:(NSString* const _Nonnull)name object:(id const _Nonnull)object;
/**
 获取数组元素数量.
 @name 唯一标识名称.
 */
+ (NSInteger)yl_countWithName:(NSString* const _Nonnull)name;
/**
 查询整个数组
 */
+ (NSArray* _Nullable)yl_arrayWithName:(NSString* const _Nonnull)name;
/**
 获取数组某个位置的元素.
 @name 唯一标识名称.
 @index 数组元素位置.
 */
+ (id _Nullable)yl_objectWithName:(NSString* const _Nonnull)name Index:(NSInteger)index;
/**
 更新数组某个位置的元素.
 @name 唯一标识名称.
 @index 数组元素位置.
 */
+ (BOOL)yl_updateObjectWithName:(NSString* const _Nonnull)name Object:(id _Nonnull)object Index:(NSInteger)index;
/**
 删除数组的某个元素.
 @name 唯一标识名称.
 @index 数组元素位置.
 */
+ (BOOL)yl_deleteObjectWithName:(NSString* const _Nonnull)name Index:(NSInteger)index;
/**
 清空数组元素.
 @name 唯一标识名称.
 */
+ (BOOL)yl_clearArrayWithName:(NSString* const _Nonnull)name;

@end

@interface NSDictionary (JYFMDB)
#pragma mark - 字典操作
/**
 存储字典.
 */
- (BOOL)yl_saveDictionary;
/**
 添加字典元素.
 */
+ (BOOL)yl_setValue:(id const _Nonnull)value forKey:(NSString* const _Nonnull)key;
/**
 更新字典元素.
 */
+ (BOOL)yl_updateValue:(id const _Nonnull)value forKey:(NSString* const _Nonnull)key;
/**
 获取字典元素.
 */
+ (id _Nullable)yl_valueForKey:(NSString* const _Nonnull)key;
/**
 遍历字典元素.
 */
+ (void)yl_enumerateKeysAndObjectsUsingBlock:(void (^ _Nonnull)(NSString* _Nonnull key, id _Nonnull value,BOOL *stop))block;
/**
 移除字典某个元素.
 */
+ (BOOL)yl_removeValueForKey:(NSString* const _Nonnull)key;
/**
 清空字典.
 */
+ (BOOL)yl_clearDictionary;

@end

NS_ASSUME_NONNULL_END
