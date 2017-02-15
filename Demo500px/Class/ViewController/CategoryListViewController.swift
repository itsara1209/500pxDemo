//
//  CategoryListViewController.swift
//  Demo500px
//
//  Created by Itsaraporn Chaichayanon on 2/14/2017.
//  Copyright © 2017 Itsaraporn Chaichayanon. All rights reserved.
//

import UIKit
import SwiftyJSON

let kSegueCategoryListToPhotoAlbum = "kSegueCategoryListToPhotoAlbum"

class CategoryListViewController: UIViewController {
    
    @IBOutlet weak var oTableView: UITableView!
    fileprivate var mCategoryList: [Category] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "500pxDemo"

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let indexPath = oTableView.indexPathForSelectedRow {
            oTableView.deselectRow(at: indexPath, animated: true)
        }

        if (mCategoryList.count < 1) {
            if let path = Bundle.main.path(forResource: "categories", ofType: "json")
                , let data = NSData(contentsOfFile: path) as? Data {
                
                let json = JSON(data: data)
                mCategoryList = GetCategoriesResponse(fromJson: json).categories
                oTableView.reloadData()
            }
            else {
                // Cannot read categories json file
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? PhotoAlbumViewController,
            let category = sender as? Category,
            segue.identifier == kSegueCategoryListToPhotoAlbum {
            viewController.category = category
        }
    }
}

extension CategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = mCategoryList[indexPath.row]
        self.performSegue(withIdentifier: kSegueCategoryListToPhotoAlbum, sender: category)
    }
}

extension CategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mCategoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = mCategoryList[indexPath.row]
        cell.textLabel?.text = category.name
        return cell
    }
}
