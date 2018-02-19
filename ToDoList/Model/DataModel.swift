//
//  DataModel.swift
//  ToDoList
//
//  Created by Macbook Pro on 2/9/18.
//  Copyright © 2018 Macbook Pro. All rights reserved.
//

import Foundation

//Define  the new DataModel object
//It will take over responsiblilites for loading and saving the to do lists
// from the AllListsViewController
class DataModel {
    
    //give it a checklists property to hold array of [Checklist]
    var checklists = [Checklist]()
    
    //make sure that as soon as dataModel object is created, it will attempt to
    //load checklist.plist
    init() {
        loadChecklists()
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
        
        archiver.encode(checklists, forKey: "Checklists")
        
        archiver.finishEncoding()
            data.write(to: dataFilePath(), atomically: true)
     }
    
    // this method is now called loadChecklists()
    func loadChecklists() {
        let path = dataFilePath()
        if let data = try? Data(contentsOf: path) {
        let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
        // this line is different from before
        checklists = unarchiver.decodeObject(forKey: "Checklists") as! [Checklist]
        unarchiver.finishDecoding()
      }
        
    }
}
