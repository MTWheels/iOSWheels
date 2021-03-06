//
//  HomeViewController.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewModel.h"
#import "HomeView.h"



@interface HomeViewController ()

/*ViewModel*/
@property (nonatomic, strong) HomeViewModel *viewModel;
/*homeView*/
@property (nonatomic, strong) HomeView *homeView;


@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    RACSignal *signal = [RACSignal never];
    
    [signal subscribeCompleted:^{
        NSLog(@"订阅完成");
    }];
    
    
    [signal subscribeNext:^(id x) {
        NSLog(@"接收订阅信息");
    }];
    
    
    [signal subscribeError:^(NSError *error) {
        NSLog(@"订阅失败。。。");
    }];
}



#pragma mark -- system Api
- (void)updateViewConstraints {
    WS(weakSelf)
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view.mas_safeAreaLayoutGuideTop);
        make.bottom.equalTo(weakSelf.view.mas_safeAreaLayoutGuideBottom);
    }];
    
    [super updateViewConstraints];
}




#pragma mark --- private
- (void)mt_addSubviews {
    [self.view addSubview:self.homeView];
    
    [NSObject mt_showAlertWithTitle:@"标题" message:@"文本玛莎拉蒂减肥凉水减肥拉伸将分类看阿里看风景辣椒粉多啦理发师的骄傲快乐撒发动机 " confirmTitle:@"确定" cancleTitle:@"取消" confirmAction:^{
        NSLog(@"确定事件");
    } cancleAction:^{
        NSLog(@"取消事件");
    }];
}


- (void)mt_bindViewModel {
    
}



#pragma mark --- getters and setters
- (HomeViewModel *)viewModel {
    if (!_viewModel) {
        _viewModel = [[HomeViewModel alloc] init];
    }
    return _viewModel;
}


- (HomeView *)homeView {
    if (!_homeView) {
        _homeView = [[HomeView alloc] initWithViewModel:self.viewModel];
        _homeView.backgroundColor = [UIColor redColor];
    }
    return _homeView;
}


- (UIView *)targetTransitionView {
    return [self.homeView.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
