//
//  EventListTableViewCell.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/18/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import UIKit

class EventListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    
    var strDate: String = "" {
        didSet {
            lblDate.text = strDate
            lblTitle.text = ""
            if let dict = SQLiteOperations.shared.fetchDataForDate(date: strDate) {
                lblTitle.text = dict["event_title"] as? String
            }
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
