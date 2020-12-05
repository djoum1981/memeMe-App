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
    
    var itemSize: CGSize = CGSize(width: 0, height: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeCV.dataSource = self
        memeCV.delegate = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        
        //set the title for the view
        navigationItem.title = "Sent Memes"
        
        // Register cell classes
        memeCV.register(UINib(nibName: K.Cell.collectionViewCellNibName, bundle: nil), forCellWithReuseIdentifier: K.Cell.collectionCellIdentifier)
        
        setCollectionViewFlowFromDelegate()
    }
    
    
    //this algorith for flow layout is
    //credited to Todd Perkins in
    // IOS Developement Essential Training from
    //Lynda.com
    func setCollectionViewFlowFromDelegate() {
        if let layout = layoutFlow.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout{
            let itemPerRow: CGFloat = 4
            let padding: CGFloat = 5
            let totalPadding: CGFloat = padding * (itemPerRow - 1)
            let paddingForEach: CGFloat = totalPadding / itemPerRow
            let width = (layoutFlow.collectionView?.frame.width)! / itemPerRow - paddingForEach
            let height = width
            layout.minimumLineSpacing = padding
            layout.minimumInteritemSpacing = 0
            layout.estimatedItemSize = itemSize
            itemSize = CGSize(width: width, height: height)
        }
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

extension MemeCollectionViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memeMes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let meme = memeMes[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.Cell.collectionCellIdentifier, for: indexPath) as! MemeCollectionViewCell
        cell.memeImage.image = meme.memeImage
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return itemSize
    }
    
}

