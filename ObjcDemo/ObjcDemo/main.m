//
//  main.m
//  ObjcDemo
//
//  Created by 黄东鸿 on 2024/1/27.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "JFPerson.h"

//int main(int argc, char * argv[]) {
//    NSLog(@"Hello world.");
//
//    JFPerson *p = [[JFPerson alloc] init];
//
//    return 0;
//}



int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

//extern void _objc_autoreleasePoolPrint(void);
//
//int main(int argc, char * argv[]) {
//
//    NSObject *a = [[NSObject alloc] init];
//    _objc_autoreleasePoolPrint();
//
//    JFPerson *p = [[JFPerson alloc] init];
//    _objc_autoreleasePoolPrint();
//
//    JFPerson *b = [p retObj];
//    JFPerson *c = [JFPerson retObj];
//    _objc_autoreleasePoolPrint();
//
//    return 0;
//}
    
//int main(int argc, char * argv[]) {
//
////    __block int a = 10;
////    NSLog(@"1 --> %p", &a);
////    void (^block)(void) = ^{
////        NSLog(@"2 --> %p", &a);
////    };
////    NSLog(@"3 --> %p", &a);
////    block();
//
////    NSObject * obj  = [NSObject alloc];
////    void (^ block)(void) = ^{
////        NSLog(@"----%@",obj);
////    };
////    block();
//
//    int a = 10;
//    void (^ block)(void) = ^{
//        NSLog(@"----%d",a);
//    };
//    block();
//
//    return 0;
//}

//int global_i = 1;
//
//static int static_global_j = 2;

//int main(int argc, const char * argv[]) {
//
//    static int static_k = 3;
//    int val = 4;
//
//    void (^myBlock)(void) = ^{
//        global_i ++;
//        static_global_j ++;
//        static_k ++;
//        NSLog(@"Block中 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
//    };
//
//    global_i ++;
//    static_global_j ++;
//    static_k ++;
//    val ++;
//    NSLog(@"Block外 global_i = %d,static_global_j = %d,static_k = %d,val = %d",global_i,static_global_j,static_k,val);
//
//    myBlock();
//
//    return 0;
//}

//int main(int argc, const char * argv[]) {
//
//    NSMutableString * str = [[NSMutableString alloc]initWithString:@"Hello,"];
//
//    void (^myBlock)(void) = ^{
//        [str appendString:@"World!"];
//        NSLog(@"Block中 str = %@",str);
//    };
//
//    NSLog(@"Block外 str = %@",str);
//
//    myBlock();
//
//    return 0;
//}

//int main(int argc, const char * argv[]) {
//
//    __block int i = 0;
//    NSLog(@"这是Block 外面 %p",&i);
//
//    void (^myBlock)(void) = ^{
//        i++;
//        NSLog(@"这是Block 里面 %p",&i);
//    };
//
//    NSLog(@"myBlock = %@", myBlock);
//    myBlock();
//
//    return 0;
//}

//int main(int argc, const char * argv[]) {
//
//    __block id block_obj = [[NSObject alloc]init];
//    id obj = [[NSObject alloc]init];
//
//    NSLog(@"block_obj = [%@ , %p] , obj = [%@ , %p]",block_obj , &block_obj , obj , &obj);
//
//    void (^myBlock)(void) = ^{
//        NSLog(@"----Block中----block_obj = [%@ , %p] , obj = [%@ , %p]",block_obj , &block_obj , obj , &obj);
//    };
//
//    myBlock();
//
//    return 0;
//}

