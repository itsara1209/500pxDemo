//
//  ContentCollectionManager.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/15/17.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SDWebImage

let kImageNameDefault = "image_default"
let kCollectionCellSpaing: CGFloat = 10.0

protocol ContentCollectionManagerDelegate {
    func contentCollectionManagerDidScrollToEnd(collectionManager: ContentCollectionManager)
}

class ContentCollectionManager: NSObject, UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    fileprivate var isIgnoreBottomLoad = true
    fileprivate var imageDefault = UIImage(named: kImageNameDefault)
    fileprivate var edgeInsetVertical = UIEdgeInsets(top: kCollectionCellSpaing, left: kCollectionCellSpaing, bottom: kCollectionCellSpaing, right: kCollectionCellSpaing)
    fileprivate var edgeInsetHorizontal = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    var delegate: ContentCollectionManagerDelegate?
    var contentList: [Photo] = []
    var collectionView: UICollectionView!
    
    deinit {
        contentList.removeAll()
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
        
        cell.photoImageView.sd_setImage(with: URL(string: imageUrlString ?? ""), placeholderImage: imageDefault)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            var isVertical: Bool = (layout.scrollDirection == .vertical)
            layout.scrollDirection = isVertical ? .horizontal : .vertical
            isVertical = (layout.scrollDirection == .vertical)
            
            layout.minimumLineSpacing = isVertical ? kCollectionCellSpaing : 0
            collectionView.reloadData()
            collectionView.scrollToItem(at: indexPath, at: isVertical ? .centeredVertically : .centeredHorizontally, animated: false)
            collectionView.isPagingEnabled = !isVertical
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = collectionView.frame.size.width
        var height: CGFloat = collectionView.frame.size.height
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout, (layout.scrollDirection == .vertical) {
            let column: CGFloat = 2.0
            let grap: CGFloat = (column+1.0)*kCollectionCellSpaing
            width = (collectionView.frame.size.width-grap)/column
            height = width
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        var edge = edgeInsetHorizontal
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout, (layout.scrollDirection == .vertical) {
            edge = edgeInsetVertical
        }
        return edge
    }
}

extension ContentCollectionManager : UIScrollViewDelegate {
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        isIgnoreBottomLoad = true
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold: CGFloat = 10.0
        
        var contentOffset = scrollView.contentOffset.x
        var maximumOffset = scrollView.contentSize.width - scrollView.frame.size.width
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout, (layout.scrollDirection == .vertical) {
            contentOffset = scrollView.contentOffset.y
            maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        }
        if (contentOffset > 0 && contentOffset > maximumOffset-threshold && isIgnoreBottomLoad) {
            isIgnoreBottomLoad = false
            delegate?.contentCollectionManagerDidScrollToEnd(collectionManager: self)
        }
    }
}
