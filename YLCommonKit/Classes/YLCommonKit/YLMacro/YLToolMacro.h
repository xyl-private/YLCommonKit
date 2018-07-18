//
//  YLToolMacro.h
//  Pods
//
//  Created by McIntosh on 2018/5/15.
//

#ifndef YLToolMacro_h
#define YLToolMacro_h

///Objective-C Unicode转中文 重写NSLog
/*** 自定义Log **/
#ifdef DEBUG
#define YLLog(...) NSLog(__VA_ARGS__)
#else
#define YLLog(...)
#endif

#define YLLogFunc NSLog(@"%s",__func__)

/***************************************************************************
 * 常用
 **************************/
//UserDefaults保存信息
#define kUserUserDefaults_Save(_value,_key)  [[NSUserDefaults standardUserDefaults] setObject:_value forKey:_key]

//UserDefaults获取信息
#define kUserUserDefaults_Get(_key) [[NSUserDefaults standardUserDefaults] objectForKey:_key]

//UserDefaults删除信息
#define kUserUserDefaults_Remove(_key) [[NSUserDefaults standardUserDefaults] removeObjectForKey:_key]

#define kStoryboard( _sbName, _identifier)         [[UIStoryboard storyboardWithName:_sbName bundle:nil] instantiateViewControllerWithIdentifier:_identifier]

//AppDelegate对象
#define kAppDelegateInstance [[UIApplication sharedApplication] delegate]

//App版本号
#define kAppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
// 当前版本
#define kFSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
#define kDSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
#define kSSystemVersion          ([[UIDevice currentDevice] systemVersion])
//获取当前语言
#define kCurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])
//获取图片资源
#define kGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]]
//获取temp
#define kPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define kPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define kPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//字符串是否为空
#define kStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//数组是否为空
#define kArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//字典是否为空
#define kDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//是否是空对象
#define kObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))

// 是否大于等于IOS7
#define isIOS7                  ([[[UIDevice currentDevice]systemVersion]floatValue] >= 7.0)
// 是否IOS6
#define isIOS6                  ([[[UIDevice currentDevice]systemVersion]floatValue] < 7.0)
// 是否大于等于IOS8
#define isIOS8                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=8.0)
// 是否大于IOS9
#define isIOS9                  ([[[UIDevice currentDevice]systemVersion]floatValue] >=9.0)
// 是否iPad
#define isPad                   (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

// 弱引用
#define YLWeakSelf __weak typeof(self) weakSelf = self;
//设置图片内容
#define kImage(NAME)   [UIImage imageNamed:NAME]
//设置URL
#define kURL(POSITION) [NSURL URLWithString:POSITION]

//数据倍数
#define kDOUBLE(NUM)    (NUM*2.0f)
#define kTRIPLE(NUM)    (NUM*3.0f)

#define kPARTTWO(NUM)   (NUM/2.0f)
#define kPARTTHREE(NUM) (NUM/3.0f)

//获取地点key对应的value
#define kObjectFromDictionary(_dic,_key)  [NSString stringWithFormat:@"%@",[_dic objectForKey:_key]?[_dic objectForKey:_key]:@""]

#define kCHECKVALUE(_value) _value ? _value : @""

// 去除调用代理方法的警告
#define SuppressPerformSelectorLeakWarning(Stuff) \
do {\
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


#endif /* YLToolMacro_h */
