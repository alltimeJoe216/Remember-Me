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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlusButton()
        
        self.taskTypeTableView.separatorColor = UIColor.clear
        self.todayTableView.delegate = self
        self.todayTableView.dataSource = self
        self.taskTypeTableView.delegate = self
        self.taskTypeTableView.dataSource = self
        
        let interaction = UIContextMenuInteraction(delegate: self)
        plusButton.addInteraction(interaction)
    }
    
    //MARK: - IBAction
    @IBAction func plusButtonContextMenu(_ sender: UIButton) {
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
        
        
        if tableView == todayTableView {
            
            return tasks.count
            
        } else if tableView == taskTypeTableView {
            
            return lists.count
        }
        
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == todayTableView
            
        {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomOne") as? TodaysTaskTableViewCell else
            {
                
                return UITableViewCell()
                
            }
            
            cell.textLabel?.text = lists[indexPath.row].title
            
            return cell
            
        }
            
        else if tableView == taskTypeTableView
            
        {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTwo") as? TaskTypeTableViewCell else
                
            {
                
                return UITableViewCell()}
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

