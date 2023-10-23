//
//  SPHornalCollectionViewController.m
//  YXBSwiftProject
//
//  Created by 蓝鳍互娱 on 2023/10/19.
//  Copyright © 2023 ShengChang. All rights reserved.
//

#import "SPHornalCollectionViewController.h"
#import "HLHorizontalPageLayout.h"


@interface SPHornalCollectionViewController () <UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) HLHorizontalPageLayout *layout;

@end

@implementation SPHornalCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    self.view.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"xxxxxxxxssas" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    cell.contentView.qmui_badgeString = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        
        CGFloat width = self.view.bounds.size.width;
        NSInteger col = 4; // 列数
        
        HLHorizontalPageLayout *layout = [[HLHorizontalPageLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        // item宽高
        CGFloat itemWidth = (width - 10 * (col-1) - layout.sectionInset.left - layout.sectionInset.right) / col;
        CGFloat itemHeight = itemWidth * 1.3;
        layout.itemSize = CGSizeMake( itemWidth, itemHeight);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, width, [layout getCollectViewHeightWithRowCount:2]) collectionViewLayout:layout];
        _collectionView.pagingEnabled = YES;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"xxxxxxxxssas"];
        _collectionView.backgroundColor = UIColor.redColor;
    }
    return _collectionView;
}

@end
