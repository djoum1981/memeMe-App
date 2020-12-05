//
//  MemeDetailsViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 12/4/20.
//

import UIKit

class MemeDetailsViewController: UIViewController {
    
    @IBOutlet weak var memeDetailImageView: UIImageView!
    var memeMeDetail: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "MemeMe Detail"
        
        if let meme = memeMeDetail{
            memeDetailImageView.image = meme.memeImage
        }
    }
    

   

}
