#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSArray+Safe.h"
#import "NSDictionary+Safe.h"
#import "NSMutableArray+Safe.h"
#import "NSMutableDictionary+Safe.h"
#import "NSMutableString+Safe.h"
#import "NSObject+ImpChangeTool.h"
#import "NSObject+Swizzling.h"
#import "SafeObject.h"

FOUNDATION_EXPORT double SafeObjectVersionNumber;
FOUNDATION_EXPORT const unsigned char SafeObjectVersionString[];

