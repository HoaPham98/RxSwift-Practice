//
//  SearchViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/16/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation
import RxDataSources

class SearchViewController: UIViewController, BindableType {
    var viewModel: SearchViewModel!
    let searchBar: UISearchBar = UISearchBar().then {
        $0.searchTextField.textColor = .white
        $0.placeholder = "Search"
        $0.setImage(Icon.icSearch, for: .search, state: .normal)
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        collectionView.do {
            $0.register(cellType: TagCollectionViewCell.self)
            $0.register(supplementaryViewType: SearchCollectionViewHeader.self, ofKind: UICollectionView.elementKindSectionHeader)
            $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
            $0.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }
    }
    
    func bindViewModel() {
        let dataSource = RxCollectionViewSectionedReloadDataSource<SearchCollectionViewSection>(
            configureCell: {(data, collectionView, indexPath, _) -> UICollectionViewCell in
                switch data[indexPath] {
                case .tag(let tag):
                    let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TagCollectionViewCell.self)
                    cell.setData(text: tag.textString)
                    return cell
                default:
                    return UICollectionViewCell()
                }
        },
            configureSupplementaryView: { (data, collectionView, kind, indexPath) -> UICollectionReusableView in
                switch kind {
                case UICollectionView.elementKindSectionHeader:
                    switch data[indexPath] {
                    case .tag(let tag):
                        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, for: indexPath, viewType: SearchCollectionViewHeader.self)
                        view.setTitle(tag.typeString)
                        return view
                    default:
                        return UICollectionReusableView()
                    }
                default:
                    return UICollectionReusableView()
                }
                
        })
        
        let input = SearchViewModel.Input()
        let output = viewModel.transform(input)
        
        output.data.drive(collectionView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return Search.cuisines.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: TagCollectionViewCell.self)
//        cell.setData(text: Search.cuisines[indexPath.row])
//        return cell
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       // Pass parameter into this function according to your requirement
      return CGSize(width:collectionView.bounds.width , height: 38)

    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.search
}
