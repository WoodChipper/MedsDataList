//
//  AddMedViewController.swift
//  Meds v2
//
//  Created by Don Gordon on 11/21/16.
//  Copyright © 2016 DGsolutions. All rights reserved.
//

import UIKit

class AddMedViewController: UIViewController {

    @IBOutlet weak var medNameTextField: UITextField!
    @IBOutlet weak var pillDosageTextField: UITextField!
    @IBOutlet weak var pillsPerDayTextField: UITextField!
    @IBOutlet weak var pillsPerBottleTextField: UITextField!
    @IBOutlet weak var pillTakenInMorningTextField: UITextField!
    @IBOutlet weak var pillTakenInEveningTextField: UITextField!
    @IBOutlet weak var pillTakenAtBedtimeTextField: UITextField!
    @IBOutlet weak var websiteURLTextField: UITextField!
    @IBOutlet weak var notesTextView: UITextView!
    @IBOutlet weak var dateStartedTextField: UITextField!
    @IBOutlet weak var dateStoppedTextField: UITextField!
    @IBOutlet weak var isCurrentlyTakenSwitch: UISwitch!
    
    
    // create array for holding coredata data (records)
    var meds : [Med] = []
    
    // This is sent from List View Contorller
    var medName: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // get the data from Core Data
        getData()
        
//        let med = meds[0]
//        medNameTextField.text = med.medName!
//        
//        pillDosageTextField.text = med.pillDosage
//        pillsPerDayTextField.text = med.pillsPerDay
//        pillsPerBottleTextField.text = med.pillsPerBottle
//        pillTakenInMorningTextField.text = med.pillsInMorning
//        pillTakenAtBedtimeTextField.text = med.pillsAtBedtime
//        pillTakenInEveningTextField.text = med.pillsInEvening
//        websiteURLTextField.text = med.webSiteURL
//        notesTextView.text = med.notes
//        //        dateStartedTextField.text = String(med.dateStarted)
//        //        dateStoppedTextField.text = String(med.dateStopped)
//        isCurrentlyTakenSwitch.isOn = med.isCurrentlyTaken
//
    }

    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        if (medNameTextField.text?.isEmpty)! {
            print("IS EMPTY")
            return
        }
        
        // create delegate for Core Data
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // get ref to CoreData entity
        let med = Med(context: context)
        
        // Now with entity, set coreData values from UI screen
        med.medName = medNameTextField.text
        med.pillDosage = pillDosageTextField.text
        med.pillsPerDay = pillsPerDayTextField.text
        med.pillsPerBottle = pillsPerBottleTextField.text
        med.pillsInMorning = pillTakenInMorningTextField.text
        med.pillsInEvening = pillTakenInEveningTextField.text
        med.pillsAtBedtime = pillTakenAtBedtimeTextField.text
        med.webSiteURL = websiteURLTextField.text
        med.notes = notesTextView.text
        med.isCurrentlyTaken = isCurrentlyTakenSwitch.isOn
        //        med.dateStarted = NSDate(dateStartedTextField.text)
        //        med.dateStopped = NSData(dateStoppedTextField.text)
        
        
        // Save the data to coredatea
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        
        // Go back to my list (first view, by popping off the current view)
        navigationController!.popViewController(animated: true)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        // Go back to my list (first view, by popping off the current view)
        navigationController!.popViewController(animated: true)
    }
    
    
    // Core Data...
    func getData() {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do {
            meds = try context.fetch(Med.fetchRequest())
        }
        catch {
            print("Fetching Failed")
        }
    }
    
    
//  ====================================================================
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
