//
//  TextFieldExtension.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/18/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func addToolbar(){
        self.inputAccessoryView = getToolBar()
    }
}

extension UITextView {
    
    func addToolbar(){
        self.inputAccessoryView = getToolBar()
    }
}


extension UIView {
    func getToolBar() -> UIToolbar {
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.black
        toolBar.tintColor = UIColor.white
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(buttonDoneAction))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.sizeToFit()
        return toolBar
    }
    
    @objc func buttonDoneAction(){
        self.endEditing(true)
    }
}
