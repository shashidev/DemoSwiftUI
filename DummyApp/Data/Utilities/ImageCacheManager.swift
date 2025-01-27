//
//  ImageCacheManager.swift
//  DummyApp
//

import SwiftUI

/// A singleton class responsible for managing image caching.
/// This class uses `NSCache` to store and retrieve images efficiently,
/// reducing redundant network requests and improving performance.
class ImageCacheManager {
    
    /// Shared singleton instance of `ImageCacheManager`.
    static let shared = ImageCacheManager()
    
    /// An instance of `NSCache` to hold cached images with `NSString` keys and `UIImage` values.
    private let cache = NSCache<NSString, UIImage>()
    
    /// Private initializer to enforce the singleton pattern.
    private init() {}

    /// Retrieves an image from the cache for the given key.
    ///
    /// - Parameter key: A `String` representing the unique key for the image.
    /// - Returns: The cached `UIImage` if it exists; otherwise, `nil`.
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    /// Stores an image in the cache with the specified key.
    ///
    /// - Parameters:
    ///   - image: The `UIImage` to be cached.
    ///   - key: A `String` representing the unique key for the image.
    func cacheImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

