//
//  StorageManager.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import Foundation

class StorageManager {
    static let shared = StorageManager()

    private let nameKey = "baby_name"
    private let birthdayKey = "baby_birthday"
    private let imagePathKey = "baby_image"

    func save(_ baby: BabyInfo) {
        UserDefaults.standard.set(baby.name, forKey: nameKey)
        UserDefaults.standard.set(baby.birthday, forKey: birthdayKey)
        UserDefaults.standard.set(baby.imagePath, forKey: imagePathKey)
    }

    func load() -> BabyInfo {
        let name = UserDefaults.standard.string(forKey: nameKey) ?? ""
        let birthday = UserDefaults.standard.object(forKey: birthdayKey) as? Date ?? nil
        let imagePath = UserDefaults.standard.string(forKey: imagePathKey)
        return BabyInfo(name: name, birthday: birthday, imagePath: imagePath)
    }
}
