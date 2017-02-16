//
//  PhotoAlbumViewController.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import MBProgressHUD

class PhotoAlbumViewController: UIViewController {
    
    @IBOutlet var oManagerContent: ContentCollectionManager!
    @IBOutlet weak var oCollectionViewContent: UICollectionView!
    
    var refreshControl: UIRefreshControl = UIRefreshControl()
    var category: Category!
    fileprivate var oDataSourcePhoto: PhotoResource? = PhotoResource()
    fileprivate var isLoading: Bool = false
    fileprivate var nextPageNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = category.name
        
        oManagerContent.collectionView = oCollectionViewContent
        oManagerContent.delegate = self
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refreshControl.addTarget(self, action: #selector(pullToRefresh), for: UIControlEvents.valueChanged)
        self.oCollectionViewContent.addSubview(refreshControl)
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendRequestGetPhotos()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        oDataSourcePhoto = nil
        oManagerContent = nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func pullToRefresh () {
        nextPageNumber = 1
        sendRequestGetPhotos()
    }

    fileprivate func sendRequestGetPhotos() {
        
        if (nextPageNumber == -1) { return }
        refreshControl.endRefreshing()
        MBProgressHUD.showAdded(to: self.view, animated: true)
        oDataSourcePhoto?.getPhotos(feature: category.name, pageNum: nextPageNumber, completion: { (response: GetPhotosResponse?, error: Error?) in
            if let photos = response?.photos, let currentPage = response?.currentPage {
                if (currentPage == 1) {
                    self.oManagerContent.contentList = []
                }
                
                self.oManagerContent.contentList.append(contentsOf: photos)
                self.oManagerContent.collectionView.reloadData()
                self.nextPageNumber = (photos.count > 0) ? currentPage+1 : -1
            }
            else {
                self.nextPageNumber = -1
                
                //TODO: Show Error
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
    }
}

extension PhotoAlbumViewController: ContentCollectionManagerDelegate {
    func contentCollectionManagerDidScrollToEnd(collectionManager: ContentCollectionManager) {
        if (isLoading == false) {
            sendRequestGetPhotos()
        }
    }
}
