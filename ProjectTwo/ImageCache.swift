//
//  ImageCache.swift
//  ProjectTwo
//
//  Created by Macintosh on 28/06/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit
import FirebaseFirestore

class ImageCache {
    
    private var storage: [URL: UIImage] = [:] {
        didSet {
            print("")
            print(storage)
            print("")
        }
    }
    
    private let db: Firestore
    private let weblink: DocumentReference
    private var urlStorage: [String] = []
    private(set) var currentImageURL: URL?
    
    init() {
        db = Firestore.firestore()
        weblink = db.collection("picsweblinks").document("nkoPgQ8bSLurWNoZjrW8")
        prefetchData()
    }
    
    private func prefetchData(){
        weblink.getDocument { (document, error) in
            if let document = document,
                document.exists,
                let datalink = document.data().map({ $0["url"] as? [String] ?? []})
            {
                self.urlStorage = datalink
            } else {
                print("Document does not exist")
            }
        }
    }
    
    // var isFetching: ((Bool) -> Void)?
    
    func getRandomImage(onComplete: @escaping (UIImage?) -> Void){
        guard !urlStorage.isEmpty else{
            onComplete(nil)
            return
        }
        let size = urlStorage.count
        let index = Int.random(in: 0..<size)
        let randomUrl = URL(string: urlStorage[index])!
        downloadImage(url: randomUrl, onComplete: onComplete)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    private func downloadImage(url: URL, onComplete: @escaping (UIImage?) -> Void) {
        if let imageFromCache = storage[url] {
            onComplete(imageFromCache)
            return
        }
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.save(url: url, image: UIImage(data: data))
                onComplete(UIImage(data: data))
            }
        }
    }
    
    func save(url: URL, image: UIImage?){
        storage[url] = image
    }
    
    func get(url:URL) -> UIImage? {
        return storage[url]
    }
    
    func delete(url: URL){
        storage[url] = nil
    }
    
}

