//
//  LocalFileManager.swift
//  CryptoCoinApp
//
//  Created by s on 03/10/2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    private init() {  }
    
    
    func saveImage(_ image: UIImage, withName imageName: String)  {
        guard
            let data = image.pngData(),
            let fileURL = getImagePath(imageName: imageName) else {
            print("Error saving Image! 🥵")
            return
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getImagePath(imageName: String) -> URL?{
        guard let imagePath = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(imageName) else {
            print("Error in image path!")
            return nil
        }
        return imagePath
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getImagePath(imageName: name),
            FileManager.default.fileExists(atPath: path.path)
        else { return nil }
        return UIImage(contentsOfFile: path.path)
    }
    
}
