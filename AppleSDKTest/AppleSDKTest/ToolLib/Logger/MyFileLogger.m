//
//  MyFileLogger.m
//  Wallet
//
//  Created by Sherwin.Chen on 16/1/5.
//  Copyright © 2017年 maimaiti. All rights reserved.
//

#import "MyFileLogger.h"

@implementation MyFileLogger

#pragma mark - Inititlization
- (instancetype)init
{
    self = [super init];
    
    if (self) {
        [self configureLogging];
    }
    return self;
}

#pragma mark 单例模式

static MyFileLogger *sharedManager=nil;

+(MyFileLogger *)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedManager=[[self alloc]init];
    });
    return sharedManager;
}


#pragma mark - Configuration
/*

 DDASLLogger 输出到Console.app
 DDTTYLogger 输出到Xcode控制台
 DDLogFileManager 输出到文件
 DDAbstractDatabaseLogger 输出到DB
 
 通过ddLogLevel的int型变量或常量来定义打印等级
 
 LOG_LEVEL_OFF 关闭Log
 LOG_LEVEL_ERROR 只打印Error级别的Log
 LOG_LEVEL_WARN 打印Error和Warning级别的Log
 LOG_LEVEL_INFO 打印Error、Warn、Info级别的Log
 LOG_LEVEL_DEBUG 打印Error、Warn、Info、Debug级别的Log
 LOG_LEVEL_VERBOSE 打印Error、Warn、Info、Debug、Verbose级别的Log
 
 使用不同的宏打印不同级别的Log
 
 DDLogError(frmt, …) 打印Error级别的Log
 DDLogWarn(frmt, …) 打印Warn级别的Log
 DDLogInfo(frmt, …) 打印Info级别的Log
 DDLogDebug(frmt, …) 打印Debug级别的Log
 DDLogVerbose(frmt, …) 打印Verbose级别的Log
 */

- (void)configureLogging
{

    //调试版本 [debug] 控制台输出/数据库记录.
 
    [DDLog addLogger:[DDTTYLogger sharedInstance]];

    MPLoggerFormatter* formatter = [[MPLoggerFormatter alloc] init];
    [[DDTTYLogger sharedInstance] setLogFormatter:formatter];


    //[DDLog addLogger:self.fileLogger];
    //DDLog addLogger:<#(id<DDLogger>)#> withLevel:<#(DDLogLevel)#> //自定义接收日志级别
    //[DDLog addLogger:self.dbLogger];
    //[DDLog addLogger:self.httpLogger];
    

    //设置输出的LOG样式
    //MPLoggerFormatter* formatter = [[MPLoggerFormatter alloc] init];
    //[[DDTTYLogger sharedInstance] setLogFormatter:formatter];
    
    //HttpLoggerFormatter *strongFormatter = [[HttpLoggerFormatter alloc] init];
    //[_fileLogger  setLogFormatter:strongFormatter];
    //[_dbLogger    setLogFormatter:strongFormatter];
    //[_httpLogger  setLogFormatter:strongFormatter];
}

#pragma mark - Getters

- (DDFileLogger *)fileLogger
{
    if (!_fileLogger) {
        DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
        fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
        fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
        
        _fileLogger = fileLogger;
    }
    
    return _fileLogger;
}


@end
