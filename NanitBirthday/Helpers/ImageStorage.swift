//
//  ImageStorage.swift
//  NanitBirthday
//
//  Created by Maksym Kuba on 09/07/2025.
//


import UIKit

class ImageStorage {
    static let shared = ImageStorage()
    
    private func getDocumentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    func saveImage(_ image: UIImage, name: String) -> String? {
        
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let fileName = "\(name).jpg"
        let fileURL = getDocumentsDirectory().appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch {
            return nil
        }
    }
    
    func loadImage(from fileName: String?) -> UIImage? {
        
        guard let fileName = fileName else { return nil }
        let fullPath = getDocumentsDirectory().appendingPathComponent(fileName).path
        return UIImage(contentsOfFile: fullPath)
    }
}
