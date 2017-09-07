//
//  MWLWaterLayout.swift
//  swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/24.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

protocol MWLWaterLayoutDataSource:class{
    func waterfallLayout(_ layout:MWLWaterLayout,indexpath:IndexPath, ItemW:CGFloat) -> CGFloat
    func numberOfColsInWaterfallLayout(_ layout:MWLWaterLayout) -> Int
}
class MWLWaterLayout: UICollectionViewFlowLayout {
    //MARK: 对外提供属性
    weak var dataSource : MWLWaterLayoutDataSource?
    //MARK: 私有属性
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var attrsArray1: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var totalHeight : CGFloat = 0
    fileprivate lazy var colHeights: [CGFloat] = {
        //cols 列数
        let cols = self.dataSource?.numberOfColsInWaterfallLayout(self) ?? 2
        // 创建一个，元素值重复，个数 count 固定的数组
        //colheights cell Y值的数组
        var colHeights = Array.init(repeating: self.sectionInset.top, count: cols)
        return colHeights
        
    }()
    
    fileprivate var maxH :CGFloat = 0
    fileprivate var startIndex = 0
    fileprivate var ItemWidth = 0
}

extension MWLWaterLayout{
    //prepare 准备所有cell的布局样式
    override func prepare() {
        super.prepare()
        attrsArray.removeAll()
        
        startIndex = 0
        //0 获取item的个数
        let itemCount = collectionView?.numberOfItems(inSection: 0)
        
        //1 获取列数
        let cols = dataSource?.numberOfColsInWaterfallLayout(self) ?? 2
        colHeights = Array.init(repeating: self.sectionInset.top, count: cols)
        //2 计算Item的宽度
        let itemW = ((collectionView?.bounds.width)! - self.sectionInset.left - self.sectionInset.right - self.minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        self.ItemWidth = Int(itemW)
        //3 计算所有item的属性
        for i in startIndex ..< itemCount! {
            //1 设置每一个item位置相关的属性
            let indexPath = IndexPath.init(item: i, section: 0)
            
            //2 根据位置创建Attributes属性
            let atts = UICollectionViewLayoutAttributes.init(forCellWith: indexPath)
            
            //3 随机一个高度
          //  和if一样，guard是基于一个表达式的布尔值去判断某些代码是否该被执行，和if不一样的地方是，guard只有在条件不满足（布尔值==false时）才会执行，类似反if。
            guard let height = dataSource?.waterfallLayout(self, indexpath: indexPath,ItemW: itemW) else {
                fatalError("请设置数据源")
            }
            
            //4 取出最小列的值
            var minH = colHeights.min()!
            let index = colHeights.index(of: minH)!
            minH = minH + height + minimumLineSpacing
            colHeights[index] = minH
            
            //5 设置item的属性
            atts.frame = CGRect.init(x: self.sectionInset.left + (self.minimumInteritemSpacing + itemW) * CGFloat(index), y: minH - height - self.minimumLineSpacing, width: itemW, height: height)
            attrsArray.append(atts)
            
        }
               //4 记录最大值
        maxH = colHeights.max()!
        
        //5 给startIndex重新赋值
        startIndex = itemCount!
        
        
    }

}

extension MWLWaterLayout{
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize:CGSize{
        //获取视图滑动的最大范围Y
        return CGSize.init(width: 0, height: maxH + sectionInset.bottom - minimumLineSpacing)
    }
    
    
}


