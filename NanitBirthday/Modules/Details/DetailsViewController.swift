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
    let imagePickerManager = ImagePickerManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = DetailsPresenter(view: self)
        setup()
    }
    override func viewWillAppear(_ animated: Bool) {
        presenter.getInfo()
    }
    
    private func setup() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapChangePhoto))
        babyImageView.addGestureRecognizer(tap)
        babyImageView.isUserInteractionEnabled = true
        
        nameTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        birthdayPicker.addTarget(self, action: #selector(birthdayChanged), for: .valueChanged)
        
        let calendar = Calendar.current
        let now = Date()
        birthdayPicker.maximumDate = now
        if let minDate = calendar.date(byAdding: .year, value: -13, to: now),
           let adjustedMinDate = calendar.date(byAdding: .day, value: 1, to: minDate) {
            birthdayPicker.minimumDate = adjustedMinDate
        }
    }
    
    @objc func didTapChangePhoto() {
        imagePickerManager.present(from: self) { [weak self] image in
            self?.presenter?.updateImage(image)
        }
    }
    
    
    @IBAction func didTapShowBirthday(_ sender: UIButton) {
        
        presenter.didTapShowBirthday()
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
        babyImageView.image = ImageStorage.shared.loadImage(from: baby.imagePath) ?? UIImage.init(systemName: "plus.circle.fill")
        setShowButton(enabled: !baby.name.isEmpty && baby.birthday != nil)
    }
    
    func setShowButton(enabled: Bool) {
        showBirthdayButton.isEnabled = enabled
    }
}
