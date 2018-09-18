//
//  AddEventViewController.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/17/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import UIKit

class AddEventViewController: UIViewController {

    @IBOutlet weak var txtEventName: UITextField!
    @IBOutlet weak var txtEventDecription: UITextView!
    var strDate = ""
    var isUpdate:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        txtEventDecription.layer.borderWidth = 1.0
        txtEventDecription.layer.borderColor = UIColor.black.cgColor

        txtEventDecription.addToolbar()
        txtEventName.addToolbar()
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData()
    }
    
    func refreshData() {

        if let dict = SQLiteOperations.shared.fetchDataForDate(date: strDate) {
            isUpdate = true
            if let title = dict["event_title"] as? String {
                txtEventName.text = title
            }
            
            if let title = dict["event_description"] as? String {
                txtEventDecription.text = title
            }
        }
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func buttonSaveAction(_ sender: Any) {
        
        if let title = txtEventName.text, let decsr = txtEventDecription.text, title.isEmpty == false, decsr.isEmpty == false {
            if isUpdate {
                if SQLiteOperations.shared.saveEvent(title: title, eventDescr: decsr, eventDate: strDate, isUpdate:true) {
                    showAlert(title: "Event Updated successfully!", withMessage: nil) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
            }else {
                if SQLiteOperations.shared.saveEvent(title: title, eventDescr: decsr, eventDate: strDate) {
                    showAlert(title: "Event Added successfully!", withMessage: nil) {
                        self.navigationController?.popViewController(animated: true)
                    }

                }
            }
        }else {
            showAlert(title: "All fields are mandatory", withMessage: nil) {
                if self.txtEventName.text?.isEmpty == true {
                    self.txtEventName.becomeFirstResponder()
                }
                else if self.txtEventDecription.text.isEmpty == true {
                    self.txtEventDecription.becomeFirstResponder()
                }
            }
        }
    }


}
