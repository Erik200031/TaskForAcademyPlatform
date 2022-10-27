//
//  ViewController.swift
//  Task1
//
//  Created by PicsartAcademy on 26.10.22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = UserViewModel()
    var items: [User]?
    var currentUserId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchData()
        collectionView.register(UINib(nibName: "UserCell", bundle: nil), forCellWithReuseIdentifier: "UserCell")
    }
    
    func fetchData() {
        viewModel.fetchData() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self?.items = posts
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        }
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "UserCell", for: indexPath) as? UserCell else {return UICollectionViewCell()}
        cell.nameLabel.text = items?[indexPath.row].name ?? "Unknown"
        cell.emailLabel.text = items?[indexPath.row].email ?? "Unknown"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PostsViewController") as! PostsViewController
        vc.delegate = self
        currentUserId = indexPath.row
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 150.0)
    }
}

extension HomeViewController: PostsViewControllerDelegate {
    
    func getUserId(_ viewController: UIViewController) -> Int {
        return currentUserId
    }
}
