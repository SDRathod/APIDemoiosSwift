//
//  ViewController.swift
//  AlamofireAPI
//
//  Created by Samir Rathod on 28/11/17.
//  Copyright © 2017 Samir Rathod. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeGetCallWithAlamofire()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
            }

    func makeGetCallWithAlamofire() {
        let todoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(todoEndpoint)
            .responseJSON { response in
                // check for errors
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling GET on /todos/1")
                    print(response.result.error!)
                    return
                }
                
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    func makePostCallWithAlamofire() {
        let todosEndpoint: String = "https://jsonplaceholder.typicode.com/todos"
        let newTodo: [String: Any] = ["title": "My First Post", "completed": 0, "userId": 1]
        Alamofire.request(todosEndpoint, method: .post, parameters: newTodo,
                          encoding: JSONEncoding.default)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /todos/1")
                    print(response.result.error!)
                    return
                }
                // make sure we got some JSON since that's what we expect
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                // get and print the title
                guard let todoTitle = json["title"] as? String else {
                    print("Could not get todo title from JSON")
                    return
                }
                print("The title is: " + todoTitle)
        }
    }
    
    func makeDeleteCallWithAlamofire() {
        let firstTodoEndpoint: String = "https://jsonplaceholder.typicode.com/todos/1"
        Alamofire.request(firstTodoEndpoint, method: .delete)
            .responseJSON { response in
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling DELETE on /todos/1")
                    if let error = response.result.error {
                        print("Error: \(error)")
                    }
                    return
                }
                print("DELETE ok")
        }
    }
}
