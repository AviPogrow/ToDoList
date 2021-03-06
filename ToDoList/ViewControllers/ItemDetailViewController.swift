//
//  ItemDetailViewController.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/21/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation

import Foundation
import UIKit

protocol ItemDetailViewControllerDelegate: class {
  func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishAdding item: ChecklistItem)
  func itemDetailViewController(_ controller: ItemDetailViewController,
                             didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController, UITextFieldDelegate {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!

    weak var delegate: ItemDetailViewControllerDelegate?
    
    var itemToEdit: ChecklistItem?
    
      override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        
        if let item = itemToEdit {
        title = "Edit Item"
        textField.text = item.text
        doneBarButton.isEnabled = true
      }
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      textField.becomeFirstResponder()
    }
    
    @IBAction func cancel() {
      delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
       if let item = itemToEdit {
       item.text = textField.text!
       delegate?.itemDetailViewController(self, didFinishEditing: item)
      
      } else {
       let item = ChecklistItem()
       item.text = textField.text!
       item.checked = false
       delegate?.itemDetailViewController(self, didFinishAdding: item)
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
