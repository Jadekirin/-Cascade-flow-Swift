//
//  ViewController.swift
//  Swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/31.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit
import Kingfisher
class ViewController: UIViewController {
    let PhotoArray:NSMutableArray = ["http://i3.hoopchina.com.cn/blogfile/201509/24/BbsImg144310837046114_480*854.jpg"]
    override func viewDidLoad() {
        super.viewDidLoad()

        
        let _imageView = UIImageView()
        
        _imageView.backgroundColor = UIColor.red
//        for  index in 0 ..< PhotoArray.count {
        
        let url = URL.init(string: PhotoArray[0] as! String)
        let queue = DispatchQueue(label: "com.brycegao.gcdtest")
        queue.async {  //异步方法不阻塞UI
            _imageView.kf.setImage(with: url, placeholder: UIImage.init(named: "photo_2"), options: nil, progressBlock: nil, completionHandler: { (image, error, nil, imageUrl) in
                $.saveImg("Image_1", image: image, completeHandler: nil)
            })
            Thread.sleep(forTimeInterval: 1)   //停止1秒
        }
        queue.async {
            $.getImg("Image_1") { (Image) in
                let width = Image?.size.width
                let height = Image?.size.height
                _imageView.frame = CGRect.init(x: 0, y: 40, width: width!, height: height!)
      
            }
        }
    

        
        self.view.addSubview(_imageView)
        
//        }
        
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
