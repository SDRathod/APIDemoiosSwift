//
//  ViewController.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        self.LoginCall()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func LoginCall() {

        let param : NSMutableDictionary = NSMutableDictionary()
        param.setValue("samchilax", forKey: "email")
        param.setValue("123456", forKey: "password");
        param.setValue("1", forKey: "device_type")
        param.setValue("", forKey: "device_id")
        
        AFAPIMaster.sharedAPIMaster.postLoginCall_Completion(params: param, showLoader: true, enableInteraction: true, viewObj: self.view) { (returnData : Any) in
            
            let dictResponse: NSDictionary = returnData as! NSDictionary
            let dictData : NSDictionary = dictResponse.object(forKey: "data") as! NSDictionary
            
            print("dictData=\(dictData)")
            
            
        }
        
        
        
        
        
    }

}

