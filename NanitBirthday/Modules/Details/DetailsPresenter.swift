//
//  DetailsPresenter.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import UIKit

class DetailsPresenter {
    
    weak var view: DetailsView?
    private var baby: BabyInfo
    
    init(view: DetailsView) {
        self.view = view
        self.baby = StorageManager.shared.load()
    }
    
    func getInfo() {
        view?.updateUI(with: baby)
    }
    
    func updateName(_ name: String) {
        baby.name = name
        StorageManager.shared.save(baby)
        checkShowButtonState()
    }
    
    func updateBirthday(_ date: Date) {
        baby.birthday = date
        StorageManager.shared.save(baby)
        checkShowButtonState()
    }
    
    
    func updateImage(_ image: UIImage) {
        if let path = ImageStorage.shared.saveImage(image, name: "babyImage") {
            baby.imagePath = path
            StorageManager.shared.save(baby)
            view?.updateUI(with: baby)
        }
    }
    
    func didTapShowBirthday() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "BirthdayViewController") as! BirthdayViewController
        vc.presenter = BirthdayPresenter(view: vc, baby: baby)
        vc.modalPresentationStyle = .fullScreen
        (view as? UIViewController)?.present(vc, animated: true)
    }
    
    private func checkShowButtonState() {
        let isEnabled = !baby.name.isEmpty && baby.birthday != nil
        view?.setShowButton(enabled: isEnabled)
    }
    
}
