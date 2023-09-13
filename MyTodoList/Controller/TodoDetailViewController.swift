//
//  TodoDetailViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

// FIXME: 키보드에 텍스트필드 가려지지 않게 수정하기
// TODO: 입력 완료 시 키보드 내리기 구현하기
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
        todoImage.image = UIImage(named: (selectedTask?.image)!)
        todoImage.circleImage = true
        
        todoTextField.text = selectedTask?.title
        
        let combinedDate = Calendar.current.combineDate(selectedTask!.dueDate, withTime: selectedTask!.time)
        todoDatePicker.date = combinedDate
    }
    
    @IBAction func deleteButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Delete Task", message: "Are you sure you want to delete this task?", preferredStyle: .alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] _ in
            TaskList.deleteTask(id: self!.selectedTask!.id)
            self?.navigationController?.popViewController(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Update Task", message: "Are you sure you want to update this task?", preferredStyle: .alert)
        
        let updateAction = UIAlertAction(title: "Update", style: .destructive) { [weak self] _ in
            TaskList.updateTask(id: self?.selectedTask?.id ?? UUID(), title: self?.todoTextField.text ?? "", date: self?.todoDatePicker.date ?? Date())
            
            let updateCompleteAlert = UIAlertController(title: "Update Complete", message: "The task has been updated successfully.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            updateCompleteAlert.addAction(okAction)
            self?.present(updateCompleteAlert, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(updateAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
}
