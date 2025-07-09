//
//  BirthdayViewController.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//

import UIKit

class BirthdayViewController: UIViewController {
    
    
    // MARK: - @IBOutlets
    
    @IBOutlet weak var ageNumber: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var cameraCenterXConstraint: NSLayoutConstraint!
    @IBOutlet weak var cameraCenterYConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var presenter: BirthdayPresenter!
    let imagePickerManager = ImagePickerManager()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.onViewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let calculatedWidth = imageView.frame.size.width
        imageView.layer.cornerRadius = calculatedWidth / 2.0
        imageView.layer.borderWidth = 7
        imageView.clipsToBounds = true
        
        
        let positionRadius = calculatedWidth / 2.0
        let angle: CGFloat = -.pi / 4.0
        let offsetX = positionRadius * cos(angle)
        let offsetY = positionRadius * sin(angle)
        cameraCenterXConstraint.constant = offsetX
        cameraCenterYConstraint.constant = offsetY
        imageView.superview?.bringSubviewToFront(cameraButton)
    }
    
    // MARK: - Funcs
    
    private func hideUIForSharing(_ hide: Bool) {
        
        shareButton.isHidden = hide
        closeButton.isHidden = hide
        cameraButton.isHidden = hide
    }
    
    // MARK: - Actions
    @IBAction func cameraTaped(_ sender: Any) {
        imagePickerManager.present(from: self) { [weak self] image in
            self?.presenter?.updateImage(image)
            self?.imageView.image = image
        }
        
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func shareTapped(_ sender: UIButton) {
        
        hideUIForSharing(true)
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, UIScreen.main.scale)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        hideUIForSharing(false)
        if let image = image {
            let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
            present(activityVC, animated: true)
        }
    }
}

// MARK: - BirthdayView

extension BirthdayViewController: BirthdayView {
    
    func setName(_ name: String) {
        nameLabel.text = "TODAY \(name) IS".uppercased()
    }
    
    func setAge(_ age: AgeDisplay) {
        
        switch age.unit {
        case .newborn:
            ageNumber.image = UIImage(named: "\(age.number)")
            ageLabel.text = "month old, the baby was born less than a month ago".uppercased()
        case .month:
            ageNumber.image = UIImage(named: "\(age.number)")
            ageLabel.text = age.number > 1 ? "MONTHS OLD" : "MONTH OLD"
        case .year:
            ageNumber.image = UIImage(named: "\(age.number)")
            ageLabel.text = age.number > 1 ? "YEARS OLD" : "YEAR OLD"
        }
    }
    
    func setBirthdayStyle(_ style: BirthdayStyle, image: UIImage?) {
        
        backgroundImageView.image = style.backgroundImage
        view.backgroundColor = style.backgroundColor
        imageView.layer.borderColor = style.borderColor.cgColor
        cameraButton.setImage(style.cameraIcon, for: .normal)
        if let image = image {
            imageView.image = image
        } else {
            imageView.image = style.defaultIcon
        }
    }
}
