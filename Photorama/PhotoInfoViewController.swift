//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by freakytune on 2018/11/27.
//  Copyright © 2018 freakytune. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    //@IBOutlet var timesViewed: UILabel!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
        }
    }
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        store.fetchImage(for: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                self.imageView.image = image
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
        photo.timesViewed += 1
        store.saveContextIfNeeded()

        let label = UILabel()
        label.text = "\(photo.timesViewed) views"
        label.backgroundColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        
        label.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -8).isActive = true
        
    }
    
}
