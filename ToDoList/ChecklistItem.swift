//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/4/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, NSCoding {
    var text = ""
    var checked = false
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
      text = aDecoder.decodeObject(forKey: "Text") as! String
      checked = aDecoder.decodeBool(forKey: "Checked")    
    }
    
    func encode(with aCoder: NSCoder) {
      aCoder.encode(text, forKey: "Text")
      aCoder.encode(checked, forKey: "Checked")
    }
    
}
