//
//  DetailsViewProtocol.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import UIKit


class DetailsViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var babyImageView: UIImageView!
    @IBOutlet weak var showBirthdayButton: UIButton!

    private var presenter: DetailsPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = DetailsPresenter(view: self)
        presenter.getInfo()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapChangePhoto))
        babyImageView.addGestureRecognizer(tap)
        babyImageView.isUserInteractionEnabled = true
        
        nameTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        birthdayPicker.addTarget(self, action: #selector(birthdayChanged), for: .valueChanged)
    }

    @objc func didTapChangePhoto() {
        let alert = UIAlertController(title: "Choose photo source", message: nil, preferredStyle: .actionSheet)

            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                    self.presentImagePicker(sourceType: .camera)
                })
            }

            alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { _ in
                self.presentImagePicker(sourceType: .photoLibrary)
            })

            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            present(alert, animated: true, completion: nil)
    }
    
    func presentImagePicker(sourceType: UIImagePickerController.SourceType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        present(picker, animated: true)
    }

    @IBAction func didTapShowBirthday(_ sender: UIButton) {
        //TODO PRESENT NEXT SCREEN

    }

    @objc private func nameChanged() {
        presenter.updateName(nameTextField.text ?? "")
    }

    @objc private func birthdayChanged() {
        presenter.updateBirthday(birthdayPicker.date)
    }
}

extension DetailsViewController: DetailsView {
    
    func updateUI(with baby: BabyInfo) {
    
        nameTextField.text = baby.name
        birthdayPicker.date = baby.birthday ?? Date()
        babyImageView.image = ImageStorage.shared.loadImage(from: baby.imagePath) ?? UIImage(named: "DefaultGreenIcon")
        setShowButton(enabled: !baby.name.isEmpty)
    }

    func setShowButton(enabled: Bool) {
        showBirthdayButton.isEnabled = enabled
    }
}

extension DetailsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)

        let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage
        if let image = selectedImage {
            presenter.updateImage(image)
        }
    }
}
