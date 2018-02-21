//
//  AllListsViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/4/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

class AllListsViewController: UITableViewController,
    AddOrEditChecklistViewControllerDelegate, UINavigationControllerDelegate {
    
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //invoked by UIKit after the VC has become visible
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //VC makes itself the delegate of navController
        navigationController?.delegate = self
        
        //checks to see if vc needs to perform the segue
        let index = dataModel.indexOfSelectedChecklist
        if index >= 0 && index < dataModel.checklists.count  {
            let checklist = dataModel.checklists[index]
            //performSegue(withIdentifier: "ShowChecklist", sender: checklist)
        }
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
        let controller = segue.destination as! ChecklistDetailViewController
        controller.checklist = sender as! Checklist

        } else if segue.identifier == "AddChecklist" {
          let navigationController = segue.destination as! UINavigationController
         let controller = navigationController.topViewController as! AddOrEditChecklistViewController
         controller.delegate = self
         controller.checklistToEdit = nil
    }
  }

   
    
    //  MARK: - TableView Data Source Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return dataModel.checklists.count
    }
    
    override func tableView(_ tableView: UITableView,
                          cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
      let cell = makeCell(for: tableView)

      let checklist = dataModel.checklists[indexPath.row]
      cell.textLabel?.text = checklist.name
      cell.accessoryType = .detailDisclosureButton
      
      //TODO - fill in detail textLabel with items remaining
      //TODO = Fill in imageView with icon for tasks
     
      
    
      return cell
    }
    
 
    func makeCell(for tableView: UITableView) -> UITableViewCell {
     let cellIdentifier = "Cell"
      if let cell =
      tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
      return cell
     } else {
      return UITableViewCell(style: .subtitle,
                             reuseIdentifier: cellIdentifier)
     }
  }
    
    //  MARK: - TableView Delegate Methods
    //handle master to detail segue
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
      //user defaults stores the index of the selected row under the key "checklistindex"
      dataModel.indexOfSelectedChecklist = indexPath.row
      
      //get a reference to current checklist using indexPath.row
      let checklist = dataModel.checklists[indexPath.row]
      
      //pass the current checklist in the segue
      performSegue(withIdentifier: "ShowChecklist", sender: checklist)
      
    }
    
    //handle deletion
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.checklists.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    //handle accessoryButton tap to allow user to edit or add
    override func tableView(_ tableView: UITableView,
                          accessoryButtonTappedForRowWith indexPath: IndexPath) {
    
        let navigationController = storyboard!.instantiateViewController(
            withIdentifier: "AddOrEditChecklistNavigationController")
            as! UINavigationController
    
        let controller = navigationController.topViewController
            as! AddOrEditChecklistViewController
            controller.delegate = self
    
            let checklist = dataModel.checklists[indexPath.row]
            controller.checklistToEdit = checklist
    
            present(navigationController, animated: true, completion: nil)
        }
    
    
    
    
    
    //3 delegate methods that respond to messages sent from the AddOrEditChecklistVC
    //delegate method #1
    func addOrEditChecklistViewControllerDidCancel(_ controller: AddOrEditChecklistViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    //delegate method #2
    func addOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController, didFinishAdding checklist: Checklist) {
        
        //a. create an index:Int to point to the new row in the TableView
        let newRowIndex = dataModel.checklists.count
        //b. take the checklist object passed into the function and append it to the array
        dataModel.checklists.append(checklist)
        
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
     if let index = dataModel.checklists.index(of: checklist) {
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
    
    
    //MARK - UINavigationController Delegate Method
    //This method is invoked whenever the navController slides to a new screen
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        //was the back button tapped?
        if viewController === self {
            dataModel.indexOfSelectedChecklist = -1
        }
    }


}

