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
import RxDataSources

final class FeaturedTBCell: UITableViewCell, NibReusable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var data = PublishSubject<[RecipeInformation]>()
    
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    var selectedRecipe: ((RecipeInformation) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.do {
            $0.register(cellType: FeaturedCLCell.self)
            $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
            data.bind(to: $0.rx.items(cellIdentifier: FeaturedCLCell.reuseIdentifier, cellType: FeaturedCLCell.self)) { indexPath, recipe, cell in
                cell.setInfo(with: recipe)
            }.disposed(by: rx.disposeBag)
            $0.rx.modelSelected(RecipeInformation.self).subscribe {
                switch $0 {
                case .next(let recipe):
                    self.selectedRecipe?(recipe)
                default:
                    return
                }
            }.disposed(by: rx.disposeBag)
        }
    }
    
    func setData(data: [RecipeInformation]) {
        self.data.onNext(data)
    }
}

extension FeaturedTBCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 160
        let width = height / 393 * 636
        return CGSize(width: width, height: height)
    }
}
