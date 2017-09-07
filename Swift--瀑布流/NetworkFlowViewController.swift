//
//  NetworkFlowViewController.swift
//  Swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/27.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

import Compression
import Kingfisher
private let FlowViewCellId = "FlowViewCellId"


class NetworkFlowViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NetWaterLayoutDataSource {
    //    var _CellLayout:UICollectionViewLayout? = nil
    var _FlowCollectionView:UICollectionView? = nil
    var _flowCell:FlowCell = FlowCell()
    let CellLayout = NetWaterLayout()
//    let _imageView:UIImageView = UIImageView()
    var HWScaleArray:[CGFloat] = []
    var ImageViewArray:[UIImage] = []
    var ImageArray:[UIImage] = []
    var PhotoArray:NSMutableArray = ["http://i3.hoopchina.com.cn/blogfile/201509/24/BbsImg144310837046114_480*854.jpg","http://i2.hoopchina.com.cn/blogfile/201507/31/BbsImg14383045063623_440*570.jpg","http://img.pconline.com.cn/images/upload/upc/tx/itbbs/1602/29/c54/18737978_1456751440578_1024x1024.jpg","http://i6.download.fd.pchome.net/t_600x1024/g1/M00/12/1C/oYYBAFbrqW6IRMu9AAGVgvNEYqMAAC4FAAzvTEAAZWa515.jpg","http://img.tupianzj.com/uploads/allimg/160817/9-160QH21433.jpg","http://bcs.91.com/pcsuite-dev/img/0/720_1280/5c99a0f49b1c26b6f576bcda2351a831.jpeg","http://img.tupianzj.com/uploads/allimg/160817/9-160QH21359.jpg","http://img.tupianzj.com/uploads/allimg/160821/9-160R1145R8.jpg","http://pic23.nipic.com/20120908/10639194_105138442151_2.jpg","http://pic41.nipic.com/20140519/18505720_094740582159_2.jpg","http://pic3.16pic.com/00/12/61/16pic_1261451_b.jpg"]
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //初始化数组
        
        self.InitData()
    }
    
    //初始化数据
//    func InitData(){
//        self.ImageViewArray.removeAll()
//        let queue = DispatchQueue(label: "com.brycegao.gcdtest")
//        $.achiveCache("imahe") { (bool) in
//            if bool! {
//                queue.async {
//                    for  index in 0 ..< self.PhotoArray.count {
//                        $.getImg("Img_\(index)", compelete: { (Image) in
//                            //                    print(Image)
//                            self.ImageViewArray.append(Image!)
//                            
//                        })
//                    }
//                    self.InitColloctionView()
//                }
//            }else{
//                queue.async {
//                    for  index in 0 ..< self.PhotoArray.count {
//                        let _imageView = UIImageView()
//                        let url = URL.init(string: self.PhotoArray[index] as! String)
//                        _imageView.kf.setImage(with: url)
//                        _imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "photo_2"), options: nil, progressBlock: nil, completionHandler: { (image, error, nil, imageUrl) in
//                            $.saveImg("Img_\(index)", image: image, completeHandler: nil)
//                            Thread.sleep(forTimeInterval: 0.2)   //停止1秒
//                            $.getImg("Img_\(index)", compelete: { (Image) in
//                                //                    print(Image)
//                                self.ImageViewArray.append(Image!)
//                                
//                            })
//                        })
//                        
//                    }
//                    Thread.sleep(forTimeInterval: 0.5)   //停止1秒
//                }
//                queue.async {
////                    for  index in 0 ..< self.PhotoArray.count {
////                        $.getImg("Img_\(index)", compelete: { (Image) in
////                            //                    print(Image)
////                            self.ImageViewArray.append(Image!)
////                        })
////                    }
//                    self.InitColloctionView()
//                }
//            }
//        }
//        
//        
//       
//        
//    }
    
    func InitData(){
        self.ImageArray.removeAll()
        let queue = DispatchQueue(label: "com.brycegao.gcdtest")
        queue.async {
           
                for  index in 0 ..< self.PhotoArray.count {
                    let _imageView = UIImageView()
                    
                    let url = URL.init(string: self.PhotoArray[index] as! String)
                    _imageView.kf.setImage(with: url)
                    _imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "photo_2"), options: nil, progressBlock: nil, completionHandler: { (image, error, nil, imageUrl) in
                        
                        self.ImageViewArray.append(image!)
//                        self.HWScaleArray.append((image?.size.height)! / (image?.size.width)!);

                        })
                }
            
                Thread.sleep(forTimeInterval: 0.1)   //停止1秒
        }
        queue.async {
            self.InitColloctionView()
        }
    }

    
    //创建UICollectionView
    func InitColloctionView(){
        
//        let CellLayout = MWLWaterLayout()
        CellLayout.minimumLineSpacing = 10
        CellLayout.minimumInteritemSpacing = 10
        CellLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        CellLayout.dataSource = self as NetWaterLayoutDataSource
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
        return PhotoArray.count
    }
    //MARK: collectionDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        _flowCell = collectionView.dequeueReusableCell(withReuseIdentifier: FlowViewCellId, for: indexPath) as! FlowCell
        _flowCell.backgroundColor = UIColor.red

        
        if ImageViewArray.count != 0 {
            _flowCell._imageView.image = ImageViewArray[indexPath.row]
            
            _flowCell.InitImageView(PhotoName: PhotoArray[indexPath.row] as! NSString,index: indexPath.row)

        }
        return _flowCell
    }
    
    
    //MARK: MWLWaterLayoutDataSource
    //获取图片的高度
    func NetwaterfallLayout(_ layout: NetWaterLayout, indexpath: IndexPath, ItemW: CGFloat) -> CGFloat {
   
        let PhotoHeight:CGFloat
        let scale:CGFloat
        if self.ImageViewArray.count == 0 {
            scale = 0
        }else{
            let Image = self.ImageViewArray[indexpath.row]
            scale = (Image.size.height) / (Image.size.width)
        }
        
        PhotoHeight = ItemW * scale
        
        return PhotoHeight
    }
    
    func numberOfColsInNetWaterfallLayout(_ layout: NetWaterLayout) -> Int {
     
        return 2
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
