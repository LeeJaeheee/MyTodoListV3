//
//  ProfileDesignViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/09/13.
//

import UIKit

class ProfileDesignViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    
    func configureUI() {
        profileImageView.circleImage = true
    }

}
