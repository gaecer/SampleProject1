//
//  ImageDownloader.swift
//  NetworkFramework
//
//  Created by gaetano cerniglia on 21/12/2020.
//

import UIKit

public class ImageDownloader {

    public typealias ImageDownloaderCompletionHandler = (UIImage) -> Void
    public static let `default`: ImageDownloader = ImageDownloader()

    let session: URLSession
    let cache: SearchCache

    init(session: URLSession = .shared, cache: SearchCacheImp = .default) {
        self.session = session
        self.cache = cache
    }

    /**
    A function that download an Image and store it into the cache memory.  The funcion will try to retrieve the data from the cache first, if they are not present it will start the download, at the end it will store the downloaded data into the cache at the end.

    - parameter url: URL address of the call
    - parameter fallbackImage: image to fallback in case an error occurs
    - parameter completion: this is an escaping block of type (UIImage) to handle the .success or the .failure Result
    - Returns: a Cancellable object to give the option to Cancel the running calls
    */
    public func image(at url: URL, fallbackImage: UIImage,
                      completion: @escaping ImageDownloaderCompletionHandler) -> Cancellable {

        /// Try to retieve the cached image
        if let cachedData = cache.retrieveData(for: url), let cachedImage = UIImage(data: cachedData) {
            NSLog("cache image hit!")
            completion(cachedImage)
            return TaskReceipt(task: nil)
        }

        /// Download the data
        let task = session.dataTask(with: url) {[weak self] (data, _, error) in
            DispatchQueue.main.async {
                guard error == nil else {
                    print("Download the data error: \(error.debugDescription)")
                    completion(fallbackImage)
                    return
                }
                /// decode the response
                guard let data = data, let image = UIImage(data: data) else {
                    completion(fallbackImage)
                    return
                }
                /// save downloaded data into the cache
                self?.cache.save(data: data, for: url)
                /// success completion
                completion(image)
            }
        }
        task.resume()
        return TaskReceipt(task: task)
    }

}
