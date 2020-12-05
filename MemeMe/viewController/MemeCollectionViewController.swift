//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 12/4/20.
//

import UIKit

class MemeCollectionViewController: UIViewController{

    @IBOutlet weak var memeCV: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
      
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        
        //set the title for the view
        navigationItem.title = "Sent Memes"
        
        // Register cell classes
        memeCV.register(MemeCollectionViewCell.self, forCellWithReuseIdentifier: K.Cell.collectionCellIdentifier)
    }

    @objc func addMeme(){
        let addNewMemeMe = storyboard?.instantiateViewController(identifier: K.ViewControllerID.addNewMemeVCID) as! MemeMeVC
        navigationController?.pushViewController(addNewMemeMe, animated: true)
    }
}

extension MemeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.collectionCellIdentifier, for: indexPath) as! MemeCollectionViewCell
        return cell
    }
    
    
}
