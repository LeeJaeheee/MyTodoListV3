//
//  ViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/10.
//

import UIKit
import Lottie

class ViewController: UIViewController {

    @IBOutlet weak var todoButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var giftboxView: LottieAnimationView!
    @IBOutlet weak var mainImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        todoButton.circleButton = true
        doneButton.circleButton = true
        
        mainImageView.getImageFromURL(from: "https://t1.daumcdn.net/cfile/tistory/99A5444A5FE3EA890F?original")

        let animationView = LottieAnimationView(name: "lN7uSuXCEQ")
        animationView.contentMode = .scaleAspectFill
        giftboxView.addSubview(animationView)
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.centerXAnchor.constraint(equalTo: giftboxView.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: giftboxView.centerYAnchor, constant: 15),
            animationView.widthAnchor.constraint(equalTo: giftboxView.widthAnchor, multiplier: 1.8),
            animationView.heightAnchor.constraint(equalTo: giftboxView.heightAnchor, multiplier: 1.8)
        ])
        animationView.loopMode = .loop
        animationView.animationSpeed = 1.5
        animationView.play()
    }

    @IBAction func profileDesignVC(_ sender: UIBarButtonItem) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ProfileDesignViewController") as? ProfileDesignViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
    
}

