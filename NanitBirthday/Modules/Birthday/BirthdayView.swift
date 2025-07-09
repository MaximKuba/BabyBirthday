//
//  BirthdayView.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//

import UIKit

protocol BirthdayView: AnyObject {
    func setBirthdayStyle(_ style: BirthdayStyle, image: UIImage?)
    func setAge(_ age: AgeDisplay)
    func setName(_ name: String)
}
