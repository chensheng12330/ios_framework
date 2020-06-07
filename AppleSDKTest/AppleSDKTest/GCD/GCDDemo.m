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
 并行队列,可异步创建多条线程运行,(一个任务对印一条线程)
 
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
    
    for (int i=0; i<10; i++) {
        dispatch_async(global_concurrent_queue, dbt);
    }
    
    
    return;
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

/**
 信号量
 
 作用:可用于控制并行队列并发线程的数量

 
 //总结:信号量设置的是2，在当前场景下，同一时间内执行的线程就不会超过2，先执行2个线程，等执行完一个，下一个会开始执行。
 
 步骤:
 1.创建
 2.发信号
 3.等待

 */

-(void) dispatch_semaphore {
    
    //信号量设置的是2
    dispatch_semaphore_t st = dispatch_semaphore_create(2);
    
    dispatch_queue_t queue = dispatch_queue_create("com.sherwin.semaphore.1", DISPATCH_QUEUE_CONCURRENT);
    
    __block int indexNum=0;
    dispatch_block_t bt = ^(){
        
        int tempNum = indexNum++;
        //吃掉一个信号量
        dispatch_semaphore_wait(st, DISPATCH_TIME_FOREVER); //30s超时时间
        DDLogInfo(@"----开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
        DDLogInfo(@"----结束执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
        
        //释放一个信号量
        long nSeNum = dispatch_semaphore_signal(st); //完成信号量
        //DDLogInfo(@"当前可使用信号总数:%ld",nSeNum);
    };
    
    //模似某个信号超时
    dispatch_block_t bt_timeout = ^(){
        
        int tempNum = indexNum++;
        //吃掉一个信号量
        dispatch_semaphore_wait(st, DISPATCH_TIME_FOREVER); //30s超时时间
        DDLogInfo(@"----开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
        [NSThread sleepForTimeInterval:30];
        DDLogInfo(@"----结束执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
        
        //释放一个信号量
        long nSeNum = dispatch_semaphore_signal(st); //完成信号量
        //DDLogInfo(@"当前可使用信号总数:%ld",nSeNum);
    };
    
    
    for (int i=0; i<10; i++) {

        if (i == 6) {
            dispatch_async(queue, bt_timeout);
        }
        else {
            
            dispatch_async(queue, bt);
        }
        
    }
    /**/
}

/**
 派送壁垒-栅栏-异步
 在并发调度队列中执行的任务的同步点.
 
 在障碍块完成之前，不会执行任何在障碍块之后提交的块。
 */
- (void) dispatch_barrier_async {
    //异步
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    __block int indexNum=0;
    dispatch_block_t db = ^(){
        int tempNum = indexNum++;
       
        [NSThread sleepForTimeInterval:2];
        
        DDLogInfo(@"----开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
    };
    
    
    dispatch_block_t db_ba = ^(){
        int tempNum = indexNum++;
       
        DDLogInfo(@"---壁垒,执行10s");
        [NSThread sleepForTimeInterval:10];
        
        DDLogInfo(@"---壁垒,执行10s-开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
    };
    
    
    for (int i=0; i<10; i++) {
        
        if(i==5){
            DDLogInfo(@"主线程派发开始");
            dispatch_barrier_async(queue, db_ba);
            DDLogInfo(@"主线程派发结束");
        }
        else {
            dispatch_async(queue, db);
        }
    }
    
    
    return;
}

/**
 同步创建障碍,会阻塞当前派发的线程.直到线程执行完成,
 将屏障块提交给调度队列以进行同步执行。
 不同于，此功能直到屏障块完成后才返回。
 调用此函数并以当前队列为目标会导致死锁
 */

- (void) dispatch_barrier_sync {
    //异步
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    __block int indexNum=0;
    dispatch_block_t db = ^(){
        int tempNum = indexNum++;
       
        [NSThread sleepForTimeInterval:2];
        
        DDLogInfo(@"----开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
    };
    
    
    dispatch_block_t db_ba = ^(){
        int tempNum = indexNum++;
       
        DDLogInfo(@"---壁垒,执行10s");
        [NSThread sleepForTimeInterval:10];
        
        DDLogInfo(@"---壁垒,执行10s-开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
    };
    
    
    for (int i=0; i<10; i++) {
        
        if(i==5){
            DDLogInfo(@"主线程派发开始");
            dispatch_barrier_sync(queue, db_ba);
            DDLogInfo(@"主线程派发结束");
        }
        else {
            dispatch_async(queue, db);
        }
    }
    
    
    return;
}

/**
 该函数等待直到指定的时间，然后异步添加block到指定的queue。
 
 场景：当追加大量处理到Dispatch Queue时，在追加处理的过程中，有时希望不执行已追加的处理。例如演算结果被Block截获时，一些处理会对这个演算结果造成影响。在这种情况下，只要挂起Dispatch Queue即可。当可以执行时再恢复。

 
 总结:dispatch_suspend，dispatch_resume提供了“挂起、恢复”队列的功能，简单来说，就是可以暂停、恢复队列上的任务。但是这里的“挂起”，
 
 并不能保证可以立即停止队列上正在运行的任务，也就是如果挂起之前已经有队列中的任务在进行中，那么该任务依然会被执行完毕, 从实用上考虑,只 针对串行队列使用 较好.
 */
- (void) dispatch_queue_manager {
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);  //DISPATCH_QUEUE_CONCURRENT
    
     __block int indexNum=0;
    
    dispatch_block_t bt = ^{
        
        int tempNum = indexNum++;
        // 执行第一个任务
        [NSThread sleepForTimeInterval:2];
        
        DDLogInfo(@"----开始执行第[%d]个任务---当前线程%@",tempNum,[NSThread currentThread]);
        
    };
    
    for (int i=0; i<10; i++) {
        dispatch_async(queue, bt);
    }
    
    //2秒后需要挂起队列
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //[NSThread sleepForTimeInterval:0.5];
        
        /**
         通过挂起调度对象，您的应用程序可以暂时阻止执行与该对象关联的任何块。在调用时运行的所有块完成后，将发生挂起。调用此函数将增加对象的挂起计数，然后调用将其减少。当计数大于零时，对象将保持挂起状态，因此您必须使每个调用与匹配的调用保持平衡

         恢复对象后，将交付提交到调度队列的任何块或调度源观察到的事件。
         */
        DDLogInfo(@">>>>挂起调度对象");
        dispatch_suspend(queue);
        
        //解决问题,
        [NSThread sleepForTimeInterval:6];
        
        /**
         调用此函数将减少挂起的调度队列或调度事件源对象的挂起计数。当计数大于零时，对象将保持挂起状态。当挂起计数恢复为零时，将提交提交到调度队列的任何块或调度源在挂起时观察到的任何事件。
         */
        dispatch_resume(queue);
        DDLogInfo(@">>>> 恢复调度对象");
        
    });
    
    
}

/**
 调度工作项封装了要在调度队列或调度组内执行的工作。您还可以将工作项用作调度源事件，注册或取消处理程序。
 

 DISPATCH_BLOCK_ASSIGN_CURRENT
 设置工作项的属性以匹配当前执行上下文的属性。

 DISPATCH_BLOCK_BARRIER
 使工作项在提交到并发队列时充当屏障块。

 DISPATCH_BLOCK_DETACHED
 取消工作项的属性与当前执行上下文的关联。

 DISPATCH_BLOCK_ENFORCE_QOS_CLASS
 首选与该块关联的服务质量类。

 DISPATCH_BLOCK_INHERIT_QOS_CLASS
 首选与当前执行上下文关联的服务质量类。

 DISPATCH_BLOCK_NO_QOS_CLASS
 执行工作项，而不分配服务质量等级
 */

- (void) dispatch_block_manager {
    
    //1. 创建工作任务.
    dispatch_block_t dbt = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        
        DDLogInfo(@"----开始执行任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
    });
    
    /*
     
    //从指定的块和标志创建，同步执行和释放调度块
    dispatch_block_perform(DISPATCH_BLOCK_ASSIGN_CURRENT, dbt);
     */
    
    //2.添加完成处理程序
    
    dispatch_queue_t queue = dispatch_queue_create("com.block.manager.01", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t callBlock = ^(){
        DDLogInfo(@"任务执行完成.---当前线程%@",[NSThread currentThread]);
    };
    
    /**
     如果观察到的块对象的执行已经完成，则此函数立即提交通知块。

     使用此接口不可能通知同一块对象的多次执行。而是使用此功能。dispatch_group_notify

     单个分发块可以被观察一次或多次并执行一次，也可以执行任意次。任何其他组合的行为均未定义。即使使用该功能取消意味着该块的代码从不运行，向调度队列的提交也被视为执行。dispatch_block_cancel

     如果为单个块对象调度了多个通知块，则没有定义的顺序将通知块提交到它们的关联队列。
     */
    dispatch_block_notify(dbt, queue, callBlock);
    
    //3.执行
    //延迟执行工作项, 同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。
    //会阻塞当前线程
    dispatch_block_wait(dbt, 5);
    
    //4.同步执行
    
    //5.异步执行
    
    //6.取消
    
}

- (void) dispatch_block_wait{
    //1. 创建工作任务.
    dispatch_block_t dbt = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        
        DDLogInfo(@"----开始执行任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:9];
    });
    
    /*
     
    //从指定的块和标志创建，同步执行和释放调度块
    dispatch_block_perform(DISPATCH_BLOCK_ASSIGN_CURRENT, dbt);
     */
    
    //2.添加完成处理程序
    
    dispatch_queue_t queue = dispatch_queue_create("com.block.manager.01", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t callBlock = ^(){
        DDLogInfo(@"任务执行完成.---当前线程%@",[NSThread currentThread]);
    };
    
    /**
     如果观察到的块对象的执行已经完成，则此函数立即提交通知块。

     使用此接口不可能通知同一块对象的多次执行。而是使用此功能。dispatch_group_notify

     单个分发块可以被观察一次或多次并执行一次，也可以执行任意次。任何其他组合的行为均未定义。即使使用该功能取消意味着该块的代码从不运行，向调度队列的提交也被视为执行。dispatch_block_cancel

     如果为单个块对象调度了多个通知块，则没有定义的顺序将通知块提交到它们的关联队列。
     */
    dispatch_block_notify(dbt, queue, callBlock);
    
    //3.执行
    //延迟执行工作项, 同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。
    //会阻塞当前线程
    
    dispatch_async(queue, dbt);
    
    dispatch_time_t timeout = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC));
    dispatch_block_wait(dbt, timeout);
    //
    DDLogInfo(@"内容执行完成");
}

- (void) dispatch_block_sync{
    //1. 创建工作任务.
    dispatch_block_t dbt = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        
        DDLogInfo(@"----开始执行任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
    });
    
    /*
     
    //从指定的块和标志创建，同步执行和释放调度块
    dispatch_block_perform(DISPATCH_BLOCK_ASSIGN_CURRENT, dbt);
     */
    
    //2.添加完成处理程序
    
    dispatch_queue_t queue = dispatch_queue_create("com.block.manager.01", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t callBlock = ^(){
        DDLogInfo(@"任务执行完成.---当前线程%@",[NSThread currentThread]);
    };
    
    /**
     如果观察到的块对象的执行已经完成，则此函数立即提交通知块。

     使用此接口不可能通知同一块对象的多次执行。而是使用此功能。dispatch_group_notify

     单个分发块可以被观察一次或多次并执行一次，也可以执行任意次。任何其他组合的行为均未定义。即使使用该功能取消意味着该块的代码从不运行，向调度队列的提交也被视为执行。dispatch_block_cancel

     如果为单个块对象调度了多个通知块，则没有定义的顺序将通知块提交到它们的关联队列。
     */
    dispatch_block_notify(dbt, queue, callBlock);
    
    //3.执行
    //延迟执行工作项, 同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。
    //会阻塞当前线程
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_sync(queue, dbt);
        DDLogInfo(@"内容执行完成");
    });
    
    return;
}

- (void) dispatch_block_async{
    //1. 创建工作任务.
    dispatch_block_t dbt = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        
        DDLogInfo(@"----开始执行任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:3];
    });
    
    /*
     
    //从指定的块和标志创建，同步执行和释放调度块
    dispatch_block_perform(DISPATCH_BLOCK_ASSIGN_CURRENT, dbt);
     */
    
    //2.添加完成处理程序
    
    dispatch_queue_t queue = dispatch_queue_create("com.block.manager.01", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_block_t callBlock = ^(){
        DDLogInfo(@"任务执行完成.---当前线程%@",[NSThread currentThread]);
    };
    
    /**
     如果观察到的块对象的执行已经完成，则此函数立即提交通知块。

     使用此接口不可能通知同一块对象的多次执行。而是使用此功能。dispatch_group_notify

     单个分发块可以被观察一次或多次并执行一次，也可以执行任意次。任何其他组合的行为均未定义。即使使用该功能取消意味着该块的代码从不运行，向调度队列的提交也被视为执行。dispatch_block_cancel

     如果为单个块对象调度了多个通知块，则没有定义的顺序将通知块提交到它们的关联队列。
     */
    dispatch_block_notify(dbt, queue, callBlock);
    
    //3.执行
    //延迟执行工作项, 同步等待，直到指定的调度块的执行完成或指定的超时时间结束为止。
    //会阻塞当前线程
    //dispatch_block_wait(dbt, 5);
    
    dispatch_async(queue, dbt);
    DDLogInfo(@"内容执行完成");
}

/**
 取消会使调度块的任何将来执行立即返回，但不影响已经在进行的块对象的任何执行。
 与该块对象相关联的任何资源的释放都将延迟，直到下一次尝试执行该块对象（或已在进行的任何执行完成）为止。
 */
- (void) dispatch_block_cancel{
    
    //1. 创建工作任务.
    dispatch_block_t dbt = dispatch_block_create(DISPATCH_BLOCK_ASSIGN_CURRENT, ^{
        
        DDLogInfo(@"--将要 被 取消的线程--开始执行任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:10];
    });
    
    /*
     
    //从指定的块和标志创建，同步执行和释放调度块
    dispatch_block_perform(DISPATCH_BLOCK_ASSIGN_CURRENT, dbt);
     */
    
    //2.添加完成处理程序
    
    dispatch_queue_t queue = dispatch_queue_create("com.block.manager.01", DISPATCH_QUEUE_SERIAL);
    
    dispatch_block_t callBlock = ^(){
        DDLogInfo(@"任务执行完成.---当前线程%@",[NSThread currentThread]);
    };
    
    /**
     如果观察到的块对象的执行已经完成，则此函数立即提交通知块。

     使用此接口不可能通知同一块对象的多次执行。而是使用此功能。dispatch_group_notify

     单个分发块可以被观察一次或多次并执行一次，也可以执行任意次。任何其他组合的行为均未定义。即使使用该功能取消意味着该块的代码从不运行，向调度队列的提交也被视为执行。dispatch_block_cancel

     如果为单个块对象调度了多个通知块，则没有定义的顺序将通知块提交到它们的关联队列。
     */
    dispatch_block_notify(dbt, queue, callBlock);
    
    //3.执行
    for (int i=0; i<5; i++) {
        dispatch_async(queue, ^(){
            DDLogInfo(@"----开始执行任务---当前线程%@",[NSThread currentThread]);
            [NSThread sleepForTimeInterval:3];
        });
    }
    
    dispatch_async(queue, dbt);
    
    //模似取消
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:3];
        
        dispatch_block_cancel(dbt);
        DDLogInfo(@"----取消任务 %@ ---当前线程%@",dbt, [NSThread currentThread]);
    });
}

@end
