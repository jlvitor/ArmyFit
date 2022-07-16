//
//  CommentsViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 15/07/22.
//

import UIKit

class CommentsViewController: UIViewController {

    @IBOutlet weak var commentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        
    }
    private func configTextView() {
        commentTextView.delegate = self
        commentTextView.text = "Adicione um comentário..."
        commentTextView.textColor = UIColor.lightGray
    }


}

//MARK: - UITextViewDelegate
extension CommentsViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ publicationUserTextView: UITextView) {
        if commentTextView.textColor == UIColor.lightGray {
            commentTextView.text = ""
            commentTextView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ publicationUserTextView: UITextView) {
        if commentTextView.text.isEmpty {
            commentTextView.text = "Adicione um comentário..."
            commentTextView.textColor = UIColor.lightGray
        }
    }
}
