//
//  PhotoAlbumViewController.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit

class PhotoAlbumViewController: UIViewController {
    
    var category: Category!
    lazy private var oDataSourcePhoto: PhotoResource? = PhotoResource()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = category.name
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        oDataSourcePhoto?.getPhotos(feature: category.name, completion: { (response: GetPhotosResponse?, error: Error?) in
            print("\(response?.feature) : \(response?.photos.count)")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        oDataSourcePhoto = nil
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
