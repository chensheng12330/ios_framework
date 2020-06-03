//
//  MPLoggerFormatter.m
//  Wallet
//
//  Created by Sherwin.Chen on 16/6/20.
//  Copyright © 2017年 maimaiti. All rights reserved.
//

#import "MPLoggerFormatter.h"
//#import "NSDate+Utilities.h"
@interface MPLoggerFormatter ()
@property(nonatomic, strong) NSDateFormatter *mDateFormatter;
@end

@implementation MPLoggerFormatter


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.mDateFormatter = [[NSDateFormatter alloc] init];
        [self.mDateFormatter setDateFormat:@"yy-MM-dd HH:mm:ss.SSS"];
    }
    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    
    NSString *logLevel = nil;
    switch (logMessage.flag) {
        case DDLogFlagError:
            logLevel = @"❌(ERROR])";
            break;
        case DDLogFlagWarning:
            logLevel = @"⚠️(WARNG)";
            break;
        case DDLogFlagInfo:
            logLevel = @"🎉(INFOM)";
            break;
        case DDLogFlagDebug:
            logLevel = @"✴️(DEBUG)";
            break;
        default:
            logLevel = @"✅(VBOSE)";
            break;
    }
    //_queueLabel
    NSString *formatStr
    = [NSString stringWithFormat:@"\n> %@, {%@}, [%@ ➥%ld], \n> (%@), %@ ↓↓↓↓\n%@",
       logLevel,
       [self.mDateFormatter stringFromDate:logMessage.timestamp],
       logMessage.fileName,
       (unsigned long)logMessage.line,
       logMessage.queueLabel,
       logMessage.function,
       logMessage.message];

    return formatStr;
}

-(NSString*) stringWithDate:(NSDate*) date {
    return [self.mDateFormatter stringFromDate:date];
}



/*
 NSString *path = [NSString stringWithCString:logMessage->file encoding:NSASCIIStringEncoding];
 NSString *fileName = [path lastPathComponent];
 NSString *functionName = [NSString stringWithCString:logMessage->function encoding:NSASCIIStringEncoding];

 return [NSString stringWithFormat:@"%@-%@(%d): %@", fileName, functionName, logMessage->lineNumber, logMessage->logMsg];
 */
@end

