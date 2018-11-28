//
//  PhotosViewController.swift
//  Photorama
//
//  Created by freakytune on 2018/11/26.
//  Copyright © 2018 freakytune. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    // @IBOutlet var imageView: UIImageView!
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        updateDataSource()
        
        store.fetchInterestingPhotos {
            (photosResult) -> Void in
            
            self.updateDataSource()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showPhoto"?:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    private func updateDataSource() {
        store.fetchAllPhotos {
            (photosResult) in
            
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case let .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    
//    func updateImageView(for photo: Photo) {
//        store.fetchImage(for: photo) {
//            (imageResult) -> Void in
//
//            switch imageResult {
//            case let .success(image):
//                self.imageView.image = image
//            case let .failure(error):
//                print("Error downloading image: \(error)")
//            }
//        }
//    }
    // MARK: Delegate method
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data, which could take some time
        store.fetchImage(for: photo) { (result) -> Void in
            
            // The index path for the photo might have changed between the
            // time the request started and finished, so find the most
            // recent index path
            
            // (Note: You will have an error on the next line; you will fix it soon)
            guard let photoIndex = self.photoDataSource.photos.index(of: photo), case let .success(image) = result else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                cell.update(with: image)
            }
            
        }
    }
    
}
