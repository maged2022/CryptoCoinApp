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
    
    
    func saveImage(_ image: UIImage, imageName: String, fileName: String)  {
        
        createFolderIfNeeded(fileName: fileName)
        
        guard
            let data = image.pngData(),
            let fileURL = getURLImage(imageName: imageName, fileName: fileName) else {
            print("Error saving Image! 🥵")
            return
        }
        
        do {
            try data.write(to: fileURL)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    
    
    func getImage(imageName: String, fileName: String) -> UIImage? {
        guard
            let path = getURLImage(imageName: imageName, fileName: fileName),
            FileManager.default.fileExists(atPath: path.path)
        else { return nil }
        return UIImage(contentsOfFile: path.path)
    }
    
    private func getURLImage(imageName: String, fileName: String) -> URL?{
        guard let filePath =  getURLFolder(fileName: fileName) else {return nil}
        return filePath.appendingPathComponent(imageName + ".png")
    }
    
    private func getURLFolder(fileName: String) -> URL?{
        guard let filePath = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(fileName) else {
            print("Error in image path!")
            return nil
        }
        return filePath
    }
    
    func createFolderIfNeeded(fileName: String) {
        guard let fileURL = getURLFolder(fileName: fileName) else { return }
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.createDirectory(atPath: fileURL.path, withIntermediateDirectories: true)
            }catch let error {
                print("Error creating folder \(error)")
            }
        }
    }
}
