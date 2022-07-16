//
//  CommentsViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 15/07/22.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var commentTextField: UITextView!
    
    @IBOutlet weak var commentTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        
    }
    
    private func configTextView() {
        commentTextField.delegate = self
        commentTextField.text = "Adicione um comentário..."
        commentTextField.textColor = UIColor.lightGray
    }
    
    @IBAction func sendCommentButtonAction(_ sender: UIButton) {
        
    }
    
}

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
