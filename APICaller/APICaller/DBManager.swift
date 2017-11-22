//
//  DBManager.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit
import FMDB
class People : NSObject {
    var id: Int = 0
    var strNmae : String = ""
    var strDesig : String = ""
}

class DBManager: NSObject {

    static let sharedInstance = DBManager(withDBName: "Employee")
    
    
    var dbPath : NSURL!
    var DatabasePAth:String!
    var database : FMDatabase!
    var queryResults : FMResultSet?
    var arrObjects:[String: AnyObject] = [:]
    
    init(withDBName: String) {
        _ = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        DatabasePAth = docsDir + "/" + withDBName+".db"
        
        //  DatabasePAth = Bundle.main.path(forResource: "\(withDBName)", ofType: ".db")!
        let db = FMDatabase(path: DatabasePAth)
        print("DB Open From Path......=== \(DatabasePAth)")
        if !(db?.open())! {
            print("Unable to open database, some random error happened.")
        }
        else {
            database = db
        }
    }
    
    /// Sets the dbPath and the database member variables
    /// - parameters:
    ///      - dbName (String): The name of the DB. Uses a constant defined in strings.swift
    func getDatabase(dbName : String) -> Bool {
        _ = FileManager.default
        let dirPaths =
            NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                .userDomainMask, true)
        let docsDir = dirPaths[0]
        DatabasePAth = docsDir + "/" + dbName+".db"
        //DatabasePAth = Bundle.main.path(forResource: "\(dbName)", ofType: ".db")!
        let db = FMDatabase(path: DatabasePAth)
        if !(db?.open())! {
            print("Unable to open database, some random error happened.")
        }
        else {
            database = db
            return true
        }
        return false
    }
    
    ///Closes the connection to the class database
    func closeDatabase() -> Void {
        database.close()
    }

    
    // MARK: -  Add loader in view
    func addShowLoaderInView(viewObj: UIView, boolShow: Bool, enableInteraction: Bool) -> UIView? {
        let viewSpinnerBg = UIView(frame: CGRect(x: (Global.screenWidth - 54.0) / 2.0, y: (Global.screenHeight - 54.0) / 2.0, width: 54.0, height: 54.0))
        viewSpinnerBg.backgroundColor = UIColor.gray
        viewSpinnerBg.layer.masksToBounds = true
        viewSpinnerBg.layer.cornerRadius = 5.0
        viewObj.addSubview(viewSpinnerBg)
        
        if boolShow {
            viewSpinnerBg.isHidden = false
        }
        else {
            viewSpinnerBg.isHidden = true
        }
        
        if !enableInteraction {
            viewObj.isUserInteractionEnabled = false
        }
        
        //add spinner in view
//        let rtSpinKitspinner: RTSpinKitView = RTSpinKitView(style: RTSpinKitViewStyle.styleFadingCircle , color: UIColor.white)
//        rtSpinKitspinner.center = CGPoint(x: (viewSpinnerBg.frame.size.width - 8.0) / 2.0, y: (viewSpinnerBg.frame.size.height - 8.0) / 2.0)
//        rtSpinKitspinner.color = Global.kAppColor.Blue
//        rtSpinKitspinner.startAnimating()
//        viewSpinnerBg.addSubview(rtSpinKitspinner)
        
        return viewSpinnerBg
    }
    
    
    // MARK: -  Hide and remove loader from view
    func hideRemoveLoaderFromView(removableView: UIView, mainView: UIView) {
        removableView.isHidden = true
        removableView.removeFromSuperview()
        mainView.isUserInteractionEnabled = true
    }
    
    
    func GetMaxContactMasterLocalId(table:String) -> Int {
        if !database.open() {
            return 0
        }
        database.beginTransaction()
        
        let strQuery = "Select max(local_unique_id) from \(table)"
        var strr : Int = 0
        if let results = database.executeQuery(strQuery, withArgumentsIn: nil) {
            queryResults = nil
            while (results.next()) {
                queryResults = results
                strr = Int(results.int(forColumn: "max(local_unique_id)"))
            }
            results.close()
        }
        database.commit()
        database.close()
        return strr
    }

    func addPeopleContact(toDbRegionArray arrData: [People], toTable:String) -> Bool {
        
        if !database.open() {
            return false
        }
        
        for person in arrData {
            
            database.beginTransaction()
            let insertSQL:String = "INSERT INTO \(toTable)(name,designation) values('fist','ios developer')"
            print(insertSQL)
            _ = database.executeUpdate(insertSQL,
                                       withArgumentsIn: nil)
            
            database.commit()
            database.close()
        }
        
        return true
    }
    
    func DeleteIDFromDB(id:Int, tblNAme:String) -> Bool {
        if database == nil {
            print("Error: No database created")
            return false
        }
        if database.open() {
            let insertSQL = "UPDATE \(tblNAme) set is_delete = '1' WHERE user_id = '\(id)'"
            let result = database.executeUpdate(insertSQL,
                                                withArgumentsIn: nil)
            if !result {
                print("Error: \(database.lastErrorMessage())")
                
                return false
            } else {
                
                return true
            }
        }
        
        return false
    }
    
    
    func delete(arrIDS: [String], toTable:String) -> Bool {
        if !database.open() {
            return false
        }
        database.beginTransaction()
        for person in arrIDS {
            //let query = "delete from phonebook_master where contact_id = \(person)"
            //let result = database.executeQuery(query, withParameterDictionary: nil)
            
            let querySQL = "DELETE FROM \(toTable) where 'contact_id' = \(person)"
            let result = database.executeQuery(querySQL, withArgumentsIn: nil)
            if !(result != nil) {
                print("Error: \(database.lastErrorMessage())")
                return false
            } else {
                return true
            }
            
        }
        database.commit()
        database.close()
        return true
    }
    
    func SearchcomparingAllContacts(tblName:String) -> [String]?
    {
        var arrstr:[String] = []
        if database == nil {
            print("Error: No database created")
            return nil
        }
        
        if database.open() {
            
            let querySQL = "SELECT * FROM \(tblName)"
            if let results = database.executeQuery(querySQL, withArgumentsIn: nil) {
                queryResults = nil
                while (results.next()) {
                    queryResults = results
                    let id = results.int(forColumn: "contact_id")
                    arrstr.append( "\(id)")
                    
                }
                results.close()
                return arrstr
            }
        }
        else {
            
            return nil
        }
        
        return nil
    }
    
    // MARK: -  UPDATE Contact Master
    
    func UpdateContactFromDB(id:Int, tblNAme:String, localUniqueId:Int) -> Bool {
        if database == nil {
            print("Error: No database created")
            return false
        }
        if database.open() {
            let insertSQL = "UPDATE \(tblNAme) set user_id = \(id) WHERE  localid = '\(localUniqueId)'"
            let result = database.executeUpdate(insertSQL,
                                                withArgumentsIn: nil)
            if !result {
                print("Error: \(database.lastErrorMessage())")
                return false
            } else {
                return true
            }
        }
        return false
    }

}
