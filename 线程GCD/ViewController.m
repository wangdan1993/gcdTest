//
//  ViewController.m
//  线程GCD
//
//  Created by hisi on 2017/11/29.
//  Copyright © 2017年 hisi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UIImageView * imageView_1;
@property (nonatomic, strong) UIImageView * imageView_2;
@property (nonatomic, strong) UIImageView * imageView_3;
@property (nonatomic, strong) UIActivityIndicatorView * testIndicator;
@property (nonatomic, strong) UILabel * content;
@end

@implementation ViewController
- (UIActivityIndicatorView *)testIndicator{
    if (_testIndicator == nil) {
        self.testIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _testIndicator.center = CGPointMake(100, 100);
        [self.view addSubview:_testIndicator];
    }
    return _testIndicator;
}
- (void)viewDidLoad{
    [super viewDidLoad];


    self.content = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
    self.content.tintColor = [UIColor redColor];
    [self.view addSubview:self.content];

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)];
    [btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];


    UIButton * btn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 200, 100, 30)];
    [btn2 setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:btn2];
    [btn2 addTarget:self action:@selector(click2) forControlEvents:UIControlEventTouchUpInside];



}
- (void)click{
    self.testIndicator.hidden = NO;
    [self.testIndicator startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL * url = [NSURL URLWithString:@"http://www.youdao.com"];
        NSError * error;
        NSString * data = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (data != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.testIndicator stopAnimating];
//                self.testIndicator.hidden = YES;
                self.content.text = data;

            });
        }else{
            NSLog(@"error when doenload:%@", error);
        }
    });

}
- (void)click2{
    NSLog(@"打印2");
}
//- (void)viewDidLoad {

//    [super viewDidLoad];
//    // Do any additional setup after loading the view, typically from a nib.
//    NSLog(@"1=======%@", [NSThread currentThread]);
//    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
//        NSLog(@"2======%@", [NSThread currentThread]);
//    });
//    NSLog(@"3=======%@", [NSThread currentThread]);
//
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSLog(@"4======%@", [NSThread currentThread]);
//    });
//
////    延迟执行
////    主队列延时
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSLog(@"main_%@", [NSThread currentThread]);
//    });
////    全局队列延时
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0* NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        NSLog(@"global_%@", [NSThread currentThread]);
//    });
//
//    [self jointImageView];
//
//    dispatch_group_t group = dispatch_group_create();
//    __block UIImage * image_1 = nil;
//    __block UIImage * image_2 = nil;
//     NSData * data_1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=776127947,2002573948&fm=26&gp=0.jpg"]];
////    在group中添加一个任务
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//
//        image_1 = [UIImage imageWithData:data_1];
//
//    });
//    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        image_2 = [UIImage imageWithData:data_1];
//    });
////    group中所有任务执行完毕，通知该方法执行
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        self.imageView_1.image = image_1;
//        self.imageView_2.image = image_2;
//        NSString * text = @"好好闻😯";
//        UIGraphicsBeginImageContextWithOptions(CGSizeMake(200, 100), NO, 0.0f);
////        绘图到图形中
//        [image_2 drawInRect:CGRectMake(-30, 0, 200, 200)];
////        [image_1 drawInRect:CGRectMake(120, -220, 80, 300)];
////        添加水印文字
//        [text drawAtPoint:CGPointMake(120, 0) withAttributes:@{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:[UIFont systemFontOfSize:18]}];
//        UIImage * image_3 = UIGraphicsGetImageFromCurrentImageContext();
//        self.imageView_3.image = image_3;
//        UIGraphicsEndImageContext();
//    });
//
//
//
//}
//- (void)jointImageView{
//    self.imageView_1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 50, 100, 100)];
//    [self.view addSubview:_imageView_1];
//
//    self.imageView_2 = [[UIImageView alloc] initWithFrame:CGRectMake(140, 50, 100, 100)];
//    [self.view addSubview:self.imageView_2];
//
//    self.imageView_3 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 200, 200, 100)];
//    [self.view addSubview:self.imageView_3];
//
//    self.imageView_1.layer.borderColor = self.imageView_2.layer.borderColor = self.imageView_3.layer.borderColor = [UIColor grayColor].CGColor;
//    self.imageView_1.layer.borderWidth = self.imageView_2.layer.borderWidth = self.imageView_3.layer.borderWidth = 1;
//}
//
//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
////    保证函数在整个生命周期内只会执行一次
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSLog(@"once_%@", [NSThread currentThread]);
//    });
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
