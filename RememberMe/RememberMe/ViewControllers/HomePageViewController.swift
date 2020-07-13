//
//  HomePageViewController.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/11/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class HomePageViewController: UIViewController {
    
    //MARK: - Properties
    
    let taskController = TaskController()
    
    
    lazy var fetchedResultsController: NSFetchedResultsController<Task> = {
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "taskType", ascending: true),
                                        NSSortDescriptor(key: "timestamp", ascending: true)]
        
        let context = CoreDataStack.shared.mainContext
        let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "mood", cacheName: nil)
        frc.delegate = self
        
        try! frc.performFetch()
        return frc
        
    }()
    
    // For List Type Table View cells
    var myColorsArray = myColors

    //MARK: - IBOutlet
    
    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var taskTypeTableView: UITableView!
    @IBOutlet weak var plusButton: UIButton!
    
    //MARK: - TableViewClassRefs
    /// Classes are created at bottom of .swift file
    let todayTableViewRef = TodayTaskTableView()
    let taskTypeTableViewRef = TaskTypeTableView()
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPlusButton()
        
        self.taskTypeTableView.separatorColor = UIColor.clear
        self.todayTableView.delegate = todayTableViewRef
        self.todayTableView.dataSource = todayTableViewRef
        self.taskTypeTableView.delegate = taskTypeTableViewRef
        self.taskTypeTableView.dataSource = taskTypeTableViewRef
        
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
    
    
    // MARK: - NAVIGATION is handled with the contextul menu attached to the plus button
    
}

class TodayTaskTableView: NSObject, UITableViewDataSource, UITableViewDelegate {
    
    var homePageRef: HomePageViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        homePageRef?.fetchedResultsController.sections![section].numberOfObjects ?? 0
         
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! TodaysTaskTableViewCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        65
    }
}

class TaskTypeTableView: NSObject, UITableViewDelegate, UITableViewDataSource {
    let cellSpacingHeight: CGFloat = 0
    var cellColors = myColors
    var cellColors2 = myColors2
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    
        cell.contentView.layer.masksToBounds = true
        let radius = cell.contentView.layer.cornerRadius
        cell.layer.shadowPath = UIBezierPath(roundedRect: cell.bounds, cornerRadius: radius).cgPath
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    // # of rows
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        lists.count
        
    }
    // Cell For Row At
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell") as! TaskTypeTableViewCell
        cell.textLabel?.text = lists[indexPath.row].title
        cell.contentView.backgroundColor = UIColor(named: cellColors[indexPath.row % cellColors.count])
        cell.layer.cornerRadius = 25

        return cell
    }
}
//MARK: - FRC Delegate
extension HomePageViewController: NSFetchedResultsControllerDelegate {
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        todayTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        todayTableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange sectionInfo: NSFetchedResultsSectionInfo,
                    atSectionIndex sectionIndex: Int,
                    for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            todayTableView.insertSections(IndexSet(integer: sectionIndex), with: .automatic)
        case .delete:
            todayTableView.deleteSections(IndexSet(integer: sectionIndex), with: .automatic)
        default:
            break
        }
    }
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any,
                    at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType,
                    newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            todayTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .update:
            guard let indexPath = indexPath else { return }
            todayTableView.reloadRows(at: [indexPath], with: .automatic)
        case .move:
            guard let oldIndexPath = indexPath,
                let newIndexPath = newIndexPath else { return }
            todayTableView.deleteRows(at: [oldIndexPath], with: .automatic)
            todayTableView.insertRows(at: [newIndexPath], with: .automatic)
        case .delete:
            guard let indexPath = indexPath else { return }
            todayTableView.deleteRows(at: [indexPath], with: .automatic)
        @unknown default:
            break
        }
    }
    
}

