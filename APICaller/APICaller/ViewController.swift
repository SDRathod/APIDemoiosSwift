//
//  ViewController.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class ViewController: UIViewController, DetailVCDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        //self.LoginCall()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let peopleObj = People()
//        peopleObj.strNmae = "Samir"
//        peopleObj.strDesig = "iosDeveloper"
//        
//        if( self.InsertPeopleObjectintoDatabase(people: [peopleObj])){
//            print("record inserted");
//        }
//        else{
//           print("record not inserted"); 
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailVC" {
            let detailObj = segue.destination as! DetailVC
            detailObj.delegate = self
        }
    }
    
    //MARK: - LocalDB Insert BULK
    func InsertPeopleObjectintoDatabase(people: [People]) -> Bool {
        
        let success = DBManager.sharedInstance.addPeopleContact(toDbRegionArray: people, toTable: "EmpMaster")
        return success;
        
    }
    func saveImage(avtarData: NSData, name: String) -> String{
        let paths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let documentsDirectory = paths[0]
        let currentDateTime = NSDate()
        let formatter = DateFormatter()
        formatter.dateFormat = "ddMMyyyy-HHmmss"
        var recordingName:String = ""
        recordingName = formatter.string(from: currentDateTime as Date) + "\(name)" + ".png"
        let savedImagePath = documentsDirectory + "/" + recordingName
        avtarData.write(toFile: savedImagePath, atomically: false)
        return recordingName
    }
    
    func getImage(named: String) ->String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let getImagePath = documentsDirectory + "/" + named
        //let url:NSURL = NSURL(string: getImagePath)!
        return getImagePath
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
    
    func passDatawhenBackClick(arrdata: [String]) {
        print("delegate array print = \(arrdata)")
    }

}

//extension ViewController : DetailVCDelegate {
//    func passDatawhenBackClick(arrdata: [String]) {
//        print("delegate array print = \(arrdata)")
//    }
//}

