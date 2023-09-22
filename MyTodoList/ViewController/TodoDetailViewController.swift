//
//  TodoDetailViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit
import CoreData

class TodoDetailViewController: UIViewController {

    @IBOutlet weak var todoImage: UIImageView!
    @IBOutlet weak var todoDatePicker: UIDatePicker!
    @IBOutlet weak var todoTextField: UITextField!
    
    var selectedTask: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        if let task = selectedTask {
            todoImage.image = UIImage(named: task.image ?? "")
            todoImage.circleImage = true
            
            todoTextField.text = task.title
            
            if let dueDate = task.dueDate, let time = task.time {
                let combinedDate = Calendar.current.combineDate(dueDate, withTime: time)
                todoDatePicker.date = combinedDate
            } else {
                // Handle the case where dueDate or time is nil
                // You can set default values or handle it based on your requirements
            }
        }
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            if let task = self?.selectedTask {
                TaskList.shared.deleteTask(task: task)
                self?.navigationController?.popViewController(animated: true)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Update Task", message: "Are you sure you want to update this task?", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .destructive) { [weak self] _ in
            if let task = self?.selectedTask,
               let updatedTitle = self?.todoTextField.text,
               let context = task.managedObjectContext {
                
                let updatedDate = self?.todoDatePicker.date ?? Date()
                TaskList.shared.updateTask(task: task, title: updatedTitle, dueDate: updatedDate)
                
                do {
                    try context.save()
                } catch {
                    print("Error saving context: \(error)")
                }
                
                let updateCompleteAlert = UIAlertController(title: "Update Complete", message: "The task has been updated successfully.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                updateCompleteAlert.addAction(okAction)
                self?.present(updateCompleteAlert, animated: true, completion: nil)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
