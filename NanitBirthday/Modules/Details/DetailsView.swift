//
//  SmsView.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//

import UIKit

protocol DetailsView: AnyObject  {
    func updateUI(with baby: BabyInfo)
    func setShowButton(enabled: Bool)
}
