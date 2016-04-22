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
        
        //constructing the notebook
        
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
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            notebook.removeNote(indexPath.row)
        }
    }
    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let backItem = UIBarButtonItem()
        backItem.title = "Notes"
        navigationItem.backBarButtonItem = backItem // This will show in the next view controller being pushed
        
        
        if segue.identifier == "compose" {
            let vc = segue.destinationViewController as! NoteEditViewController
            vc.newNote = true
            vc.viewDidLoad()
        }
    }
    
}
