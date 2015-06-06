//
//  ViewController.m
//  动画
//
//  Created by space on 15/4/1.
//  Copyright (c) 2015年 ZYahurey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property(nonatomic,strong)NSArray *images;
@property(nonatomic)BOOL isbo;
- (IBAction)tap:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"00000" ofType:@"jpg"];
    NSArray *arr = [Path componentsSeparatedByString:@"/00000"];
    
    NSString *path = arr[0];
    NSArray *array = [fm subpathsAtPath:path];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSLog(@"%@",obj);
    }];
    self.images = array;
   
    self.imageview.frame = self.view.frame;
//     time = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    
    
//    UIPanGestureRecognizer *PanGe = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(PanGe:)];
//    PanGe.minimumNumberOfTouches = 2;
//    [self.imageview addGestureRecognizer:PanGe];
    
//    UITapGestureRecognizer *TapGe = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(TapGe:)];
//    [self.imageview addGestureRecognizer:TapGe];
    
    
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(self.view.frame.size.width/2 - 50, 200, 100, 40);
//    [btn setBackgroundImage:[UIImage imageNamed:@"AutoPlayStatus"] forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(ZZZ) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(increment == 0)
        increment = 1;
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.imageview];
    previous = touchLocation.x;
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint touchLocation = [touch locationInView:self.imageview];
    
    int location = touchLocation.x;
    
    if(location < previous)
        current += increment;
    else
        current -= increment;
    
    previous = location;
    
    [self transimage];
    
}

//-(void)PanGe:(UIPanGestureRecognizer *)pan{
//    CGPoint Point;
//    CGPoint Point2;
//    switch (pan.state) {
//            
//        case UIGestureRecognizerStateBegan:
//            if (time != nil) {
//                [time invalidate];
//                time = nil;
//            }
//            
//            Point = [pan translationInView:self.imageview];
//            
//            break;
//        case UIGestureRecognizerStateChanged:
//            Point2 = [pan translationInView:self.imageview];
//            if (Point2.x - Point.x>0) {
//                isbool = NO;
//            }else{
//                isbool = YES;
//            }
//            break;
//        case UIGestureRecognizerStateEnded:
//            if (time == nil) {
//                time = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(timer) userInfo:nil repeats:YES];
//            }
//            break;
//            
//    }
//}


//-(void)ZZZ{
//    if (time == nil) {
//    time = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(timer) userInfo:nil repeats:YES];
//    }
//}

-(void)timer{
    if (isbool) {
        current-= increment;
    }else{
        current+= increment;;
    }
    [self transimage];
}

-(void)transimage{
    
    if(current > 150)
        current = 0;
    if(current < 0)
        current = 150;
    
    
    NSString *imagestr = self.images[current];
    UIImage *img = [UIImage imageNamed:imagestr];
    
    self.imageview.image = img;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)tap:(id)sender {
    if (!self.isbo) {
        if (time == nil) {
            time = [NSTimer scheduledTimerWithTimeInterval:.05 target:self selector:@selector(timer) userInfo:nil repeats:YES];
            self.isbo = YES;
        }
    }else{
        [time invalidate];
        time = nil;
        self.isbo = NO;
    }
    

}
@end
