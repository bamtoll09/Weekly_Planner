//
//  PlanListViewController.swift
//  Weekly Planner
//
//  Created by Sunrin on 2017. 1. 3..
//  Copyright © 2017년 Bamtoll. All rights reserved.
//

import UIKit

class PlanListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let addButton: UIBarButtonItem = UIBarButtonItem(
        barButtonSystemItem: UIBarButtonSystemItem.add,
        target: nil,
        action: #selector(addButtonDidTap)
    )
    let tableView: UITableView = UITableView()
    
    var plans: [Plan] = []
    var sameTimePlanInfos: [Int: Int] = [:] // startTime : count
    var sameTimePlanCounts: [Int] = [] // count
    var prevEndTime: Int = 0
    
    // When View Loaded
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set SubView
        self.addButton.target = self
        
        // Set Nav-Item
        self.navigationItem.title = "Weekly Planner"
        self.navigationItem.rightBarButtonItem = self.addButton
        
        // Set TableView
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        // editActionsForRowAt
        // UITableViewRowAction
        self.tableView.dataSource = self
        self.tableView.delegate = self
        // Add SubView
        self.view.addSubview(self.tableView)
        
        // Test
        for _ in 0..<5 {
            plans.append(
                Plan(
                    day: Day.Mon,
                    startTime: 9,
                    endTime: 10,
                    title: "Math",
                    context: "p10~p12"
                )
            )
        }
        for _ in 0..<5 {
            plans.append(
                Plan(
                    day: Day.Mon,
                    startTime: 11,
                    endTime: 12,
                    title: "English",
                    context: "p35~p39"
                )
            )
        }
        for _ in 0..<5 {
            plans.append(
                Plan(
                    day: Day.Mon,
                    startTime: 10,
                    endTime: 11,
                    title: "Korean",
                    context: "p22~p25"
                )
            )
        }
        
        checkPlans()
    }
    
    // When SubViews Located
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Set TableView
        self.tableView.frame = self.view.bounds
    }
    
    func addButtonDidTap() {
        let planAddViewController = PlanAddViewController()
        self.present(UINavigationController(rootViewController: planAddViewController), animated: true, completion: nil)
    }
    
    // Check The SameTimePlans To Set Number Of Rows And So On.
    func checkPlans() {
        self.plans.sort(by: { $0.startTime < $1.startTime })
        self.sameTimePlanInfos = [:]
        self.sameTimePlanCounts = []
        
        for i in 0..<self.plans.count {
            let plan = self.plans[i]
            
            if self.sameTimePlanInfos[plan.startTime] == nil {
                self.sameTimePlanInfos[plan.startTime] = 1
            } else {
                self.sameTimePlanInfos[plan.startTime]! += 1
            }
        }
        
        self.sameTimePlanCounts = self.sameTimePlanInfos.flatMap({ return $0.value })
    }
    
    // Number Of Section
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sameTimePlanCounts.count
    }
    
    // Cell Header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var count = 0
        for i in 0..<section {
            count += self.sameTimePlanCounts[i]
        }
        let index = count
        let plan = self.plans[index]
        
        let startTime = String(plan.startTime)
        let from = ":00 ~ "
        let endTime = String(plan.endTime)
        let to = ":00"
            
        return startTime + from + endTime + to
    }
    
    // Number Of Rows In Section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sameTimePlanCounts[section]
    }
    
    // Cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var count = 0
        for i in 0..<indexPath.section {
            count += self.sameTimePlanCounts[i]
        }
        let index = count + indexPath.row
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let plan = self.plans[index]
        
        cell.textLabel?.text = self.plans[index].title
        cell.detailTextLabel?.text = self.plans[indexPath.row].context
        if plan.check {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    // EditActions Of Row
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        var count = 0
        for i in 0..<indexPath.section {
            count += self.sameTimePlanCounts[i]
        }
        let index = count + indexPath.row
        
        let plan = self.plans[index]
        
        let check = UITableViewRowAction(style: .normal, title: "Check", handler: { (action, indexPath) -> Void in
            
            self.plans[index].check = !plan.check
            
            tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.left)
        })
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) -> Void in
            
            print(self.sameTimePlanCounts)
            
            self.plans.remove(at: index)
            if self.sameTimePlanCounts[indexPath.section] <= 1 {
                self.checkPlans()
                self.tableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                self.checkPlans()
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            print(self.sameTimePlanCounts)
        })
        
        check.backgroundColor = UIColor(
            red: 0 / 255.0,
            green: 200 / 255.0,
            blue: 236 / 255.0,
            alpha: 1
        )
        
        return [delete, check]
    }
}
