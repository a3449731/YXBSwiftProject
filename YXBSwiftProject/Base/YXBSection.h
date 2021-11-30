//
//  YXBSectionController.h
//  BusProject
//
//  Created by 杨 on 2018/5/29.
//  Copyright © 2018年 杨. All rights reserved.
//

#import <IGListKit/IGListKit.h>


/**
 计算每个item宽度

 @param A 整形NSinterger,每行展示几个item
 @return cgfloat
 */
#define kItemWidthCount(A) (self.collectionContext.containerSize.width - self.inset.left - self.inset.right - self.minimumInteritemSpacing * ( A - 1)) / A

@protocol YXBSectionControllerDelegate;
@interface YXBSection : IGListSectionController

@property (nonatomic , weak) id<YXBSectionControllerDelegate> yxb_sectionDelegate;
@end

@protocol YXBSectionControllerDelegate <NSObject>

- (void)updateWithModel:(id)model sectionController:(YXBSection *)sectionController;

@end

/*
 - (instancetype)init {
     self = [super init];
     if (self)
     {
         self.inset = UIEdgeInsetsMake(0, 0, 0, 0);
         self.minimumLineSpacing = 0;
         self.minimumInteritemSpacing = 0;
         self.supplementaryViewSource = self;
     }
     return self;
 }

 - (NSInteger)numberOfItems {
     return 1;
 }

 - (CGSize)sizeForItemAtIndex:(NSInteger)index {
         return CGSizeMake(self.collectionContext.containerSize.width - self.inset.left - self.inset.right, 140);
 }

 - (UICollectionViewCell *)cellForItemAtIndex:(NSInteger)index {
     id cellClass;
     cellClass = [SPCartProductCell class];
     
     SPCartProductCell *cell =[self.collectionContext dequeueReusableCellOfClass:cellClass forSectionController:self atIndex:index];
     [cell cartGoodsStyleLayout];
     
     return cell;
 }

 - (void)didUpdateToObject:(id)object {
     
 }

 - (void)didSelectItemAtIndex:(NSInteger)index {
     
 }

 #pragma mark ----------- 头 -------------
 // 需要在 init中遵守 supplementaryViewSource 协议 。
 - (NSArray<NSString *> *)supportedElementKinds {
     return @[UICollectionElementKindSectionHeader];
 }

 - (__kindof UICollectionReusableView *)viewForSupplementaryElementOfKind:(NSString *)elementKind
                                                                  atIndex:(NSInteger)index {
     SPCartStoreReusableView *header = [self.collectionContext dequeueReusableSupplementaryViewOfKind:elementKind forSectionController:self class:[SPCartStoreReusableView class] atIndex:index];
     [header cartStoreStyleLayout];
     return header;
 }

 - (CGSize)sizeForSupplementaryViewOfKind:(NSString *)elementKind
                                  atIndex:(NSInteger)index {
     return CGSizeMake(self.collectionContext.containerSize.width, 40);
 }
 */
