//
//  PetViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/08/31.
//

import UIKit

class PetViewController: UIViewController {

    @IBOutlet weak var petImageView: UIImageView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setImageFromAPI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadingIndicator.stopAnimating()
    }
    
    func setImageFromAPI() {
        URLManager.shared.getJsonData() { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let data):
                guard let imageAPI = data.first else { return }
                DispatchQueue.main.async {
                    self.title = imageAPI.id
                    self.petImageView.getImageFromURL(from: imageAPI.url)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.title = error.localizedDescription
                    self.petImageView.image = UIImage(systemName: "x.circle")
                }
            }
            
        }
    }

    @IBAction func refreshImageButtonTapped(_ sender: UIBarButtonItem) {
        setImageFromAPI()
    }
    

}
