//
//  ViewController.m
//  ObjcDemo
//
//  Created by 黄东鸿 on 2024/1/27.
//

#import "ViewController.h"

struct Struct0 {
    int c;
}s0;

struct Struct1 {
    double a;
    char b;
    int c;
    short d;
}s1;

struct Struct3 {
    double a;           // 8    [0，7]
    int b;              // 4    [8，11]
    char c;             // 1    [12]
    short d;            // 2    (13, [14，15]
    int e;              // 4    [16, 19]
    struct Struct3_1 {
        double a;       // 8    (20, 21, 22, 23, [24, 31]
        char b;         // 1    [32]
        int c;          // 4    (33, 34, 35 [36, 39]
        short d;        // 2    [40, 41]，42, 43, 44, 45, 46, 47, 48
    }s1;
}s3;

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 内存字节对齐
    printf("Struct1 size: %lu\n", sizeof(s0));  // 输出 4
    printf("Struct1 size: %lu\n", sizeof(s1));  // 输出 24
    printf("Struct1 size: %lu\n", sizeof(s3));  // 输出 48
}


@end
