//
//  CommentsViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 15/07/22.
//

import UIKit

class CommentsViewController: UIViewController {
    
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
    private let viewModel: CommentsViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        configureNotificationCenter()
        //commentTableView.dataSource = self
        commentTableView.delegate = self
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
    
    //MARK: - Hide/Show keyboard configuration
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboard_size = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            commentBoxBotton.constant = keyboard_size.height + 16
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        commentBoxBotton.constant = commentBoxBottomIdentity
    }
    
    @IBAction func sendCommentButtonAction(_ sender: UIButton) {
        //viewModel.createNewComment(comment: commentBoxView.text ?? "")
        
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

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfComments()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        return cell
    }
}


