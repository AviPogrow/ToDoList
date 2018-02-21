//
//  ChecklistDetailViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/8/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class ChecklistDetailViewController: UITableViewController{
    
    var checklist: Checklist!
    
      override func viewDidLoad() {
        super.viewDidLoad()
        title = checklist.name
      }
    
      override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
      
     }


    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
