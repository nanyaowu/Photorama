//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by freakytune on 2018/11/27.
//  Copyright © 2018 freakytune. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let identifier = "UICollectionViewCell"
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        let identifier = "PhotoCollectionViewCell"
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! PhotoCollectionViewCell
        return cell
    }
    
    
}
