//
//  ViewController.swift
//  HelloRest
//
//  Created by Venkat on 6/23/16.
//  Copyright © 2016 Venkat. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController{
    
    @IBOutlet weak var tableView: UITableView!
    var tableAdapter: TableAdapter?

    var jsonResults: JSON = [] {
        didSet {
            self.tableAdapter?.items = jsonResults
            self.tableView?.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "Hello Rest!"
        
        self.tableAdapter = TableAdapter(jsonData: self.jsonResults)
        self.tableView?.dataSource = self.tableAdapter
        getData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func getData() {
        Alamofire
            .request(.GET, "http://localhost:8000/listall")
            .validate(statusCode: 200..<400)
            .responseJSON { [weak self] response in
                if let value = response.result.value {
                    self?.jsonResults = JSON(value)
                }
        }
        
    }


}

class TableAdapter: NSObject, UITableViewDataSource {
    
    var items: JSON
    let cellIdentifier = "SOME_IDENTIFIER"

    
    init(jsonData: JSON) {
        self.items = jsonData
        super.init()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) ?? UITableViewCell(style: .Default, reuseIdentifier: self.cellIdentifier)
        
        cell.textLabel?.text = items[indexPath.row, "name"].stringValue
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
}

