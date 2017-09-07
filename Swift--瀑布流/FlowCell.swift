//
//  FlowCell.swift
//  swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/24.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit
//typealias ImageWHBlock = (_ scale:CGFloat) -> Void

class FlowCell: UICollectionViewCell {
    var _imageView:UIImageView = UIImageView()
    
    var imageScaleBlock: ((_ scale:CGFloat, _ index:NSInteger) -> ())?
    var scale :CGFloat = 0.0
    func InitImageView(PhotoName:NSString,index:NSInteger){
        
        
        let IsUrl:Bool = verifyUrl(str: PhotoName as String)
        _imageView.frame = CGRect.init(x: 0, y: 0, width: self.layer.bounds.size.width, height: self.layer.bounds.size.height)
        if IsUrl {
            
            
            
        }else{
            
            _imageView.image = UIImage.init(named: PhotoName as String)
            
        }
        self.addSubview(_imageView)
    }
    
    func NetImageView(ImageView:UIImageView){
        var _imageView:UIImageView = UIImageView()
        _imageView.frame = CGRect.init(x: 0, y: 0, width: self.layer.bounds.size.width, height: self.layer.bounds.size.height)
        _imageView = ImageView
        self.addSubview(_imageView)
    }
    
    /**
     验证URL格式是否正确
     */
    private func verifyUrl(str:String) -> Bool {
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector .matches(in: str,
                                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                                    range: NSMakeRange(0, str.characters.count))
            // 判断结果(完全匹配)
            if res.count == 1  && res[0].range.location == 0
                && res[0].range.length == str.characters.count {
                return true
            }
        }
        catch {
            print(error)
        }
        return false
    }
}
