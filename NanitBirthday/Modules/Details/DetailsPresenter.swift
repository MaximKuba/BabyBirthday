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
        save()
        checkShowButtonState()
    }

    func updateBirthday(_ date: Date) {
        baby.birthday = date
        save()
        checkShowButtonState()
    }
    
   
    func updateImage(_ image: UIImage) {
        if let path = ImageStorage.shared.saveImage(image, name: "babyImage") {
            baby.imagePath = path
            save()
            view?.updateUI(with: baby)
        }
    }

    private func checkShowButtonState() {
        let isEnabled = !baby.name.isEmpty && baby.birthday != nil
        view?.setShowButton(enabled: isEnabled)
    }

    private func save() {
        StorageManager.shared.save(baby)
    }
}
