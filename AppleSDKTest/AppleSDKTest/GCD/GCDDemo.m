//
//  GCDDemo.m
//  AppleSDKTest
//
//  Created by sherwin.chen on 2020/5/28.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//


#import "GCDDemo.h"

@implementation GCDDemo

-(void) createKindOfQueue {

    /**
     DISPATCH_QUEUE_SERIAL
     DISPATCH_QUEUE_SERIAL_INACTIVE
     DISPATCH_QUEUE_CONCURRENT
     DISPATCH_QUEUE_CONCURRENT_INACTIVE
     */

    //1. 创建队列：

    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue1", DISPATCH_QUEUE_SERIAL);
    //dispatch_queue_set

    //并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);

    //并发全局队列
    /**
     DISPATCH_QUEUE_PRIORITY_HIGH
     DISPATCH_QUEUE_PRIORITY_DEFAULT
     DISPATCH_QUEUE_PRIORITY_LOW
     DISPATCH_QUEUE_PRIORITY_BACKGROUND

     flags:Flags that are reserved for future use. Always specify 0 for this parameter.
     */
    dispatch_queue_t global_concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //串行主队列 (不创建新线程)
    dispatch_queue_t main_serialQueue = dispatch_get_main_queue();


    //2. 派发执行方式
    //同步

    //串行异步
    dispatch_async(serialQueue, ^{


        DDLogInfo(@">>>串行异步-线程%@",[NSThread currentThread]);
    });

    //串行同步
    dispatch_sync(serialQueue, ^{

        DDLogInfo(@">>>串行同步- 线程%@",[NSThread currentThread]);
    });


    //并行异步
    dispatch_async(concurrentQueue, ^{

        DDLogInfo(@">>>并行异步-线程%@",[NSThread currentThread]);


        //并行同步
        dispatch_sync(concurrentQueue, ^{
            DDLogInfo(@">>>并行同步-线程%@",[NSThread currentThread]);
        });
    });
    
    return;
}

/**
 2.异步执行
 a.不同队列上执行异步
 b.延时执行
 c.块任务dispatch_block_t \ 函数任务dispatch_function_t
 */
- (void) dispatchAsync_a {

    //串行队列
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue1", DISPATCH_QUEUE_SERIAL);
    //dispatch_queue_set

    //并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);

    //并发全局队列
    /**
    DISPATCH_QUEUE_PRIORITY_HIGH
    DISPATCH_QUEUE_PRIORITY_DEFAULT
    DISPATCH_QUEUE_PRIORITY_LOW
    DISPATCH_QUEUE_PRIORITY_BACKGROUND

    flags:Flags that are reserved for future use. Always specify 0 for this parameter.
    */
    dispatch_queue_t global_concurrent_queue_H = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);

    dispatch_queue_t global_concurrent_queue_D = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    dispatch_queue_t global_concurrent_queue_L = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);

    dispatch_queue_t global_concurrent_queue_B = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    //串行主队列 (不创建新线程)
    dispatch_queue_t main_serialQueue = dispatch_get_main_queue();

    NSArray *arQueue = @[serialQueue, concurrentQueue, main_serialQueue, global_concurrent_queue_H,global_concurrent_queue_D, global_concurrent_queue_L, global_concurrent_queue_B,];

    for (dispatch_queue_t queue in arQueue) {
        dispatch_async(queue, ^{
            DDLogInfo(@">>>并行异步-线程%@",[NSThread currentThread]);
        });
    }
}

//串行队列异步执行
-(void) asyncInSerialQueue {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

    //__block int timeNum = 1;
    dispatch_block_t dbt_2 = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];

        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };

    dispatch_block_t dbt_3 = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:3];

        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };

    for (int i=0; i<5; i++) {

        dispatch_async(serialQueue, dbt_2);
    }

    for (int i=0; i<5; i++) {

        dispatch_async(serialQueue, dbt_3);
    }

    /**
     //串行队列异步任务中 执行当前队列的同步任务.
     // 同步创建一个线程
     // 异步执行多条,但只创建一个线程.
     dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

     dispatch_sync(serialQueue, ^{
         DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
         //将产生死锁
         dispatch_async(serialQueue, ^{
             [NSThread sleepForTimeInterval:2];
             DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
         });

         dispatch_async(serialQueue, ^{
             [NSThread sleepForTimeInterval:2];
             DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
         });

         dispatch_async(serialQueue, ^{
             [NSThread sleepForTimeInterval:2];
             DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
         });
     });


     */
}

/**串行同步, 不在主线程中同步执行*/
-(void) syncInSerialQueue
{
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

    dispatch_block_t dbt = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };


    BOOL isInMain = NO;

    if (isInMain) {
        //主线程中执行同步
        for (int i=0; i<10; i++) {
            //在主线程中执行同步操作,将会把UI主线程等死,可做相应的测试功能.
            dispatch_sync(serialQueue, dbt);
        }
    }
    else{
        //非主线程中执行同步
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            for (int i=0; i<10; i++) {
                //在后台线程中执行同步操作.
                //如果在主线程中执行同步操作,将会把UI主线程等死,可做相应的测试功能.
                dispatch_sync(serialQueue, dbt);
            }

        });
    }
}


