//
//  AllNotesViewTableViewController.swift
//  Notes
//
//  Created by Ronak Shah on 4/19/16.
//  Copyright © 2016 Shah Industries. All rights reserved.
//

import UIKit

class AllNotesViewTableViewController: UITableViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notebook.refreshData()
        //adding an edit bar button
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Test Code Only
        return notebook.size()
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // #warning Test Code Only
        
        let cell = tableView.dequeueReusableCellWithIdentifier("noteCell", forIndexPath: indexPath) as! NoteTableViewCell
        
        // Configure the cell...
        let note = notebook.getNote(indexPath.row)
        cell.noteNameLabel.text = note.title
        cell.noteLastEditDateLabel.text = note.lastEditDate()
        cell.selectionStyle = .None
        
        return cell
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            notebook.removeNote(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Notes"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        
        if segue.identifier == "compose" {
            let vc = segue.destinationViewController as! NoteEditViewController
            vc.newNote = true
            //tvc.viewDidLoad()
        }
 
        if segue.identifier == "edit" {
            let vc = segue.destinationViewController as! NoteEditViewController
            vc.newNote = false
            vc.currentNote = notebook.getNote((self.tableView.indexPathForSelectedRow?.row)!)
            //vc.viewDidLoad()
        }
    }
    
}
