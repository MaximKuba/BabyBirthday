//
//  BirthdayPresenter.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//

import UIKit

class BirthdayPresenter {
    weak var view: BirthdayView?
    private var baby: BabyInfo

    init(view: BirthdayView, baby: BabyInfo) {
        self.view = view
        self.baby = baby
    }

    func onViewDidLoad() {
        view?.setName(baby.name)
        view?.setAge(formattedAge(from: baby.birthday ?? Date()))

        let style = BirthdayStyle.random()
        if let image = ImageStorage.shared.loadImage(from: baby.imagePath) {
            view?.setBirthdayStyle(style, image: image)
        } else {
            view?.setBirthdayStyle(style, image: nil)
        }
       
        

    }
    
    func updateImage(_ image: UIImage) {
        if let path = ImageStorage.shared.saveImage(image, name: "babyImage") {
            baby.imagePath = path
            StorageManager.shared.save(baby)
        }
    }

    private func formattedAge(from birthday: Date) -> AgeDisplay {
        let now = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: birthday, to: now)

        if let years = components.year, years >= 1 {
            return AgeDisplay(number: years, unit: .year)
        } else if let months = components.month, months > 0 {
            return AgeDisplay(number: months, unit: .month)
        } else {
            return AgeDisplay(number: 0, unit: .newborn)
        }
    }
}
