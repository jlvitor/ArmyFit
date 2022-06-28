//
//  PostViewController.swift
//  ArmyFit
//
//  Created by Gabriel Lopes on 24/06/22.
//

import UIKit

class PostViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var publicationUserTextView: UITextView!
    
    private let viewModel: NewPostViewModel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        configTextView()
        configViewModel()
        configUserLabel()
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
    
    private func configUserLabel() {
        posterImage.image = UIImage(named: viewModel.getUserImage)
        userNameLabel.text = viewModel.getUserName
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
        navigationController?.popViewController(animated: true)    }
    
    func errorMakeNewPost() {
        print("Erro ao fazer postagem")
    }
}
