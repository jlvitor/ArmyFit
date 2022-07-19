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
    
    private let viewModel: CommentsViewModel = CommentsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        commentTableView.dataSource = self
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

extension CommentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}

