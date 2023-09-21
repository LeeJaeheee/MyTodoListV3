//
//  TodoListTableViewCell.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit
import CoreData

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var task: Task?
    
    func configure(task: Task) {
        todoImage.image = UIImage(named: task.image ?? "")
        todoImage.circleImage = true
        timeLabel.text = DateFormatter.timeFormatter.string(from: task.time ?? Date())
        titleLabel.setTextWithStrikethrough(task.title ?? "", isDone: task.isDone)
        doneSwitch.isOn = task.isDone
        self.task = task
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        guard let task = task else { return }
        TaskList.updateIsDone(task: task, isDone: sender.isOn)
        titleLabel.setTextWithStrikethrough(task.title ?? "", isDone: sender.isOn)
        NotificationCenter.default.post(name: NSNotification.Name("TaskListDidUpdate"), object: nil)
    }
}
