//
//  SplashViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/25.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    @IBOutlet weak var animationView: LottieAnimationView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        playAnimation()
    }
    
    private func setupAnimation() {
        let animation = LottieAnimation.named("animation_llz0e7mu")
        animationView.animation = animation
        animationView.loopMode = .playOnce
    }
    
    private func playAnimation() {
        animationView.play { [weak self] finished in
            if finished {
                print("finished")
                self?.navigateToMainScreen()
            }
        }
    }
    
    private func navigateToMainScreen() {
            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainNavigationController")
                sceneDelegate.window?.rootViewController = mainViewController
            }
        }
    
}
