//
//  TodoListTableViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

class TodoListTableViewController: UITableViewController {
    
    @IBOutlet weak var emptyListView: UIView!
    
    var titleTextField: UITextField!
    var dueDateTextField: UITextField!
    var timeTextField: UITextField!
    
    var uniqueDueDates: [Date] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        uniqueDueDates = Array(Set(TaskList.list.map { $0.dueDate })).sorted()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        uniqueDueDates = Array(Set(TaskList.list.map { $0.dueDate })).sorted()
        emptyListView.isHidden = !TaskList.list.isEmpty
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            let vc = segue.destination as! TodoDetailViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                vc.selectedTask = TaskList.list.filter { $0.dueDate == uniqueDueDates[indexPath.section] }.sorted(by: { $0.time < $1.time })[indexPath.row]
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        emptyListView.isHidden = !TaskList.list.isEmpty
        return uniqueDueDates.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let tasksForSection = TaskList.list.filter { $0.dueDate == uniqueDueDates[section] }
        return tasksForSection.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return DateFormatter.dateFormatter.string(from: uniqueDueDates[section])
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListTableViewCell", for: indexPath) as! TodoListTableViewCell
        
        let tasksForSection = TaskList.list.filter { $0.dueDate == uniqueDueDates[indexPath.section] }.sorted(by: { $0.time < $1.time })
        let task = tasksForSection[indexPath.row]
        
        cell.task = task
        cell.configure(_task: task)
        
        return cell
    }
    
    // TODO: "정말 삭제하시겠습니까?" 확인창 추가하기
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let tasksForSection = TaskList.list.filter { $0.dueDate == uniqueDueDates[indexPath.section] }.sorted(by: { $0.time < $1.time })
            let task = tasksForSection[indexPath.row]
            
            TaskList.deleteTask(id: task.id)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            uniqueDueDates = Array(Set(TaskList.list.map { $0.dueDate })).sorted()
            tableView.reloadData()
        }
    }

    // TODO: alert창 dueDateTextField와 timeTextField에 기본값 오늘 날짜로 설정, 오늘 이후 날짜만 선택할 수 있도록 유효성 검증 로직 추가
    @IBAction func addTaskButtonTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "Add Task", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { [self] textField in
            textField.placeholder = "Title"
            titleTextField = textField
            titleTextField.delegate = self
        }
        
        alertController.addTextField { [self] textField in
            textField.placeholder = "Due Date (yyyy/MM/dd)"
            textField.keyboardType = .numbersAndPunctuation
            dueDateTextField = textField
            dueDateTextField.delegate = self
        }
        
        alertController.addTextField { [self] textField in
            textField.placeholder = "Time (HH:mm)"
            textField.keyboardType = .numbersAndPunctuation
            timeTextField = textField
            timeTextField.delegate = self
        }
        
        let addAction = UIAlertAction(title: "Add", style: .default) { [self] _ in
            if let title = titleTextField.text,
               let dueDateString = dueDateTextField.text,
               let timeString = timeTextField.text,
               let dueDate = DateFormatter.dateFormatter.date(from: dueDateString),
               let time = DateFormatter.timeFormatter.date(from: timeString),
               !title.isEmpty, !dueDateString.isEmpty, !timeString.isEmpty {
                TaskList.list.append(Task(title: title, dueDate: dueDate, time: time))
                uniqueDueDates = Array(Set(TaskList.list.map { $0.dueDate })).sorted()
                tableView.reloadData()
            } else {
                self.showInvalidInputAlert()
            }
        }
        
        alertController.addAction(addAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showInvalidInputAlert() {
        let alert = UIAlertController(title: "Invalid Input", message: "Please fill in all fields correctly.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okayAction)
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension TodoListTableViewController: UITextFieldDelegate {
    // FIXME: 유효하지 않으면 FirstResponder 넘어가지 않도록 수정
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == titleTextField {
            if let text = textField.text {
                if text.isEmpty {
                    textField.placeholder = "Invalid Title"
                    textField.placeholderColor = .red
                    textField.text = ""
                } else {
                    textField.placeholder = "Title"
                    textField.placeholderColor = .black
                    dueDateTextField.becomeFirstResponder()
                }
            }
        } else if textField == dueDateTextField {
            if let text = textField.text {
                if DateFormatter.dateFormatter.date(from: text) == nil || text.isEmpty {
                    textField.placeholder = "Invalid Date (yyyy/MM/dd)"
                    textField.placeholderColor = .red
                    textField.text = ""
                } else {
                    textField.placeholder = "Due Date (yyyy/MM/dd)"
                    textField.placeholderColor = .black
                    timeTextField.becomeFirstResponder()
                }
            }
        } else if textField == timeTextField {
            if let text = textField.text {
                if DateFormatter.timeFormatter.date(from: text) == nil || text.isEmpty {
                    textField.placeholder = "Invalid Time (HH:mm)"
                    textField.placeholderColor = .red
                    textField.text = ""
                } else {
                    textField.placeholder = "Time (HH:mm)"
                    textField.placeholderColor = .black
                    textField.resignFirstResponder()
                }
            }
        }
    }
    
    //    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    //        textField.resignFirstResponder()
    //        return true
    //    }
    
}

