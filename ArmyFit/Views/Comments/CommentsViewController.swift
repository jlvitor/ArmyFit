//
//  CommentsViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 15/07/22.
//

import UIKit
import Kingfisher

class CommentsViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userImage: UIImageView!
    @IBOutlet private weak var timePost: UILabel!
    @IBOutlet private weak var commentPostView: UILabel!
    @IBOutlet private weak var commentTextField: UITextView!
    @IBOutlet private weak var commentTableView: UITableView!
    @IBOutlet private weak var commentBoxButtonStackView: UIStackView!
    @IBOutlet private weak var commentBoxView: UITextView!
    @IBOutlet private weak var commentBoxHeight: NSLayoutConstraint!
    @IBOutlet private weak var commentBoxBotton: NSLayoutConstraint!
    
    private var commentBoxBottomIdentity = CGFloat()
    
    //MARK: - Public propertie
    var viewModel: CommentsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configTextView()
        configureNotificationCenter()
        configViewModel()
        configUser()
        configTableView()
    }
    
    private func configViewModel() {
        viewModel?.delegate = self
        viewModel?.newCommentDelegate = self
        viewModel?.fetchPost()
    }
    
    private func configTableView() {
        commentTableView.dataSource = self
        commentTableView.overrideUserInterfaceStyle = .dark
    }
    
    private func configUser() {
        userImage.kf.setImage(with: URL(string: viewModel?.getUserImage ?? ""))
        nameLabel.text = viewModel?.getUserName
        commentPostView.text = viewModel?.getPost
    }
    
    private func configureNotificationCenter() {
        commentBoxBottomIdentity = commentBoxBotton.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func configTextView() {
        commentTextField.delegate = self
        commentTextField.text = "Adicione um comentário..."
        commentTextField.textColor = UIColor.lightGray
    }
    
    // Start Hide/Show keyboard configuration
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboard_size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            commentBoxBotton.constant = keyboard_size.height + 10
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        commentBoxBotton.constant = commentBoxBottomIdentity
    }
    // End Hide/Show keyboard configuration
    
    @IBAction func sendCommentButtonAction(_ sender: UIButton) {
        viewModel?.makeAComment(with: commentBoxView.text)
    }
    
}
//MARK: - TextViewDelegate (commentBox)
extension CommentsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ commentTextField: UITextView) {
        if commentTextField.textColor == UIColor.lightGray {
            commentTextField.text = ""
            commentTextField.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ publicationUserTextView: UITextView) {
        if publicationUserTextView.text.isEmpty {
            publicationUserTextView.text = "Adicione um comentário..."
            publicationUserTextView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        self.commentBoxHeight.constant = textView.contentSize.height
    }
}

//MARK: - UITableViewDataSource
extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getNumberOfComments ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as? CommentsTableViewCell else { return UITableViewCell() }
        
        if let cellViewModel = viewModel?.getCommentCellViewModel(at: indexPath.row) {
            cell.config(viewModel: cellViewModel)
        }
        
        return cell
    }
}

//MARK: - CommentsViewModelDelegate
extension CommentsViewController: CommentsViewModelDelegate {
    func errorGetComments() {
        print("Erro")
    }
}

//MARK: - NewCommentDelegate
extension CommentsViewController: NewCommentDelegate {
    func commentSuccess() {
        viewModel?.fetchPost()
    }
    
    func reloadData() {
        configTextView()
        commentTableView.reloadData()
    }
}
