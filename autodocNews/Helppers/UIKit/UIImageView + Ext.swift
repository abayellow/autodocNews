//
//  UIImageView + Ext.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import UIKit

private var imageTaskKey: UInt8 = 0

extension UIImageView {
    
    private var currentTask: Task<Void, Never>? {
        get { objc_getAssociatedObject(self, &imageTaskKey) as? Task<Void, Never> }
        set { objc_setAssociatedObject(self, &imageTaskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func setImage(from url: URL, placeholder: UIImage? = nil, completion: ((UIImage?) -> Void)? = nil) {
        currentTask?.cancel()
        self.image = placeholder
        
        if let cached = ImageCache.shared.image(forKey: url.absoluteString) {
            self.image = cached
            completion?(cached)
            return
        }
        
        currentTask = Task { [weak self] in
            guard let self else { return }
            do {
                let data = try await Task.detached(priority: .background) {
                    try Data(contentsOf: url)
                }.value
                
                if Task.isCancelled { return }
                guard let image = UIImage(data: data) else { return }
                
                ImageCache.shared.setImage(image, forKey: url.absoluteString)
                
                await MainActor.run {
                    self.image = image
                    completion?(image)
                }
            } catch {
                print("Ошибка загрузки изображения: \(error)")
                await MainActor.run { completion?(nil) }
            }
        }
    }

    func cancelImageLoad() {
        currentTask?.cancel()
        currentTask = nil
    }
}
