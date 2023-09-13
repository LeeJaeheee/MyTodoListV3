//
//  TodoListTableViewCell.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/11.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var todoImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var doneSwitch: UISwitch!
    
    var task: Task?
    
    func configure(_task: Task) {
        let task = _task
        todoImage.image = UIImage(named: task.image!)
        todoImage.circleImage = true
        timeLabel.text = DateFormatter.timeFormatter.string(from: task.time)
        titleLabel.setTextWithStrikethrough(task.title, isDone: task.isDone)
        doneSwitch.isOn = task.isDone
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        guard let task = task else { return }
        TaskList.updateIsDone(id: task.id, isDone: sender.isOn)
        titleLabel.setTextWithStrikethrough(task.title, isDone: sender.isOn)
        let tableView = superview?.superview as! UITableView
        tableView.reloadData()
    }
    

}
