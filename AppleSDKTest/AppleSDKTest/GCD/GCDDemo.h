//
//  GCDDemo.h
//  AppleSDKTest
//
//  Created by sherwin.chen on 2020/5/28.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

/** 测试点功能

1.创建调度队列
 a.全局主队列
 b.全局并发队列 (优先级别)
 c.普通串行队列
 d.普通并行队列

2.异步执行
 a.不同队列上执行异步
 b.延时执行
 c.块任务dispatch_block_t \ 函数任务dispatch_function_t

3.同步执行
 a.不同队列上执行同步
 b.块任务dispatch_block_t \ 函数任务dispatch_function_t

4.仅执行一次任务 dispatch_once

5.并行执行任务 dispatch_apply

 //任务同步
6.派遣组
  a.创建
  b.管理

7.调度信号量

8.派头壁垒.
 
9.队列管理
 
10.任务块管理
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
任务队列: 串行 & 并行 (主队列属于串行, 合局队列属于并行)
执行方式: 同步 & 异步

 1.所有串行队列将不会创建新的线程,在串行队列中的任务将顺序执行(创建一个线程,将block块任务一个一个顺序执行)

 同步执行 & 并发队列 : 不新建线程，在当前线程中顺序执行
 异步执行 & 并发队列 : 新建多个新线程，线程会复用，无序执行
 同步执行 & 串行队列 : 在当前线程中顺序执行
 异步执行 & 串行队列 : 新建一条新的线程，在该线程中顺序执行
 异步执行 & 主队列 : 不新建线程，在主线程中顺序执行
 同步执行 & 主队列（在主线程中会crash): 主线程中会产生死锁

*/

@interface GCDDemo : NSObject
/** 1.创建调度队列 */
-(void) createKindOfQueue;

/**2.异步执行*/
-(void) dispatchAsync_a;

//2.1串行队列异步执行
-(void) asyncInSerialQueue;

/**串行同步, 不在主线程中同步执行*/
-(void) syncInSerialQueue;


/**并行异步*/
-(void) asyncInConcurrentQueue;

/**并行同步*/
-(void) syncInConcurrentQueue;

/**主线程-同步*/
- (void) syncInMainQueue ;

/**主线程-异步*/
- (void) asyncInMainQueue ;

/**串行队列-死锁*/
- (void) deadlockInMainQueue ;

/**
 函数块执行任务
 */
-(void)dispatchFunInQueue;

////////////////////
/**
 延时执行
 */
- (void) dispatch_after;

/**
 只执行一次,通常在创建单例时使用，多线程环境下也能保证线程安全
 */
-(void) gcd_dispatch_once;

/**
 会创建新的线程，并发执行
 */
-(void) dispatch_apply;

/**
 6.派遣组
 a.创建
 b.管理
 */

//队列组:当我们遇到需要异步下载3张图片，都下载完之后再拼接成一个整图的时候，就需要用到gcd队列组。
/**
 您可以聚合一组任务并同步组上的行为。您将多个块附加到一个组，并计划它们在同一队列或不同队列上异步执行。当所有块完成执行后，组将执行其完成处理程序。您也可以同步等待组中的所有块完成执行。
 */
-(void) dispatch_group_serialQueue;

- (void) dispatch_group_enterAndLeave;

/**
 7.调度信号量
 */
-(void) dispatch_semaphore;

- (void) dispatch_barrier_async;
- (void) dispatch_barrier_sync;

//9.队列管理
- (void) dispatch_queue_manager;

//10.任务块管理
- (void) dispatch_block_manager;

- (void) dispatch_block_wait;

- (void) dispatch_block_sync;

- (void) dispatch_block_async;

- (void) dispatch_block_cancel;
@end

NS_ASSUME_NONNULL_END
