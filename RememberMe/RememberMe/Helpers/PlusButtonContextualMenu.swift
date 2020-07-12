//
//  PlusButtonContextualMenu.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/12/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import UIKit

// Contexztual menu
extension HomePageViewController: UIContextMenuInteractionDelegate {
    
    private func segueToAddTask() -> UIAction {
        
        return UIAction(
            title: "New Task",
            identifier: nil) { _ in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let main = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController")
                self.present(main, animated: true, completion: nil)
        }
    }
    
    private func segueToAddList() -> UIAction {
        
        return UIAction(title: "New List",
                        image: .strokedCheckmark,
                        identifier: nil) { _ in
                            
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let main = storyboard.instantiateViewController(withIdentifier: "AddTaskViewController")
                            self.present(main, animated: true, completion: nil)
        }
    }
    func contextMenuInteraction(
        _ interaction: UIContextMenuInteraction,
        configurationForMenuAtLocation location: CGPoint)
        -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(
                identifier: nil,
                previewProvider: nil,
                actionProvider: { _ in
                    let addTaskSegue = self.segueToAddTask()
                    let newListSegue = self.segueToAddList()
                    let children = [addTaskSegue, newListSegue]
                    return UIMenu(title: "", children: children)
            })
    }
}
