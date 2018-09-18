//
//  UIViewControllerExtension.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/18/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, withMessage message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK" , style: .cancel, handler: { (action) in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlert(title: String, withMessage message: String?, completionHandler: @escaping () ->()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK" , style: .cancel, handler: { (action) in
            completionHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
}
