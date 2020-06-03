//
//  FirstViewController.m
//  AppleSDKTest
//
//  Created by sherwin.chen on 2020/5/25.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

/** 参考资料
1. https://github.com/MrTung/GCD_Demo

 */

#import "FirstViewController.h"
#import "GCDDemo.h"

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong) GCDDemo *mGCDDemo;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.mGCDDemo = [[GCDDemo alloc] init];

    return;
}

- (IBAction)Action4ValueChanged:(UISegmentedControl *)sender {

    NSInteger viewTag = sender.tag;
    NSInteger tagVal  = sender.selectedSegmentIndex;

    if(viewTag == 0){

        if (tagVal == 1) {

            [self.mGCDDemo dispatchAsync_a];
        }
        else if(tagVal ==2){
            [self.mGCDDemo asyncInSerialQueue];
        }
        else if(tagVal ==3){
            [self.mGCDDemo syncInSerialQueue];
        }
        else if(tagVal ==4){
            [self.mGCDDemo asyncInConcurrentQueue];
        }
        else if(tagVal ==5){
            [self.mGCDDemo syncInConcurrentQueue];
        }

    }
    else if(viewTag == 1) {

        if (tagVal == 1) {

            [self.mGCDDemo syncInMainQueue];
        }
        else if(tagVal ==2){
            [self.mGCDDemo asyncInMainQueue];
        }
        else if(tagVal ==3){
            [self.mGCDDemo deadlockInMainQueue];
        }
        else if(tagVal ==4){
            [self.mGCDDemo dispatchFunInQueue];
        }
    }
    else if(viewTag == 2) {

        if (tagVal == 1) {

            [self.mGCDDemo dispatch_after];
        }
        else if(tagVal ==2){
            [self.mGCDDemo gcd_dispatch_once];
        }
        else if(tagVal ==3){
            [self.mGCDDemo dispatch_apply];
        }
        else if(tagVal ==4){
            [self.mGCDDemo dispatchFunInQueue];
        }

    }
    
}



#pragma mark - SH TableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 400;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell"];

    return cell;
}




@end
