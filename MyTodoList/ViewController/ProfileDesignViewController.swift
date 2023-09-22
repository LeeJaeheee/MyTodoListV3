//
//  ProfileDesignViewController.swift
//  MyTodoList
//
//  Created by 이재희 on 2023/09/13.
//

import UIKit

class ProfileDesignViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    let images = (1...17).map { "d\($0)" }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageCollectionView.delegate = self
        imageCollectionView.dataSource = self

        configureUI()
    }
    
    func configureUI() {
        profileImageView.circleImage = true
        
        let layout = UICollectionViewFlowLayout()
        let itemSpacing: CGFloat = 1
        let itemWidth = (self.view.bounds.width - itemSpacing * 2) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = itemSpacing
        layout.scrollDirection = .vertical
        
        imageCollectionView.collectionViewLayout = layout
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    

}

extension ProfileDesignViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension ProfileDesignViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as! imageCollectionViewCell
        
        let image = images[indexPath.item]
        cell.imageView.image = UIImage(named: image)
        
        return cell
    }
    
    
}
