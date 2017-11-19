//
//  MyTVC.swift
//  ExpandCollapseTableView
//
//  Created by Vandan Patel on 11/19/17.
//  Copyright © 2017 Vandan Patel. All rights reserved.
//

import UIKit

class MyTVC: UITableViewController {
    
    let reuseIdentifier = "myCell"
    var data: [ExpandCollapseSection]?
    let sectionTitles = ["Cricketers", "Politicians of India", "Actors", "Politicians of USA"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My TableView"
        data = loadDataForTesting()
    }
    
    func loadDataForTesting() -> [ExpandCollapseSection] {
        return [
            ExpandCollapseSection(isExpanded: true, text: ["Shikhar Dhawan", "Rohit Sharma", "Virat Kohli", "Ajinkya Rahane", "M S Dhoni", "Kedar Jadav"]),
            ExpandCollapseSection(isExpanded: true, text: ["Narendra Modi", "Amit Shah", "Nitin Gadkari", "Piyush Goyal", "Nirmala Sitharaman"]),
            ExpandCollapseSection(isExpanded: true, text: ["Shah Rukh Khan", "Salman Khan", "Aamir Khan", "Amitabh Bachchan"]),
            ExpandCollapseSection(isExpanded: true, text: ["Donald Trump", "Ivanka Trump", "Ronald Reagan", "George W. Bush"])        ]
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data![section].isExpanded ? data![section].text.count : 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = data![indexPath.section].text[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.backgroundColor = .red
        button.setTitle(sectionTitles[section], for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleExpandCollapse(_:)), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    @objc func handleExpandCollapse(_ sender: UIButton) {
        let section = sender.tag
        var indexPaths = [IndexPath]()
        for row in data![section].text.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = data![section].isExpanded
        data![section].isExpanded = !isExpanded
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .automatic)
        } else {
            tableView.insertRows(at: indexPaths, with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45.0
    }
}
