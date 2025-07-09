//
//  ImagePickerManager.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import UIKit

class ImagePickerManager: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private weak var presentingVC: UIViewController?
    private var completion: ((UIImage) -> Void)?

    func present(from viewController: UIViewController, completion: @escaping (UIImage) -> Void) {
        self.presentingVC = viewController
        self.completion = completion

        let alert = UIAlertController(title: "Choose Photo", message: nil, preferredStyle: .actionSheet)

        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            alert.addAction(UIAlertAction(title: "Take Photo", style: .default) { _ in
                self.showPicker(sourceType: .camera)
            })
        }

        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default) { _ in
            self.showPicker(sourceType: .photoLibrary)
        })

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        viewController.present(alert, animated: true)
    }

    private func showPicker(sourceType: UIImagePickerController.SourceType) {
        guard let viewController = presentingVC else { return }

        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = sourceType
        picker.allowsEditing = true
        viewController.present(picker, animated: true)
    }

    // MARK: - UIImagePickerControllerDelegate

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true)
        if let image = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage {
            completion?(image)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}