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
    var category: Category!
    lazy private var oDataSourcePhoto: PhotoResource? = PhotoResource()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = category.name
        
        oManagerContent.collectionView = oCollectionViewContent
        oManagerContent.delegate = self
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        oDataSourcePhoto?.getPhotos(feature: category.name, completion: { (response: GetPhotosResponse?, error: Error?) in
            if let photos = response?.photos {
                self.oManagerContent.contentList = []
                self.oManagerContent.contentList = photos
                self.oManagerContent.collectionView.reloadData()
            }
            DispatchQueue.main.async {
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        })
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

}

extension PhotoAlbumViewController: ContentCollectionManagerDelegate {
    func contentCollectionManagerDidSelectedContent(collectionManager: ContentCollectionManager, contentSelected: Photo) {
        
    }
    
    func contentCollectionManagerDidScrollToEnd(collectionManager: ContentCollectionManager) {

    }
}
