//
//  SecondHomeVC.swift
//  APICaller
//
//  Created by Samir Rathod on 22/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit

class SecondHomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        makelayout()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }

    func makelayout() {
        //https://makeapppie.com/2014/07/26/the-swift-swift-tutorial-how-to-use-uiviews-with-auto-layout-programmatically/
        //https://medium.com/zenchef-tech-and-product/how-to-visualize-reusable-xibs-in-storyboards-using-ibdesignable-c0488c7f525d
        
        
        // Makeview
        
        let view1 = UIView()
        view1.translatesAutoresizingMaskIntoConstraints = false
        view1.backgroundColor = UIColor.red
        
        let view2 = UIView()
        view2.translatesAutoresizingMaskIntoConstraints = false
        view2.backgroundColor = UIColor.green
        
        
        self.view.addSubview(view1)
        self.view.addSubview(view2)
        
        // AddConstraint
        
        let viewsDict = ["view1" : view1,"view2" : view2]
        
        //1 Add sizing constraint
        let view1_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[view1(50)]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: viewsDict)
        
        let view1_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[view1(50)]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: viewsDict)
        
        view1.addConstraints(view1_constraint_V)
        view1.addConstraints(view1_constraint_H)
        
        let view2_constraint_H = NSLayoutConstraint.constraints(withVisualFormat: "H:[view2(50)]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: viewsDict)
        
        let view2_constraint_V = NSLayoutConstraint.constraints(withVisualFormat: "V:[view2(<=40)]", options: NSLayoutFormatOptions.init(rawValue: 0), metrics: nil, views: viewsDict)
        
        view2.addConstraints(view2_constraint_V)
        view2.addConstraints(view2_constraint_H)
        
        
        
        //position constraints
        
        //views
        let view_constraint_H = NSLayoutConstraint.constraints(
            withVisualFormat: "H:|-[view2]",
            options: NSLayoutFormatOptions(rawValue:0),
            metrics: nil, views: viewsDict)
        let view_constraint_V = NSLayoutConstraint.constraints(
            withVisualFormat: "V:|-36-[view1]-8-[view2]-0-|",
            options: NSLayoutFormatOptions.alignAllLeading,
            metrics: nil, views: viewsDict)
        
        self.view.addConstraints(view_constraint_H)
        self.view.addConstraints(view_constraint_V)
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
