//
//  DetailVC.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//https://blog.grandcentrix.net/creating-uitableviewcells-with-dynamic-height-based-upon-auto-layout-constraints-with-ios-8/
//https://www.ralfebert.de/snippets/ios/auto-layout-recipes/layout-constraints-for-tableview-cell-height/

import UIKit

protocol DetailVCDelegate {
    func passDatawhenBackClick(arrdata : [String])
}

class ExampleCell : UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    
}

class DetailVC: UIViewController {

    @IBOutlet weak var tblObj: UITableView!
    var delegate : DetailVCDelegate?
    
    var arrObj = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tblObj.rowHeight = UITableViewAutomaticDimension
        self.tblObj.estimatedRowHeight = 44
        
        for i in 0 ..< 30  {
            arrObj.append(Array(repeating: "Lorem Ipsum is an example text.", count: i).joined(separator: " "))
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.delegate?.passDatawhenBackClick(arrdata: arrObj)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 

}

extension DetailVC : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblObj.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ExampleCell
        cell.nameLabel.text = "Row \(indexPath.row + 1) \(arrObj[indexPath.row])"
        cell.detailsLabel.text = arrObj[indexPath.row]
        return cell
    }
}
