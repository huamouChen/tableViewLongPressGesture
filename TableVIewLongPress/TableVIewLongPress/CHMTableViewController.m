//
//  CHMTableViewController.m
//  TableVIewLongPress
//
//  Created by hayman on 2018/10/15.
//  Copyright © 2018 hayman. All rights reserved.
//

#import "CHMTableViewController.h"
#import "AppDelegate.h"

@interface CHMTableViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic)  UIView *popView;


@end

@implementation CHMTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return arc4random() % 50 + 40;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    UILongPressGestureRecognizer *longPressGest = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showPopViewWithLongGesture:)];
    longPressGest.minimumPressDuration = 1.5;
    [cell addGestureRecognizer:longPressGest];
    
    cell.textLabel.text = [NSString stringWithFormat:@"This is %zd row", indexPath.row];
    return cell;
}


- (void)showPopViewWithLongGesture:(UILongPressGestureRecognizer *)longPressGesture {
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        
        
        
        /*
          Y 值得计算方式， 拿到点击位置的最后一个superView(size大小为屏幕大小即可)，这样就可以拿到屏幕中的绝对点的位置，
         然后获得点击再cell中的Y值， 用屏幕的绝对位置 减去 cell位置的Y值，即可得到在cell 顶部的Y值，最后减去弹框的高度，刚好可以
         让弹框位于cell的顶部。
         
         */
        
        
        UIView *tableView = longPressGesture.view.superview;
        UIView *targetView = tableView.superview;
        UIView *targetView2 = targetView.superview;
        NSLog(@"location view class is %@", targetView2);
        
        
        
        CGPoint location = [longPressGesture locationInView:targetView2];
        NSLog(@"location  y is %f", location.y);
        
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        
        UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        [delegate.window.rootViewController.view addSubview:maskView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPopItemView)];
        [maskView addGestureRecognizer:tap];
        
        
        CGFloat locationY = [longPressGesture locationInView:longPressGesture.view].y;
        
        
        // 位置 减去弹框的高度20， 再减去cell 的一半高度
        CGFloat popItemViewY = location.y - 30 - locationY;
        UIView *popItemView = [[UIView alloc] initWithFrame:CGRectMake(50, popItemViewY, 100, 30)];
        popItemView.backgroundColor = [UIColor redColor];
        [maskView addSubview:popItemView];
        
        self.popView = maskView;
        
        
        
        
        
        
        
    }
}

- (void)dismissPopItemView {
    [self.popView removeFromSuperview];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
