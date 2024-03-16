//
//  LocalFileManager.swift
//  SwiftUI_Crypto_App
//
//  Created by Yaşar Duman on 16.03.2024.
//

import SwiftUI

final class LocalFileManager {
    static let shared = LocalFileManager()
    private init () { }
    
    func saveImage(image: UIImage, withName imageName: String, in folderName: String) {
        //create folder
        createFolderIfNeeded(withName: folderName)
        
        // get path for image
        guard let data = image.pngData(),
              let url = getURLForImage(imageName: imageName, folderName: folderName) else {
            return
        }
        
        // save image to gotten path
        do {
            try data.write(to: url)
        } catch let error {
            print("Error saving image. Image name: \(imageName). \(error.localizedDescription)")
        }
    }
    
    func getImage(withName imageName: String, from folderName: String) -> UIImage? {
        guard let url = getURLForImage(imageName: imageName, folderName: folderName),
              FileManager.default.fileExists(atPath: url.path) else {
            print("Can't find image. Image name: \(imageName) Folder name: \(folderName)")
            return nil
        }
        
        return UIImage(contentsOfFile: url.path)
    }
    
    private func getURLForFolder(folderName: String) -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
                return nil
            }
        
        return url.appendingPathComponent(folderName)
    }
    
    private func getURLForImage(imageName: String, folderName: String) -> URL? {
        guard let url = getURLForFolder(folderName: folderName) else { return nil }
        
        return url.appendingPathComponent(imageName + ".png")
    }
    
    private func createFolderIfNeeded(withName name: String) {
        guard let url = getURLForFolder(folderName: name) else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch let err {
                print("Error creating directory. Folder name: \(name)). \(err.localizedDescription)")
            }
        }
    }
}

