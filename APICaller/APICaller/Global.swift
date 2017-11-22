//
//  Global.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class Global {

    
    // MARK: -  Shared classes
    static let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    static let singleton = Singleton.sharedSingleton
    
    // MARK: -  Screen size
    static let screenWidth : CGFloat = (Global.appDelegate.window!.bounds.size.width)
    static let screenHeight : CGFloat = (Global.appDelegate.window!.bounds.size.height)

    // MARK: -  Web service Base URL
    //static let baseURLPath = "http://topsdemo.co.in/webservices/chilax_app/public/api/v1/"
    static let baseURLPath = "http://chilax.com/chilax_app_v3/public/api/v1/"
    static let GoogleKey = "AIzaSyBw38tA0YLvlql-z3IrW3PNfvX-l9HKSPc"
    static let placeAPI = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input="
    // MARK: -  Application Name
    static let kAppName = "chilax"
    
    // MARK: -  Application Fonts
    struct kFont {
        static let GothamBold = "Gotham-Bold"
        static let GothamBook = "Gotham-Book"
        static let GothamRegular = "Gotham-Regular"
        static let GothamMedium = "Gotham-Medium"
        static let GothamLight = "Gotham-Light"
        static let ChilaxIcon = "Chilax"
        static let ChilaxNewIcon = "Chillax_TOPS"
    }

    static func getDocumentDirectoryPath() -> URL {
        
        let fileManager = FileManager.default
        let documentsUrl = fileManager.urls(for: .documentDirectory,
                                            in: .userDomainMask)
        guard documentsUrl.count != 0 else {
            return URL.init(string: "")!// Could not find documents URL
        }
        return documentsUrl.first!
    }
    

    static func isFileExistInDocumentDir(strFileName:String) -> Bool {
        
        let documentsURL = try! FileManager().url(for: .documentDirectory,in: .userDomainMask,appropriateFor: nil,create: true)
        let fooURL = documentsURL.appendingPathComponent(strFileName)
        return FileManager().fileExists(atPath: fooURL.path)
    }
    
}
