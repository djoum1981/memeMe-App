//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Julien Laurent on 12/4/20.
//

import UIKit
class MemeTableViewController: UIViewController {

    @IBOutlet weak var memeMeTV: UITableView!
    
    var memeMes: [Meme]!{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.memeMes
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        memeMeTV.delegate = self
        memeMeTV.dataSource = self
        
        //self.navigationItem.leftBarButtonItem = self.editButtonItem
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addMeme))
        
        //set the title for the view
        navigationItem.title = "Sent Memes"
        
        //self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: K.cell.tableCellIdentifier)
        memeMeTV.register(UINib(nibName: K.Cell.tableViewCellNibName, bundle: nil), forCellReuseIdentifier: K.Cell.tableCellIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        memeMeTV.reloadData()
    }
    
    @objc func addMeme(){
        let addNewMemeMe = storyboard?.instantiateViewController(identifier: K.ViewControllerID.addNewMemeVCID) as! MemeMeVC
        navigationController?.pushViewController(addNewMemeMe, animated: true)
    }
}

extension MemeTableViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memeMes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meme = self.memeMes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Cell.tableCellIdentifier, for: indexPath) as! MemeTableViewCell
        cell.memeTableCellLabel.text = meme.topText
        cell.memeTableCellImage.image = meme.memeImage
        return cell
    }
}
