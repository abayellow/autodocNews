//
//  ImageCache.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    
    private let cache = NSCache<NSString, UIImage>() 
    
    private init() {}
    
    func image(forKey key: String) -> UIImage? {
        cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
