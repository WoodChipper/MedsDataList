//
//  ViewController.swift
//  Meds v2
//
//  Created by Don Gordon on 11/21/16.
//  Copyright © 2016 DGsolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    // create array for holding coredata data (records)
    var meds : [Med] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // allways needed for TableView controller
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // Display fetched data in view
    override func viewWillAppear(_ animated: Bool) {
        // get the data from Core Data
        getData()
        
        // reload the table view
        tableView.reloadData()
    }
    
    // One of Two functions for TableView protocols
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meds.count
    }
    
    // Second function needed for TableView protocols
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        let med = meds[indexPath.row]
        
        cell.textLabel?.text = med.medName!
        return cell
    }
    
    // Two functions to send current row to Detail screen
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: meds[indexPath.row].medName)
    }
    // Second of two functions to send row to Detail screen
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            let guest = segue.destination as! DetailViewController
            // This 'medName' referrs           print(sender as! Int)
            guest.medName = sender as! String
        }
    }
    
    //  Core Data fetch
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            meds = try context.fetch(Med.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    //  Delete current row
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        if editingStyle == .delete {
            let med = meds[indexPath.row]
            context.delete(med)
            (UIApplication.shared.delegate as! AppDelegate).saveContext()
            
            do {
                meds = try context.fetch(Med.fetchRequest())
            }
            catch {
                print("Fetching Failed")
            }
        }
        tableView.reloadData()
    }
    
    
    //  ===================================================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

