//
//  FirstViewController.m
//  AppleSDKTest
//
//  Created by sherwin.chen on 2020/5/25.
//  Copyright © 2020 sherwin.chen. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) GCDTEST {
    dispatch_async(dispatch_get_main_queue(), ^{

    });

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

    });

    //dispatch_qos_class_t
}

@end
