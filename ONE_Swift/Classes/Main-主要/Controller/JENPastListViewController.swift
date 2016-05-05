//
//  JENPastListViewController.swift
//  ONE_Swift
//
//  Created by 任玉祥 on 16/4/28.
//  Copyright © 2016年 任玉祥. All rights reserved.
//

import UIKit

class JENPastListViewController : UITableViewController {

    var endMonth = ""
    var pastLists: [String] {
        get {
            return arrayFromStr(endMonth)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "往期列表"
    }
    
    private func arrayFromStr(endDate: String) -> [String] {
        
        if !endDate.containsString("-") {return []}
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM"
        
        var currentDate = formatter.stringFromDate(NSDate()) as NSString
        let currentYear = currentDate.integerValue
        let range = currentDate.rangeOfString("-")
        if range.location != NSNotFound {
            currentDate = currentDate.stringByReplacingCharactersInRange(NSMakeRange(0, range.location + range.length), withString: "")
        }
        let currentMonth = currentDate.integerValue
        
        
        var endDataStr = endDate as NSString
        let endYear = endDataStr.integerValue
        if range.location != NSNotFound {
            endDataStr = endDataStr.stringByReplacingCharactersInRange(NSMakeRange(0, range.location + range.length), withString: "")
        }
        let endMonth = endDataStr.integerValue
        
        
        var maxMonth = 0
        var minMonth = 0
        var monthArr = [String]()
        
        var resYear = currentYear
        while resYear >= endYear {
            
            maxMonth = resYear == currentYear ? currentMonth: 12;
            minMonth = resYear == endYear ? endMonth: 1;
            
            var resMonth = maxMonth
            while resMonth >= minMonth {
                monthArr.append(String(format: "%zd-%02d", arguments: [resYear, resMonth]))
                resMonth -= 1
            }
            
            resYear -= 1
        }
        
//        for var resYear = currentYear; resYear >= endYear; resYear -= 1 {
//            maxMonth = resYear == currentYear ? currentMonth: 12;
//            minMonth = resYear == endYear ? endMonth: 1;
//            
//            for var resMonth = maxMonth; resMonth >= minMonth; resMonth -= 1 {
//                monthArr.append(String(format: "%zd-%02d", arguments: [resYear, resMonth]))
//            }
//        }
        
        return monthArr
    }


    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.tableViewWithNoData(nil, rowCount: pastLists.count)
        return pastLists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.tableViewSetExtraCellLineHidden()
        
        var cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier")
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "reuseIdentifier")
        }
        if indexPath.row == 0 {
            cell?.textLabel?.text = "本月"
        } else {
            cell?.textLabel?.text = pastLists[indexPath.row]
        }
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
