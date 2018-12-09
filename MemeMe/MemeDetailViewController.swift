//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by macbook-rhla on 09/12/18.
//  Copyright © 2018 ORIONOSCODE. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var memeImage: UIImageView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        memeImage.image = meme.finalImage
    }

}
