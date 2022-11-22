//
//  SIDetailImageCell.swift
//  InfoSpace
//
//  Created by GonzaloMR on 20/11/22.
//

import UIKit

class SIDetailImageCell: UITableViewCell {

    @IBOutlet weak var itemImageView: ImageView!
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    
    private var spaceItem: SpaceItem!
    
    func configure(image: UIImage, spaceItem: SpaceItem, frameWidth: CGFloat) {
        self.spaceItem = spaceItem

        itemImageView.image = image
        
        self.imageViewHeight.constant = Utils.shared.adjustImageViewScaledHeight(frameWidth: frameWidth, imageView: self.itemImageView)
        self.layoutIfNeeded()
    }
    
    @IBAction func imageViewPressed(_ sender: Any) {
        if let itemLink = spaceItem.links.first {
            let galleryVC = ImagesGalleryViewController.initAndLoad(imagesUrl: [itemLink.href], position: 0)
            CustomNavigationController.instance.present(to: galleryVC, animated: true)
        }
    }
    
}
