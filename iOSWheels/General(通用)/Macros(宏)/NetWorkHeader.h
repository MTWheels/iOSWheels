//
//  NetWorkHeader.h
//  iOSWheels
//
//  Created by liyan on 2018/5/9.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#ifndef NetWorkHeader_h
#define NetWorkHeader_h



#ifdef DEBUG
    #define RequestWebsite(string) [NSString  stringWithFormat:@"https://101.200.75.215:90/%@",string]
#else
    #define RequestWebsite(string) [NSString  stringWithFormat:@"https://www.baidu.com",string]
#endif


#endif /* NetWorkHeader_h */

