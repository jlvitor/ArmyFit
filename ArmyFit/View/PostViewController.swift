//
//  PostViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 24/06/22.
//

import UIKit

class PostViewController: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var publicationUserTextView: UITextView!
    
    private let viewModel: NewPostViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTextView()
        configViewModel()
    }
    
    //MARK: - Private methods
    @IBAction func publishButtonAction(_ sender: UIButton) {
        viewModel.makeNewPost(description: publicationUserTextView.text)
    }
    
    private func configTextView() {
        publicationUserTextView.delegate = self
        publicationUserTextView.text = "No que você está pensando?"
        publicationUserTextView.textColor = UIColor.lightGray
    }
    
    private func configViewModel() {
        viewModel.delegate = self
    }
}

//MARK: - UITextViewDelegate
extension PostViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ publicationUserTextView: UITextView) {
        if publicationUserTextView.textColor == UIColor.lightGray {
            publicationUserTextView.text = ""
            publicationUserTextView.textColor = UIColor.white
        }
    }
    
    func textViewDidEndEditing(_ publicationUserTextView: UITextView) {
        if publicationUserTextView.text.isEmpty {
            publicationUserTextView.text = "No que você está pensando?"
            publicationUserTextView.textColor = UIColor.lightGray
        }
    }
}

extension PostViewController: NewPostViewModelDelegate {
    func successMakeNewPost() {
        print("Sucesso ao fazer postagem")
    }
    
    func errorMakeNewPost() {
        print("Erro ao fazer postagem")
    }
}
