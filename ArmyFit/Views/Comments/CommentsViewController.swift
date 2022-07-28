//
//  CommentsViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 15/07/22.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var timePost: UILabel!
    @IBOutlet weak var commentPostView: UILabel!
    @IBOutlet weak var commentTextField: UITextView!
    @IBOutlet weak var commentTableView: UITableView!
    
    @IBOutlet weak var commentBoxButtonStackView: UIStackView!
    
    
    @IBOutlet weak var commentBoxView: UITextView!
   
    @IBOutlet weak var commentBoxHeight: NSLayoutConstraint!
    @IBOutlet weak var commentBoxBotton: NSLayoutConstraint!
    var commentBoxBottomIdentity = CGFloat()
    
    
    private let viewModel: CommentsViewModel = CommentsViewModel()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        configureNotificationCenter()
//        commentTableView.dataSource = self
        commentTableView.delegate = self
       
        
    }
    
    private func configureNotificationCenter() {
        commentBoxBottomIdentity = commentBoxBotton.constant
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
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
        
        if let keyboard_size = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            commentBoxBotton.constant = keyboard_size.height + 16
        }
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        commentBoxBotton.constant = commentBoxBottomIdentity
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
        
    func textViewDidChange(_ textView: UITextView) {
        self.commentBoxHeight.constant = textView.contentSize.height
    }
    
    @IBAction func sendCommentButtonAction(_ sender: UIButton) {
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
    }

extension CommentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

//extension CommentsViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return viewModel.getNumberOfComments()
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = commentTableView.dequeueReusableCell(withIdentifier: "commentCell") as? CommentsTableViewCell
//        let commentsPage = Post.feedComments[indexPath.row]
//        {
//
//        }
//
//
//            cell?.profileImage.image =
//
//        }
//
//        return cell ?? UITableViewCell()
//    }
    
    


//profileImage: UIImageView!
//@IBOutlet weak var userNameLabel: UILabel!
//@IBOutlet weak var userCommentLabel: UILabel!
