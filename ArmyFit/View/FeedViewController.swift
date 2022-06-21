//
//  FeedViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 02/06/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    @IBOutlet weak var userPostView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var postCollectionView: UICollectionView!
    
    
    private let viewModel: PostsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserImage()
        configCollectionView()
        configViewModel()
    }
    
    //MARK: - Private methods
    private func configUserImage() {
        guard let userImage = UserDefaults.getValue(key: UserDefaults.Keys.userPhoto) as? String else { return }
        userImageView.image = UIImage(named: userImage)
    }
    
    private func configCollectionView() {
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
    }
    
    private func configViewModel() {
        viewModel.delegate = self
        viewModel.getPosts()
    }
}

//MARK: - PostViewModelDelegate
extension FeedViewController: PostViewModelDelegate {
    func reloadData() {
        postCollectionView.reloadData()
    }
}

//MARK: - UITableViewDelegate
extension FeedViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(
            width: view.bounds.width,
            height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 15, left: 0, bottom: 0, right: 0)
    }
}

//MARK: - UICollectionViewDataSource
extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let rows = viewModel.numberOfPosts
        return rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCustomCell", for: indexPath) as? PostCollectionViewCell
        let cellViewModel = viewModel.getPostCellViewModel(indexPath.row)
        cell?.configure(cellViewModel)
        return cell ?? UICollectionViewCell()
    }
}
