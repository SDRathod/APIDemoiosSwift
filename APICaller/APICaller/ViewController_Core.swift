//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Samir Rathod on 19/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    @IBOutlet weak var tblObj: UITableView!
    var peoples : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "List view"
        tblObj.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //1
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        // get DB using managedContext
        let managedContext = appdelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest  = NSFetchRequest<NSManagedObject>(entityName: "Person")
        
        do {
            peoples = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("could not fetch record.\(error.userInfo)")
        }
    }

    @IBAction func btnAddClick(_ sender: Any) {
        
        let alert = UIAlertController(title: "New Name",
                                      message: "Add a new name",
                                      preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) {
                                        [unowned self] action in
                                        
                                        guard let textField = alert.textFields?.first,
                                            let nameToSave = textField.text else {
                                                return
                                        }
                                        self.save(name: nameToSave)
                                        self.tblObj.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .default)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func save(name: String) {
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        
        let managedContext = appdelegate.persistentContainer.viewContext
        
        // 2
        let entity = NSEntityDescription.entity(forEntityName: "Person", in: managedContext)
        let person = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            peoples.append(person)
        } catch let error as NSError {
            print("Could not save, \(error),\(error.userInfo)")
        }
    }
}

// Mark - UITableViewDataSource

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let person = peoples[indexPath.row]
        let cell = tblObj.dequeueReusableCell(withIdentifier: "Cell", for:indexPath)
        cell.textLabel?.text = person.value(forKeyPath: "name") as? String
        return cell;
    }
}
