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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "AddChecklist" {
        let navigationController = segue.destination as! UINavigationController
        let controller = navigationController.topViewController as! AddOrEditChecklistViewController
        controller.delegate = self
      
      } else if segue.identifier == "EditChecklist" {
          let navigationController = segue.destination as! UINavigationController
          let controller = navigationController.topViewController as! AddOrEditChecklistViewController
          controller.delegate = self
          //get the current indexPath
          if let indexPath = tableView.indexPath(for: sender as! UITableViewCell)
          {
            controller.checklistToEdit = lists[indexPath.row]
        }
      }
    }
   
    
    //  MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return lists.count
    }
    
    override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

      let checklist = lists[indexPath.row]
      let textLabel1 = cell.viewWithTag(101) as! UILabel
      textLabel1.text = checklist.name
      
     
      configureCheckmark(for: cell, with: checklist)
    
      return cell
    }
    
 
    func configureCheckmark(for cell: UITableViewCell,
                            with item: Checklist) {
        let label = cell.viewWithTag(1001) as! UILabel
        if item.checked {
            label.text = "√"
        } else {
            label.text = ""
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
         let checklist = lists[indexPath.row]
         checklist.toggleCheckedState()
         configureCheckmark(for: cell, with: checklist)
        }
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    //  MARK: - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        lists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //3 delegate methods that respond to messages sent from the AddOrEditChecklistVC
    //delegate method #1
    func addOrEditChecklistViewControllerDidCancel(_ controller: AddOrEditChecklistViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //delegate method #2
    func addOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController, didFinishAdding checklist: Checklist) {
        
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
    
    //delegate method #3
    func addOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController, didFinishEditing checklist: Checklist) {
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
    
    //MARK - Persistance
    func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDirectory().appendingPathComponent("Checklist.plist")
    }
    
    func saveChecklists() {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        
        archiver.encode(lists, forKey: "Checklists")
        
        archiver.finishEncoding()
            data.write(to: dataFilePath(), atomically: true)
     }
    
    // this method is now called loadChecklists()
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        // this line is different from before
        lists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
        unarchiver.finishDecoding()
      }
        
    }

}

