//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/4/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController, AddOrEditChecklistViewControllerDelegate {
    
    //array to hold checklist object
    var lists =  [Checklist]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //3 delegate methods that respond to messages sent from the AddOrEditChecklistVC
    func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController, didFinishAdding checklist: Checklist) {
        
        //a. create an index:Int to point to the new row in the TableView
        let newRowIndex = lists.count
        //b. take the checklist object passed into the function and append it to the array
        lists.append(checklist)
        
        //c. create an indexPath object
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        //d. wrap the indexPath in an array [indexPath]
        let indexPaths = [indexPath]
        //e. add the row to the tableView
        tableView.insertRows(at: indexPaths, with: .automatic)
        //f. dismiss the AddOrEditChecklistVC
        dismiss(animated: true, completion: nil)
        
    }
    
    func AddOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController, didFinishEditing checklist: Checklist) {
     //a. take the checklist object passed into the function and find its index in the array
     if let index = lists.index(of: checklist) {
      //b. create an indexPath to tell the tableView where to put the row
      let indexPath = IndexPath(row: index, section: 0)
      //c. get the cell associated with the row at the indexPath
        if let cell = tableView.cellForRow(at: indexPath) {
         //d. get the name property of the current checklist and use it to set
         // the textLabel on the tableViewCell
          cell.textLabel?.text = checklist.name
        }
    }
    dismiss(animated: true, completion: nil)
   }


}

