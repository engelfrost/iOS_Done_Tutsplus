//
//  ViewController.swift
//  Done
//
//  Created by Wojtek on 8/12/14.
//  Copyright (c) 2014 Wojtek. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    var selection: NSIndexPath!
    var managedObjectContext: NSManagedObjectContext!
    var fetchedResultsController: NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize Fetch Request
        var request: NSFetchRequest = NSFetchRequest(entityName: "Item")
        
        // Add Sort Descriptor
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: false)]
        
        // Initialize Fetched Results Controller
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        // Configure Fetched Results Controller
        self.fetchedResultsController.delegate = self
        
        // Perform Fetch
        var error: NSErrorPointer = NSErrorPointer()
        self.fetchedResultsController.performFetch(error)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController!) {
        self.tableView.endUpdates()
    }
    
    func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
        switch (type) {
        case NSFetchedResultsChangeType.Insert: self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Delete: self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        case NSFetchedResultsChangeType.Update: self.configureCell(self.tableView.cellForRowAtIndexPath(indexPath), atIndexPath: indexPath)
        case NSFetchedResultsChangeType.Move:   self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                                                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        return self.fetchedResultsController.sections.count
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
        var sections: NSArray = self.fetchedResultsController.sections
        var sectionInfo: NSFetchedResultsSectionInfo = sections.objectAtIndex(section) as NSFetchedResultsSectionInfo
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("ToDoCell", forIndexPath: indexPath) as UITableViewCell
        self.configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Store Selection
        self.selection = indexPath
        
        // Perform Segue
        self.performSegueWithIdentifier("updateToDoViewController", sender: self)
    }
    
    func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
        var record: NSManagedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as NSManagedObject
        cell.textLabel.text = record.valueForKey("name") as String
        cell.detailTextLabel.text = (record.valueForKey("createdAt") as NSDate).description
        if (record.valueForKey("done") as Bool) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if (segue.identifier == "addToDoViewController") {
            var nc: UINavigationController = segue.destinationViewController as UINavigationController
            var vc: AddToDoViewController = nc.topViewController as AddToDoViewController
            vc.managedObjectContext = self.managedObjectContext
        } else if (segue.identifier == "updateToDoViewController") {
            var vc: UpdateToDoViewController = segue.destinationViewController as UpdateToDoViewController
            vc.managedObjectContext = self.managedObjectContext
            
            if (self.selection != nil) {
                var record: NSManagedObject = self.fetchedResultsController.objectAtIndexPath(self.selection) as NSManagedObject
                vc.record = record
            }
            
            self.selection = nil
            
        }
    }

}

