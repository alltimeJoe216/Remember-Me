//
//  HomePageViewController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import Firebase

class HomePageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    //MARK: - Properties
    
    let taskController = TaskController()
    var tasks: [Task] = []
    var cellColors = myColors
    var cellColors2 = myColors2
    
    // For List Type Table View cells
    var myColorsArray = myColors
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var taskTypeTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    
    //MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlusButton()
        
        taskTypeTableView.separatorColor = UIColor.clear
        todayTableView.delegate = self
        todayTableView.dataSource = self
        taskTypeTableView.delegate = self
        taskTypeTableView.dataSource = self
        todayTableView.reloadData()
        taskTypeTableView.reloadData()
        let interaction = UIContextMenuInteraction(delegate: self)
        plusButton.addInteraction(interaction)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        todayTableView.reloadData()
        taskTypeTableView.reloadData()
    }
 
    //MARK: - Private Methods
    
    private func setupPlusButton() {
        
        // shadow
        plusButton.layer.shadowColor = UIColor.white.cgColor
        plusButton.backgroundColor = UIColor.white
        plusButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        plusButton.layer.shadowOpacity = 1
        plusButton.layer.shadowRadius = 3
        // shape
        plusButton.layer.cornerRadius = plusButton.frame.width / 2
        plusButton.layer.masksToBounds = false
    }
    
//MARK: - TableView Delegate/DataSource
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView == taskTypeTableView {
            cell.contentView.layer.masksToBounds = true
            let radius = cell.contentView.layer.cornerRadius
            cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
            cell.contentView.backgroundColor = UIColor(named: cellColors[indexPath.row % cellColors.count])
            cell.layer.cornerRadius = 25
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var number = 0
        
        
        if tableView == todayTableView {
            
            number = tasks.count
            
        
            
        } else if tableView == taskTypeTableView {
            
            number = lists.count
        }
        
        return number
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == todayTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTaskCell") as? TodaysTaskTableViewCell
            let task = tasks[indexPath.row] 
            cell?.taskLabel.text = task.name
  
            return cell!
            
        } else if tableView == taskTypeTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as? TaskTypeTableViewCell else {
                return UITableViewCell()}
            cell.textLabel?.text = lists[indexPath.row].title
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let worthlessCellSpacingHeight: CGFloat = 0
        if tableView == taskTypeTableView {
            
            let cellSpacingHeight: CGFloat = 5
            
            return cellSpacingHeight
        }
        return worthlessCellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let worthlessView = UIView()
        
        if tableView == taskTypeTableView {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        return worthlessView
        
    }
}

extension HomePageViewController: TaskWasAdded {
    func taskWasAdded(_ task: Task) {
        tasks.append(task)
        self.dismiss(animated: true, completion: nil)
        todayTableView.reloadData()
    }
    
    
}

