//
//  AddOrEditChecklistViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/5/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import UIKit

protocol AddOrEditChecklistViewControllerDelegate: class {
  func addOrEditChecklistViewControllerDidCancel(_ controller: AddOrEditChecklistViewController )
  
  func addOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController,
                                didFinishAdding checklist: Checklist)
  
  func addOrEditChecklistViewController(_ controller: AddOrEditChecklistViewController,
                                didFinishEditing checklist: Checklist)
}

class AddOrEditChecklistViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddOrEditChecklistViewControllerDelegate?
    
    var checklistToEdit: Checklist?
    
    override func viewDidLoad() {
      super.viewDidLoad()
      
      if let checklist = checklistToEdit {
        title = "Edit Checklist"
        textField.text = checklist.name
        
        doneBarButton.isEnabled = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
      delegate!.addOrEditChecklistViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
       if let checklist = checklistToEdit {
            checklist.name = textField.text!
            delegate!.addOrEditChecklistViewController(self, didFinishAdding: checklistToEdit!)
        
        } else {
          let checklist = Checklist(name: textField.text!)
          delegate!.addOrEditChecklistViewController(self, didFinishAdding: checklist)
        }
     }
    
    override func tableView(_ tableView: UITableView,
                          willSelectRowAt indexPath: IndexPath) -> IndexPath? {
      return nil
    }
  
    func textField(_ textField: UITextField,
                 shouldChangeCharactersIn range: NSRange,
                 replacementString string: String) -> Bool {
    
    
      let oldText = textField.text! as NSString
      let newText = oldText.replacingCharacters(in: range, with: string) as NSString
    
      doneBarButton.isEnabled = (newText.length > 0)
      return true
  }
}
