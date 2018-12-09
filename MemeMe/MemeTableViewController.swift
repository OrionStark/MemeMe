//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by macbook-rhla on 02/12/18.
//  Copyright © 2018 ORIONOSCODE. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {
    
    /* Meme Tmp */
    var memes: [Meme]! {
        didSet {
            tableView.reloadData()
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MEME_TABLE_CELL") as! MemeTableViewCell
        let meme: Meme = self.memes[(indexPath as NSIndexPath).row]
        cell.memeImage.contentMode = UIViewContentMode.scaleAspectFill
        cell.memeImage.clipsToBounds = true
        cell.memeImage.image = meme.finalImage
        cell.memeText.text = meme.topText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memeDetailViewController = self.storyboard!.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        memeDetailViewController.meme = self.memes[(indexPath as NSIndexPath).row]
        self.navigationController!.pushViewController(memeDetailViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100.0)
    }
    

}