//并行异步
/**
 自定义并行队列,可异步创建多条线程运行,(一个任务对印一条线程)
 全局并行队,将会创建一条线程,但会使用 main线程与当前线程来执行 任务.即两条.
 
 */
-(void) asyncInConcurrentQueue {
    //并发队列
    
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue.101", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t dbt = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>并行队列异步执行-线程%@",[NSThread currentThread]);
    };

    for (int i=0; i<10; i++) {

        dispatch_async(concurrentQueue, dbt);
    }
    
    /**/

    ///
    //全局队列并行异步,查看启用的线程数
    dispatch_queue_t global_concurrent_queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
    
    dispatch_apply(10, global_concurrent_queue, ^(size_t t) {
        [NSThread sleepForTimeInterval:2];
        
        DDLogInfo(@"----完成 第[%zu]个任务---当前线程%@",t, [NSThread currentThread]);
    });
    //dispatch_async(global_concurrent_queue, db);
    
    
}

//并行同步
-(void) syncInConcurrentQueue {
    //并发队列
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue.102", DISPATCH_QUEUE_CONCURRENT);
    dispatch_block_t dbt = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };
    for (int i=0; i<10; i++) {

        //将会阻塞在主线程中.
        //因为此调用是在主线程中call.
        dispatch_sync(concurrentQueue, dbt);
    }
}

/**主线程-同步*/
- (void) syncInMainQueue {

    //串行主队列 (不创建新线程)
    dispatch_queue_t main_serialQueue = dispatch_get_main_queue();
    dispatch_block_t dbt = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };

    /*主队列死锁
    dispatch_sync(main_serialQueue, dbt);
     */

    /**全局并行队列异,步执行 主队列同步任务*/
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(main_serialQueue, dbt);
        DDLogInfo(@">>>主线程-同步-执行调用.");
    });
    DDLogInfo(@">>>全局并行队列异,步执行调用.");

    return;
}

/**主线程-异步*/
- (void) asyncInMainQueue {

    //串行主队列 (不创建新线程)
    dispatch_queue_t main_serialQueue = dispatch_get_main_queue();
    dispatch_block_t dbt = ^{
        //睡眠三秒
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };

    dispatch_async(main_serialQueue, dbt);
    DDLogInfo(@">>>主线程-同步-执行调用.");
    return;
}

/**串行队列-死锁

在gcd中，禁止在主队列(串行队列)中再以同步操作执行主队列任务。同理，在同一个同步串行队列中，再使用该队列同步执行任务也是会发生死锁。
1. 主队列执行同步任务
2. 串行队列同步任务中 执行当前队列的同步任务.
 (同步任务中不能再执行当前队列的同步任务)
 */
-(void)deadlockInMainQueue {

    /* 死锁案例-1
    //串行队列同步任务中 执行当前队列的同步任务.
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

    dispatch_sync(serialQueue, ^{
        //将产生死锁
        dispatch_sync(serialQueue, ^{
            [NSThread sleepForTimeInterval:2];
            DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
        });
    });
     */

    /** 死锁案例-2
     主队列死锁
        当成执行的队列即为主队列.

    dispatch_sync(dispatch_get_main_queue(), ^{
        [NSThread sleepForTimeInterval:2];
    });*/


    //死锁案例-3
    //串行队列异步任务中 执行当前队列的同步任务.
    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

    dispatch_async(serialQueue, ^{
        //创建一个新线程
        DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
        //将产生死锁,原因, 同步无法创建一个线程,将争夺异步的线程,但
        //异步线程无法释放,同步得不到线程,将一直等待,造成死锁.
        dispatch_sync(serialQueue, ^{
            [NSThread sleepForTimeInterval:2];
            DDLogInfo(@">>>串行队列同步执行-线程%@",[NSThread currentThread]);
        });

    });

}

//C函数.
void testFunc(void *context) {
    [NSThread sleepForTimeInterval:2];
    DDLogInfo(@">>>串行队列异步执行函数块-线程%@",[NSThread currentThread]);
}
/**
 函数块执行任务
 */
-(void)dispatchFunInQueue {

    dispatch_queue_t serialQueue = dispatch_queue_create("com.sherwin.serialQueue101", DISPATCH_QUEUE_SERIAL);

    int value = 10;
    dispatch_function_t work = testFunc;
    dispatch_async_f(serialQueue,&value, work);
}

#pragma mark - SH 常用操作

/**
 延时执行
 */
- (void) dispatch_after {
    dispatch_queue_t main_serialQueue = dispatch_get_main_queue();
    dispatch_block_t dbt = ^{
        //睡眠三秒
        //[NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>串行队列异步执行-线程%@",[NSThread currentThread]);
    };

    //2秒执行
    dispatch_time_t dtime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC));

    dispatch_after(dtime, main_serialQueue, dbt);
    DDLogInfo(@">>>2秒后开始执行block任务");
    return;
}

/**
 只执行一次,通常在创建单例时使用，多线程环境下也能保证线程安全
 */
