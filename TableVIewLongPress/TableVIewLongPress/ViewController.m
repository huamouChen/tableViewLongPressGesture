//
//  ViewController.m
//  TableVIewLongPress
//
//  Created by hayman on 2018/10/15.
//  Copyright © 2018 hayman. All rights reserved.
//

#import "ViewController.h"
#import "CHMTableViewController.h"

@interface ViewController ()
@property (nonatomic, strong) CHMTableViewController *chmTableViewController;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *view = self.chmTableViewController.view;
    view.frame = CGRectMake(50, [UIScreen mainScreen].bounds.size.height - 350, 300, 300);
    [self.view addSubview:view];
    
    [self addChildViewController:self.chmTableViewController];
    
}


- (CHMTableViewController *)chmTableViewController {
    if (!_chmTableViewController) {
        _chmTableViewController = [CHMTableViewController new];
    }
    return _chmTableViewController;
}


@end
