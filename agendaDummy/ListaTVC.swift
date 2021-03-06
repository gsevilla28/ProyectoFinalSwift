//
//  ListaTVC.swift
//  agendaDummy
//
//  Created by Jerry on 3/18/17.
//  Copyright © 2017 Jerry. All rights reserved.
//

import UIKit

class ListaTVC: UITableViewController {
    
    var losContactos:NSArray?

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let addButton = UIBarButtonItem(barButtonSystemItem: .Add , target: self, action: #selector(insertNewObject(_:)))
        self.navigationItem.rightBarButtonItem = addButton
        
        self.losContactos = NSArray()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
    }
    override func viewWillAppear(animated: Bool) {
        self.losContactos = DBManager.instance.encuentraTodosLos("Agenda", ordenadoPor: "String")
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.losContactos!.count
    }
    func insertNewObject(sender: AnyObject) {
        self.performSegueWithIdentifier("agregar", sender: nil)
 
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier",forIndexPath: indexPath)
        
        // Configure the cell...
        //cell.textLabel.text = (self.losContactos![indexPath.row].valueForKey("nombre") as! String)
        let elContacto = self.losContactos![indexPath.row] as! Agenda
        
        cell.textLabel!.text = elContacto.nombre
        
        return cell
    }

    
    /*override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...
        //cell.textLabel.text = (self.losContactos![indexPath.row].valueForKey("nombre") as! String)
        let elContacto = self.losContactos![indexPath.row] as! Agenda
        
        cell.textLabel!.text = elContacto.nombre
        

        return cell
    }*/
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }*/
 

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let popOverVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("sbPopUpID") as! ViewControllerDetail
        
        popOverVC.objectDetail = self.losContactos?.objectAtIndex(indexPath.row) as! Agenda
        
        
        self.addChildViewController(popOverVC)
        popOverVC.view.frame = self.view.frame
        self.view.addSubview(popOverVC.view)
        popOverVC.didMoveToParentViewController(self)

    }

    
    // MARK: - Navigation
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        /*if segue.identifier == "showDetail" {
            
            /*
            if let indexPath = self.tableView.indexPathForSelectedRow?.row {
                let elObjeto = self.losContactos?.objectAtIndex(indexPath) as! Agenda
                let destino = segue.destinationViewController as! ViewControllerDetail
                destino.objectDetail = elObjeto
                
            }*/
        }*/
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 
*/
}
