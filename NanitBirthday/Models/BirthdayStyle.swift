import UIKit

enum BirthdayStyle: CaseIterable {
    case blue, yellow, green

    static func random() -> BirthdayStyle {
        return BirthdayStyle.allCases.randomElement()!
    }

    var defaultIcon: UIImage {
        switch self {
        case .blue:
            return UIImage(named: "defaultBlueIcon")!
        case .yellow:
            return UIImage(named: "defaultYellowIcon")!
        case .green:
            return UIImage(named: "defaultGreenIcon")!
        }
    }
    
    var backgroundImage: UIImage {
        switch self {
        case .blue:
            return UIImage(named: "blueBackground")!
        case .yellow:
            return UIImage(named: "yellowBackground")!
        case .green:
            return UIImage(named: "greenBackground")!
        }
    }

    var borderColor: UIColor {
        switch self {
        case .blue:
            return UIColor(named: "blueBorder")!
        case .yellow:
            return UIColor(named: "yellowBorder")!
        case .green:
            return UIColor(named: "greenBorder")!
        }
    }
    var backgroundColor: UIColor {
        switch self {
        case .blue:
            return UIColor(named: "blueBackground")!
        case .yellow:
            return UIColor(named: "yellowBackground")!
        case .green:
            return UIColor(named: "greenBackground")!
        }
    }

    var cameraIcon: UIImage {
        switch self {
        case .blue:
            return UIImage(named: "blueCamera")!
        case .yellow:
            return UIImage(named: "yellowCamera")!
        case .green:
            return UIImage(named: "greenCamera")!
        }
    }
}
