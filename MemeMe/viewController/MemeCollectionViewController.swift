//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 12/4/20.
//

import UIKit

class MemeCollectionViewController: UIViewController{
    
    var memeMes: [Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memeMes
    }
    
    @IBOutlet weak var layoutFlow: UICollectionViewFlowLayout!
    @IBOutlet weak var memeCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeCV.dataSource = self
        memeCV.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        
        //set the title for the view
        navigationItem.title = "Sent Memes"
        
        // Register cell classes
        memeCV.register(UINib(nibName: K.Cell.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: K.Cell.collectionCellIdentifier)
        
        setCollectionViewFlowLayout()
    }
    
    /*
     code content is
     credited to Udacity
     provided to fix the
     layout flow on the collection view
     */
    func setCollectionViewFlowLayout() {
        let space:CGFloat = 3.0
        let dimension = (view.frame.size.width - (2 * space)) / 3.0
        
        layoutFlow.minimumInteritemSpacing = space
        layoutFlow.minimumLineSpacing = space
        layoutFlow.itemSize = CGSize(width: dimension, height: dimension)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeCV.reloadData()
    }
    
    @objc func addMeme(){
        let addNewMemeMe = storyboard?.instantiateViewController(identifier: K.ViewControllerID.addNewMemeVCID) as! MemeMeVC
        navigationController?.pushViewController(addNewMemeMe, animated: true)
    }
}

extension MemeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeMes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memeMes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.collectionCellIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = meme.memeImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meme = memeMes[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(identifier: K.ViewControllerID.detailsViewControllerID) as! MemeDetailsViewController
        detailVC.memeMeDetail = meme
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

