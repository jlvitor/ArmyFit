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
    @IBOutlet weak var publishTabButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        publicationUserTextView.text = "No que você está pensando?"
        publicationUserTextView.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.5)
        
        
       
    }
    //MARK: - Configuração do textView
    func textViewDidBeginEditing(_ publicationUserTextView: UITextView) {
        if publicationUserTextView.textColor == UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.5) {
            publicationUserTextView.text = nil
            publicationUserTextView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ publicationUserTextView: UITextView) {
        if publicationUserTextView.text.isEmpty {
            publicationUserTextView.text = "No que você está pensando?"
            publicationUserTextView.textColor = UIColor(red: 1.00, green: 1.00, blue: 1.00, alpha: 0.5)
        }
    }
   

}
