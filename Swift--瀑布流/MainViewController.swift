//
//  MainViewController.swift
//  Swift--瀑布流
//
//  Created by maweilong-PC on 2017/7/27.
//  Copyright © 2017年 maweilong. All rights reserved.
//

import UIKit

let cellId:NSString = "cellId"

class MainViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var dataSources = ["本地图片瀑布流","网络图片瀑布流","测试"]
    var VCdataArr = ["CascadeFlowViewController","NetworkFlowViewController","ViewController"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "首页"
        let _tabelView:UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .plain)
        _tabelView.delegate = self
        _tabelView.dataSource = self
        
        _tabelView.register(UITableViewCell().classForCoder, forCellReuseIdentifier: cellId as String)
        
        self.view.addSubview(_tabelView)
        
        
        
        
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSources.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId as String, for: indexPath)
        cell.textLabel?.text = dataSources[indexPath.row] as String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if indexPath.row == 0 {
//            
//            let VC = CascadeFlowViewController()
//            VC.title = dataSources[indexPath.row]
//            self.navigationController?.pushViewController(VC, animated: true)
//            
//        }else if indexPath.row == 1{
//            let VC = NetworkFlowViewController()
//            VC.title = dataSources[indexPath.row]
//            self.navigationController?.pushViewController(VC, animated: true)
//        }
        
        let targetVC = VCdataArr[indexPath.row] as String
        /**
         * 如果你的工程名字中带有“-” 符号  需要加上 replacingOccurrences(of: "-", with: "_") 这句代码把“-” 替换掉  不然还会报错 要不然系统会自动替换掉 这样就不是你原来的包名了 如果不包含“-”  这句代码 可以不加
         */
        let APPName = getAPPName().replacingOccurrences(of: "-", with: "_")
        let ClassName:NSString = APPName + "." + targetVC as NSString
        
        guard let Cls = NSClassFromString(ClassName as String)! as? UIViewController.Type  else{
            NSLog("无法转换成UITableViewController")
            return
        }

        let VC:UIViewController = Cls.init()
        VC.title = dataSources[indexPath.row]
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    //获取包名
    func getAPPName() -> String{
        let nameKey = "CFBundleName"
        let appName = Bundle.main.object(forInfoDictionaryKey: nameKey) as? String   //这里也是坑，请不要翻译oc的代码，而是去NSBundle类里面看它的api
        return appName!
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
