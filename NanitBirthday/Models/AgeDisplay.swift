//
//  AgeUnit.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import Foundation

enum AgeUnit {
    case month
    case year
    case newborn
}

struct AgeDisplay {
    let number: Int
    let unit: AgeUnit
}
