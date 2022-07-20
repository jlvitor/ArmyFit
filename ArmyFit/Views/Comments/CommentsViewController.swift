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
    @IBOutlet weak var commentBoxView: UITextView!
    @IBOutlet weak var commentBoxButtonStackView: UIStackView!
    
    private let viewModel: CommentsViewModel = CommentsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func configTextView() {
        commentTextField.delegate = self
        commentTextField.text = "Adicione um comentário..."
        commentTextField.textColor = UIColor.lightGray
    }
    
//MARK: - Hide/Show keyboard configuration
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           return
        }
      view.frame.origin.y = -keyboardRect.height
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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


