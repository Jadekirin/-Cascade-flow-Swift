//
//  DiskCacheHelper.swift
//  Swift--瀑布流
//
//  Created by maweilong-PC on 2017/9/6.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit


typealias $ = DiskCacheHelper

public struct DiskCacheHelper{
    /**
     本地缓存对象
     */
    static func saveObj(_ key:String,value:Any?,completeHandler:(()->())? = nil){
            DiskCache.sharedCacheObj.stroe(key, value: value, image: nil, data: nil, completeHandler: completeHandler)
    }
    /**
     本地缓存图片
     */
    static func saveImg(_ key:String,image:UIImage?,completeHandler:(()->())? = nil){
        
        DiskCache.sharedCacheImage.stroe(key, value: nil, image: image, data: nil, completeHandler: completeHandler)
        
    }
    
    /**
     本地缓存音频 或者其他 NSData类型
     */
    static func saveVoc(_ key:String,data:Data?,completeHandler:(()->())? = nil){
        
        DiskCache.sharedCacheVoice.stroe(key, value: nil, image: nil, data: data, completeHandler: completeHandler)
        
    }
    
    /**
     获得本地缓存的对象
     */
    static func getObj(_ key:String,compelete:@escaping ((_ obj:Any?)->())){
        
        DiskCache.sharedCacheObj.retrieve(key, objectGetHandler: compelete, imageGetHandler: nil, voiceGetHandler: nil)
        
    }
    
    /**
     获得本地缓存的图像
     */
    static func getImg(_ key:String,compelete:@escaping ((_ image:UIImage?)->())){
        
        DiskCache.sharedCacheImage.retrieve(key, objectGetHandler: nil, imageGetHandler: compelete, voiceGetHandler: nil)
        
    }
    
    /**
     获得本地缓存的音频数据文件
     */
    static func getVoc(_ key:String,compelete:@escaping ((_ data:Data?)->())){
        
        DiskCache.sharedCacheVoice.retrieve(key, objectGetHandler: nil, imageGetHandler: nil, voiceGetHandler: compelete)
        
    }
    
    static func achiveCache(_ key:String, compelete:@escaping ((_ bool:Bool?)->())){
        DiskCache.sharedCacheImage.IsCache(key, completeHandler: compelete)
    }
}
