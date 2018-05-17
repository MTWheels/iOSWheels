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
