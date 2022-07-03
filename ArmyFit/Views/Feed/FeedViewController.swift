//
//  FeedViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 02/06/22.
//

import UIKit

class FeedViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var userPostView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    
    @IBOutlet private weak var postCollectionView: UICollectionView!
    
    private let viewModel: PostsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserImage()
        configCollectionView()
        configViewModel()
        configGestureRecognizer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.getPosts()
    }
    
    //MARK: - Private methods
    private func configUserImage() {
        userImageView.image = UIImage(named: viewModel.getUserImage)
    }
    
    private func configCollectionView() {
        postCollectionView.delegate = self
        postCollectionView.dataSource = self
    }
    
    private func configViewModel() {
        viewModel.delegate = self
        viewModel.getPosts()
    }
    
    private func configGestureRecognizer() {
        let tap = UITapGestureRecognizer(
            target: self,
            action: #selector(tapAction(_:))
        )
        self.userPostView.addGestureRecognizer(tap)
    }
    
    @objc private func tapAction(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "goToPostScreen", sender: self)
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
        viewModel.getNumberOfPosts
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCustomCell", for: indexPath) as? PostCollectionViewCell else {
            return UICollectionViewCell()
        }
        let cellViewModel = viewModel.getPostCellViewModel(indexPath.row)
        cell.configure(cellViewModel)
        
        return cell
    }
}
