//
//  Media.swift
//  ArmyFit
//
//  Created by Jean Lucas Vitor on 26/06/22.
//

import Foundation
import UIKit

struct Media {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.fileName = "imagefile.jpg"
        
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        
        self.data = data
    }
}
