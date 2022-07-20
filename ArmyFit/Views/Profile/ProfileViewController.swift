//
//  ProfileViewController.swift
//  ArmyFit
//
//  Created by Gabriel Policastro on 05/06/22.
//

import UIKit
import PhotosUI
import MessageUI

class ProfileViewController: UIViewController {
    
    //MARK: - Private properties
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var statusLabel: UILabel!
    @IBOutlet private weak var profileTableView: UITableView!
    
    private let viewModel: ProfileViewModel = ProfileViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUserImageViewBorder()
        configTableView()
        configUserData()
    }
    
    //MARK: - Private methods
    @IBAction private func editProfileButtonAction(_ sender: UIBarButtonItem) {
        editProfileAlert()
    }
    
    private func configTableView() {
        profileTableView.delegate = self
        profileTableView.dataSource = self
    }
    
    private func configUserImageViewBorder() {
        profileImageView.layer.borderWidth = 5
        profileImageView.layer.borderColor = UIColor(named: "light_background")?.cgColor
    }
    
    private func configUserData() {
        profileImageView.image = UIImage(data: viewModel.getUserImage)
        nameLabel.text = viewModel.getUserName
    }
    
    private func editProfileAlert() {
        let editProfileALert = UIAlertController(
            title: "Editar perfil",
            message: "Você deseja editar seu perfil?",
            preferredStyle: .actionSheet)
        
        let editImageProfileGallery = UIAlertAction(
            title: "Selecionar uma foto de perfil",
            style: .default) { action in
                self.openGalleryPickerView()
            }
        
        let editImageProfileCamera = UIAlertAction(
            title: "Tirar uma foto de perfil",
            style: .default) { action in
                self.openCameraPickerView()
            }
        
        let editNameProfile = UIAlertAction(
            title: "Editar nome de perfil",
            style: .default) { action in
                self.editNameProfile()
            }
        
        let cancelEdit = UIAlertAction(title: "Cancelar", style: .cancel)
        
        editProfileALert.addAction(editImageProfileGallery)
        editProfileALert.addAction(editImageProfileCamera)
        editProfileALert.addAction(editNameProfile)
        editProfileALert.addAction(cancelEdit)
        
        present(editProfileALert, animated: true)
    }
    
    private func editNameProfile() {
        let alertController = UIAlertController(
            title: "Confirmação",
            message: "Digite seu novo nome de perfil",
            preferredStyle: .alert)
        
        alertController.addTextField { textfield in
            textfield.placeholder = "Digite seu nome"
        }
        
        let submit = UIAlertAction(
            title: "Ok",
            style: .default) { action in
                if let name = alertController.textFields?.first?.text {
                    self.nameLabel.text = String(name).uppercased()
                    self.viewModel.changeName(name)
                }
            }
        
        let cancel = UIAlertAction(
            title: "Cancelar",
            style: .cancel)
        
        alertController.addAction(submit)
        alertController.addAction(cancel)
        present(alertController, animated: true)
    }
    
    private func openGalleryPickerView() {
        var configuration = PHPickerConfiguration(photoLibrary: .shared())
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let imagePicker = PHPickerViewController(configuration: configuration)
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    private func openCameraPickerView() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
}

//MARK: - PHPickerViewControllerDelegate
extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { success, error in
                guard let image = success as? UIImage, error == nil else { return }
                DispatchQueue.main.async {
                    self.profileImageView.image = image
                }
            }
        }
    }
}

//MARK: - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info[.originalImage] as? UIImage else { return }
        
        profileImageView.image = profileImage
        dismiss(animated: true)
    }
}

//MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        viewModel.sendMessageOnWhatsApp(at: section, at: row)
        viewModel.logout(at: section, at: row)
        
        if section == 1 {
            if row == 0 {
                let recipientEmail = "recepcaoarmyclf@gmail.com"
                let subject = "ArmyFit - Suporte ao cliente"
                
                // Show default mail composer
                if MFMailComposeViewController.canSendMail() {
                    let mail = MFMailComposeViewController()
                    mail.mailComposeDelegate = self
                    mail.setToRecipients([recipientEmail])
                    mail.setSubject(subject)
                    
                    present(mail, animated: true)
                    
                    // Show third party email composer if default Mail app is not present
                } else if let emailUrl = viewModel.createEmailUrl(to: recipientEmail, subject: subject) {
                    UIApplication.shared.open(emailUrl)
                }
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.countRowsInSection(at: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profileCustomCell", for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        let cellViewModel = viewModel.profileInfo(at: indexPath.section, at: indexPath.row)
        cell.configure(profileCellViewModel: cellViewModel)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        viewModel.setTilteForSection(at: section)
    }
}

//MARK: - MFMailComposeViewControllerDelegate
extension ProfileViewController: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
