//
//  HomeView.m
//  iOSWheels
//
//  Created by liyan on 2018/5/3.
//  Copyright © 2018年 方新俊. All rights reserved.
//

#import "HomeView.h"
#import "HomeViewModel.h"

@interface HomeView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/*ViewModel*/
@property (nonatomic, strong) HomeViewModel *viewModel;
/*列表*/
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation HomeView


#pragma mark - system
- (instancetype)initWithViewModel:(BaseViewModel *)viewModel {
    
    self.viewModel = (HomeViewModel *)viewModel;
    return [super initWithViewModel:viewModel];
}



- (void)updateConstraints {
    
    WS(weakSelf)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(weakSelf);
    }];
    [super updateConstraints];
}




#pragma mark - private
- (void)mt_setupViews {
    
    [self addSubview:self.collectionView];
    
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}



- (void)mt_bindViewModel {
    //请求数据
    @weakify(self)
    [self.viewModel.refreshDataCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self)
        [self.collectionView.mj_header endRefreshing];

    }];
    
    
    [self.viewModel.nextPageCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
        @strongify(self)
        [self.collectionView.mj_footer endRefreshing];
    }];
    
    
    RACSignal *signal = [self.viewModel.refreshDataCommand execute:nil];
    RACSignal *signal2 = [self.viewModel.nextPageCommand execute:nil];
    RACSignal *reduceSignal =  [RACSignal combineLatest:@[signal, signal2]];
    [[reduceSignal reduceEach:^id(MTHTTPResponse *result, MTHTTPResponse *result2){
        return @{@"signal":result, @"signal2":result2};
    }] subscribeNext:^(id x) {
        NSLog(@"thread == %@",[NSThread currentThread]);
        NSLog(@"id === %@", x);
    }];
    
    
    [[signal deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        NSLog(@"thread == %@",[NSThread currentThread]);
        
        NSLog(@"x == %@",x);
    }];
    
}





#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, 300);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor yellowColor];
    
    return cell;
}



#pragma mark - lazyLoad

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
        flowLayout.minimumLineSpacing = 10;
        flowLayout.minimumInteritemSpacing = 10;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
        @weakify(self)
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.refreshDataCommand execute:nil];
        }];
        
        
        _collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            @strongify(self)
            [self.viewModel.nextPageCommand execute:nil];
        }];
        
    }
    return _collectionView;
}



@end
