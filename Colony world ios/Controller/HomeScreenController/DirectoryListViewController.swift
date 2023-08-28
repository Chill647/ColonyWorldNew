//
//  DirectoryListViewController.swift
//  Colony world ios
//
//  Created by Futuretek on 25/01/23.
//

import UIKit
//
//class DirectoryListViewController: UIViewController {
//    @IBOutlet var mCollectionView: UICollectionView!
//    @IBOutlet var mTableView: UITableView!
//    let layout = UICollectionViewFlowLayout()
//    let DirectoryList = ["RESIDENT", "OWNER", "SOCIETY INCHARGE","BLOCK INCHARGE",]
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//      //  UpdateNavigationBar()
//        self.mCollectionView.delegate = self
//        self.mCollectionView.dataSource = self
//        layout.scrollDirection = .horizontal
//        self.mTableView.delegate = self
//        self.mTableView.dataSource = self
////        layout.minimumLineSpacing = 2
////        layout.minimumInteritemSpacing = 5
//        mCollectionView.setCollectionViewLayout(layout, animated: true)
//        mCollectionView.register(UINib(nibName: "DirectoryListCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DirectoryListCollectionViewCell")
//        mTableView.register(UINib(nibName: "DirectoryListTableViewCell", bundle: nil), forCellReuseIdentifier: "DirectoryListTableViewCell")
//    }
//
//}
//extension DirectoryListViewController:UICollectionViewDelegate,UICollectionViewDataSource{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return DirectoryList.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = mCollectionView.dequeueReusableCell(withReuseIdentifier: "DirectoryListCollectionViewCell", for: indexPath) as! DirectoryListCollectionViewCell
//        cell.labelTxt.text = DirectoryList[indexPath.row]
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView,
//      didSelectItemAt indexPath: IndexPath) {
//        print("Cell \(indexPath.row + 1) clicked")
//      }
//    
//}
//
//extension DirectoryListViewController:UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let widthPerItem = mCollectionView.frame.width / 4 - layout.minimumInteritemSpacing
//        return CGSize(width:170, height: 35)
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//   }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//   }
//    
//}
////-------------------------TableViewCell----------------------------//
//
//extension DirectoryListViewController:UITableViewDelegate,UITableViewDataSource{
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//     return 4
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = mTableView.dequeueReusableCell(withIdentifier: "DirectoryListTableViewCell", for: indexPath) as! DirectoryListTableViewCell
//        return cell ??  UITableViewCell()
//        return UITableViewCell()
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 250
//    }
//
//}
//
//
