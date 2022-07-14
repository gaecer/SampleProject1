//
//  Cache.swift
//  NetworkFramework
//
//  Created by gaetano cerniglia on 27/12/2020.
//

import Foundation
import UIKit

protocol SearchCache {
    func save(data: Data, for url: URL)
    func retrieveData(for url: URL) -> Data?
    func empty()
}

/// Class to setup the NSCache
class SearchCacheImp {

    private let storage: NSCache<NSURL, NSData>

    static let `default`: SearchCacheImp = SearchCacheImp()

    init(sizeInMegabytes: Int = 200, countLimit: Int = 150) {
        storage = NSCache()
        storage.countLimit = countLimit
        storage.totalCostLimit = sizeInMegabytes / 1024 / 1024
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didReceiveMemoryWarning),
                                               name: UIApplication.didReceiveMemoryWarningNotification,
                                               object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    @objc
    private func didReceiveMemoryWarning() {
        NSLog("Cache empty!")
        self.empty()
    }
}

extension SearchCacheImp: SearchCache {
    /// Funtcion to store data into the cache
    func save(data: Data, for url: URL) {
        storage.setObject(data as NSData, forKey: url as NSURL)
    }
    /// Funtcion to retrieve data from the cache
    func retrieveData(for url: URL) -> Data? {
        return storage.object(forKey: url as NSURL) as Data?
    }
    /// Funtcion to retrieve clean the cache
    func empty() {
        storage.removeAllObjects()
    }
}
