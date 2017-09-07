//
//  CascadeFlowViewController.swift
//  Swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/24.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit
import Compression

private let FlowViewCellId = "FlowViewCellId"

class CascadeFlowViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,MWLWaterLayoutDataSource {
//    var _CellLayout:UICollectionViewLayout? = nil
    var _FlowCollectionView:UICollectionView? = nil
    var _flowCell:FlowCell = FlowCell()
    var PhotoArray:NSMutableArray = []
    
    var count = 20
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数组
        for i in 0 ..< 30 {
            let pic:NSString = NSString.init(format: "photo_%d", i)
            PhotoArray.add(pic)
            
        }
        
        self.InitColloctionView()
    }
    //创建UICollectionView
    func InitColloctionView(){
        
        let CellLayout = MWLWaterLayout()
        CellLayout.minimumLineSpacing = 10
        CellLayout.minimumInteritemSpacing = 10
        CellLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        CellLayout.dataSource = self as MWLWaterLayoutDataSource
        _FlowCollectionView = UICollectionView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), collectionViewLayout: CellLayout)
        _FlowCollectionView?.delegate = self as UICollectionViewDelegate
        _FlowCollectionView?.dataSource=self as UICollectionViewDataSource
        _FlowCollectionView?.backgroundColor = UIColor.blue
        _FlowCollectionView?.register(FlowCell.self, forCellWithReuseIdentifier: FlowViewCellId)
        self.view.addSubview(_FlowCollectionView!)
        
    }

    

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return count
    }
 //MARK: collectionDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        _flowCell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowViewCellId, for: indexPath) as! FlowCell
        _flowCell.backgroundColor = UIColor.red
        _flowCell.InitImageView(PhotoName: PhotoArray[indexPath.row] as! NSString,index: indexPath.row)
        return _flowCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: SCREEN_WIDTH/2-20, height: SCREEN_HEIGHT/2-20)
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
    
    //MARK: MWLWaterLayoutDataSource
    //获取图片的高度
    func waterfallLayout(_ layout: MWLWaterLayout, indexpath: IndexPath, ItemW:CGFloat) -> CGFloat {
        let PhotoHeight:CGFloat
        let image:UIImage = UIImage.init(named: PhotoArray.object(at: indexpath.row) as! String)!
        let imageW = image.size.width
        let imageH = image.size.height
        
        PhotoHeight = ItemW * (imageH / imageW)
        
        return PhotoHeight
    }
    
    func numberOfColsInWaterfallLayout(_ layout: MWLWaterLayout) -> Int {
        return 2
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    


}
