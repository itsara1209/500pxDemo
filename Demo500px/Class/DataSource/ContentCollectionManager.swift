//
//  ContentCollectionManager.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/15/17.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SDWebImage

protocol ContentCollectionManagerDelegate {
    func contentCollectionManagerDidScrollToEnd(collectionManager: ContentCollectionManager)
    func contentCollectionManagerDidSelectedContent(collectionManager: ContentCollectionManager, contentSelected: Photo)
}

class ContentCollectionManager: NSObject, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    private var isIgnoreBottomLoad = true
    var delegate: ContentCollectionManagerDelegate?
    var contentList: [Photo] = []
    var collectionView: UICollectionView!
    
    deinit {
        contentList = []
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let content = contentList[indexPath.row]
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.getIdentifier(), for: indexPath) as! PhotoCollectionViewCell
        
        cell.titleLabel.text = content.name
        cell.subTitleLabel.text = content.user.fullname

        var imageUrlString = content.imageFull
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout, (layout.scrollDirection == .vertical) {
            imageUrlString = content.imageSquare
        }

//        let imageUrl = NSURL(string: imageUrlString ?? "")
//        cell.photoImageView.sd_setImage(with: imageUrl as URL!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = (layout.scrollDirection == .vertical) ? .horizontal : .vertical
            collectionView.reloadData()
            collectionView.scrollToItem(at: indexPath, at: (layout.scrollDirection == .vertical) ? .centeredVertically : .centeredHorizontally, animated: false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 10.0
        var width: CGFloat = collectionView.frame.size.width
        var height: CGFloat = collectionView.frame.size.height
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            if (layout.scrollDirection == .vertical) {
                let column: CGFloat = 2.0
                let grap: CGFloat = (column+1.0)*spacing
                width = (collectionView.frame.size.width-grap)/column
                height = width
            }
            else {
                width = collectionView.frame.size.width
                height = collectionView.frame.size.height
            }
        }
        
        
        return CGSize(width: width, height: height)
    }
}

//extension ContentCollectionManager : UIScrollViewDelegate {
//    
//    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
//        isIgnoreBottomLoad = true
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        let threshold = 10.0 as CGFloat!
//        let contentOffset = scrollView.contentOffset.y
//        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
//        if (contentOffset > maximumOffset-threshold && isIgnoreBottomLoad) {
//            isIgnoreBottomLoad = false
//            /*
//             Load More Event
//             */
//            if let callBack = delegate {
//                callBack.contentCollectionManagerDidScrollToEnd(self)
//            }
//        }
//    }
//}
