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

class AddOrEditChecklistViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: AddOrEditChecklistViewControllerDelegate?
    
    var item: Checklist?
    
    override func viewDidLoad() {
      super.viewDidLoad()
        textField.delegate = self as? UITextFieldDelegate
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    
        @IBAction func done() {
        let checklist = Checklist(name: textField.text!)
        
        delegate!.addOrEditChecklistViewController(self, didFinishAdding: checklist)
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        print("cancel was pressed")
        delegate!.addOrEditChecklistViewControllerDidCancel(self)
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
