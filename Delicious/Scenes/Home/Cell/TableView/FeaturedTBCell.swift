//
//  FeaturedTBCell.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import Reusable
import RxSwift
import RxCocoa

final class FeaturedTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: FeaturedCLCell.self)
        }
    }
    
    func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        collectionView.do {
            $0.delegate = dataSourceDelegate
            $0.dataSource = dataSourceDelegate
            $0.setContentOffset(collectionView.contentOffset, animated: false)
            $0.reloadData()
        }
    }
}
