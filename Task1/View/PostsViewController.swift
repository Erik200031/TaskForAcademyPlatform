//
//  PostsViewController.swift
//  Task1
//
//  Created by PicsartAcademy on 26.10.22.
//

import UIKit

protocol PostsViewControllerDelegate {
    func getUserId(_ viewController: UIViewController) -> Int
}

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let viewModel = PostViewModel()
    var items: [Post]?
    var delegate: PostsViewControllerDelegate?
    var currentUserId = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.rowHeight = 70
        tableView.register(UINib(nibName: "PostCell", bundle: nil), forCellReuseIdentifier: "PostCell")
    }
    
    func fetchData() {
        viewModel.fetchData() { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let posts):
                self?.items = posts
                self?.currentUserId = (self?.delegate?.getUserId(self ?? UIViewController()) ?? 0) + 1
                var newPosts = [Post]()
                
                if let items = self?.items {
                    for post in items {
                        if post.userId == self?.currentUserId {
                            newPosts.append(post)
                        }
                    }
                }
                self?.items = newPosts
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
   
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
}

extension PostsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        cell.titleLabel.text = items?[indexPath.row].title
        cell.bodyLabel.text = items?[indexPath.row].body
        return cell
    }
}
