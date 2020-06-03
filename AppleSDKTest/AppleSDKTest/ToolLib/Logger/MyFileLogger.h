//
//  MyFileLogger.h
//  Wallet  日志记录
//
//  Created by Sherwin.Chen on 16/1/5.
//  Copyright © 2017年 maimaiti. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"
#import "MPLoggerFormatter.h"

//DDLog使用介绍: http://www.cocoachina.com/industry/20140414/8157.html
@class FMDBLogger;
@class HttpLogger;

@interface MyFileLogger : NSObject
@property (nonatomic, strong, readwrite) DDFileLogger *fileLogger;
@property (nonatomic, strong, readwrite) FMDBLogger   *dbLogger;
@property (nonatomic, strong, readwrite) HttpLogger   *httpLogger;

+(MyFileLogger *)sharedManager;

@end