-(void) gcd_dispatch_once {
    static dispatch_once_t onceToken;
    dispatch_block_t dbt = ^{
        //睡眠三秒
        //[NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>多线程任务,就执行一次-线程%@",[NSThread currentThread]);
    };


    //模似单例初使化.
    dispatch_block_t initBT = ^{

        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>执行代码任务-线程%@",[NSThread currentThread]);
        dispatch_once(&onceToken, dbt);
    };

    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);

    dispatch_async(concurrentQueue, initBT);
    dispatch_async(concurrentQueue, initBT);
    dispatch_async(concurrentQueue, initBT);
    dispatch_async(concurrentQueue, initBT);
    DDLogInfo(@">>>4次调用.");
}
/**
 会创建新的线程，并发执行

 //快速遍历方法，可以替代for循环的函数。dispatch_apply按照指定的次数将指定的任务追加到指定的队列中，并等待全部队列执行结束
 */
-(void) dispatch_apply {

    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.sherwin.concurrentQueue1", DISPATCH_QUEUE_CONCURRENT);

    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);

    dispatch_apply(20, globalQueue, ^(size_t index) {
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@">>>计数[%zu], 多线程任务并发--线程%@",index, [NSThread currentThread]);
    });

    DDLogInfo(@">>> dispatch_apply 准备开始.");

    /* */

}

#pragma mark - SH 派遣组

/** 设计思路
 
 1.任务一个一个顺序执行,后面任务依赖前面任务,  D->C  C->B
 2.多个任务执行完成,才执行某个任务,   ABC ->D
 
 >>此功能执行流程
 1.创建调度组
 2.向小组中添加工作
 3.添加完成处理任务
 4.等待任务完成执行
 5.手动管理小组任务完成状态.
 
 */

//串行列表?
- (void) dispatch_group_serialQueue {

    //1.创建队列组,  在当前主线程中创建
    dispatch_group_t group = dispatch_group_create();

    //2.创建任务的队列- 串行队列. 让任务一个一个执行.
    //dispatch_queue_t queue =  dispatch_queue_create("com.sherwin.queue12", DISPATCH_QUEUE_SERIAL);
    
    //并行队列,创建多个线程
    dispatch_queue_t queue =  dispatch_queue_create("com.sherwin.queue12", DISPATCH_QUEUE_CONCURRENT);
    

    //3. 任务块

    __block int indexNum = 1;
    dispatch_block_t dbt = ^{

        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@"----执行第[%d]个任务---当前线程%@",indexNum++, [NSThread currentThread]);
    };

    //5.开始派发, 异步执行三个任务
    dispatch_group_async(group, queue, dbt);
    dispatch_group_async(group, queue, dbt);
    dispatch_group_async(group, queue, dbt);

    
    //4.设置任务组完成通知
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{

        DDLogInfo(@"--⭕️⭕️--执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
    });
    
    //若想执行完上面的任务再走下面这行代码可以加上下面这句代码
    //等待上面的任务全部完成后，往下继续执行（会阻塞当前线程）
    //同步阻塞当前线程.
    //dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
    
    //.

    DDLogInfo(@"开始派发, 异步执行三个任务");
    return;
}


/**
 手动管理小组任务完成状态.
 */
- (void) dispatch_group_enterAndLeave {

    //1.创建队列组,  在当前主线程中创建
    dispatch_group_t group = dispatch_group_create();

    //2.创建任务的队列- 串行队列. 让任务一个一个执行.
    //dispatch_queue_t queue =  dispatch_queue_create("com.sherwin.queue12", DISPATCH_QUEUE_SERIAL);
    
    //并行队列,创建多个线程
    dispatch_queue_t queue =  dispatch_queue_create("com.sherwin.queue12", DISPATCH_QUEUE_CONCURRENT);
    

    //3. 任务块

    __block int indexNum = 0;
    dispatch_block_t dbt = ^{

        [NSThread sleepForTimeInterval:1];
        int curIndex = ++indexNum;
        DDLogInfo(@"----执行第[%d]个任务---当前线程%@",indexNum, [NSThread currentThread]);
        ;
        
        dispatch_group_enter(group);
        //假设切换到网络线程中执行网络请求
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            
            [NSThread sleepForTimeInterval:2];
            
            DDLogInfo(@"----完成 第[%d]个任务---当前线程%@",curIndex, [NSThread currentThread]);
            
            //有结果返回
            dispatch_group_leave(group);
            
        });
        //
        
    };

    
    //开启个新队列进行派发
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //4.开始派发, 异步执行三个任务
        dispatch_group_async(group, queue, dbt);
        dispatch_group_async(group, queue, dbt);
        dispatch_group_async(group, queue, dbt);

        
        //5.设置任务组完成通知
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{

            DDLogInfo(@"--⭕️⭕️--执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
        });
        
        //.等待 所有完成
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        
        DDLogInfo(@"等待队列内任务完成---当前线程%@",[NSThread currentThread]);
        
    });
    
    DDLogInfo(@"开始派发, 异步执行三个任务");
    
    return;
}

@end
