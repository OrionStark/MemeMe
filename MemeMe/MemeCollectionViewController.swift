//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by macbook-rhla on 03/12/18.
//  Copyright © 2018 ORIONOSCODE. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCellLayout()
    }
    
    /* Taking meme from shared model */
    var memes: [Meme]! {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
    }
    
    @IBAction func addMemeClicked(_ sender: Any) {
        let createMemeController = self.storyboard!.instantiateViewController(withIdentifier: "CREATE_MEME_CONTROLLER") as! CreateMemeViewController
        present(createMemeController, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as! MemeCollectionViewCell
        let meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage.contentMode = UIViewContentMode.scaleAspectFill
        cell.memeImage.clipsToBounds = true
        cell.memeImage.image = meme.finalImage
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
    /* MARK: Setting cell layout size */
    private func setCellLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(0, 5, 5, 5)
        layout.minimumInteritemSpacing = 5.0
        layout.minimumLineSpacing = 5.0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 20)/3, height: ((UIScreen.main.bounds.size.width - 20)/3))
        collectionView!.collectionViewLayout = layout
    }
}
