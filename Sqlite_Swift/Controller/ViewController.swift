//
//  ViewController.swift
//  Snapwork_Assignment
//
//  Created by webwerks on 9/17/18.
//  Copyright © 2018 Pradeep. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnYear: UIButton!
    @IBOutlet weak var btnMonth: UIButton!
    
    var currentYear:Int = 0
    var currentSelectedYear:Int = 0
    var currentSelectedMonth:Int = 0
    let currentDate:Date = Date()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentYear = currentDate.currentYear()
        updateTitles(month: currentDate.currentMonthName(), year: "\(currentYear)")
        
        tblView.register(UINib(nibName: "EventListTableViewCell", bundle: nil), forCellReuseIdentifier: "EventListTableViewCell")

        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tblView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateTitles(month: String?, year:String?) {
        if let mnth = month {
            btnMonth.setTitle("Month\n\(mnth)", for: .normal)
            let months = currentDate.monthList()
            currentSelectedMonth = months.index(of: mnth)!+1

        }
        
        if let yr = year {
            btnYear.setTitle("Year\n\(yr)", for: .normal)
            currentSelectedYear = Int(yr)!
        }
        
        tblView.reloadData()

    }

    @IBAction func buttonYearAction(_ sender: Any) {
        presentSheet(type: 2, aryData: currentDate.yearList())
        
    }
    
    @IBAction func buttonMonthAction(_ sender: Any) {
        presentSheet(type: 1, aryData: currentDate.monthList())
    }
    
}


extension ViewController {

    func presentSheet(type: Int, aryData:[String]) {
        let strType = type == 1 ? "Month" : "Year"
        let actionSheet: UIAlertController = UIAlertController(title: "Please select \(strType)", message: nil, preferredStyle: .actionSheet)

        for i in 0..<aryData.count {
            
            let action = UIAlertAction(title: aryData[i], style: .default) { (action) in
                if let title = action.title {
                    print(title)
                    if type == 1 {
                        self.updateTitles(month: title, year: nil)
                    }else {
                        self.updateTitles(month: nil, year: title)
                    }

                }
            }
            actionSheet.addAction(action)
        }
        
        self.present(actionSheet, animated: true, completion: nil)

    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfDaysInMonth()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventListTableViewCell", for: indexPath) as! EventListTableViewCell
        cell.strDate = Date().stringFromDateWithMonthAndYear(year: currentSelectedYear, month: currentSelectedMonth, day: indexPath.row+1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell:EventListTableViewCell = tableView.cellForRow(at: indexPath) as? EventListTableViewCell {
            
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddEventViewController") as? AddEventViewController {
                vc.strDate = cell.strDate
            self.navigationController?.pushViewController(vc, animated: true)

            }
        }
    }
}

extension ViewController {
    
    func numberOfDaysInMonth() -> Int {
        let dateComponents = DateComponents(year: currentSelectedYear, month: currentSelectedMonth)
        let calendar = Calendar.current
        let date = calendar.date(from: dateComponents)!
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
}

