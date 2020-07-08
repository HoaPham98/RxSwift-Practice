//
//  HomeViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/8/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import NSObject_Rx
import MGArchitecture
import Reusable

final class HomeViewController: UIViewController, BindableType {
    @IBOutlet weak private var tableView: UITableView!

    var viewModel: HomeViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configView()
        configTableView()
    }

    func configView() {
        navigationItem.title = "Delicous"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    func configTableView() {
        tableView.do {
            $0.register(cellType: FeaturedTBCell.self)
            $0.register(cellType: RecipeTBCell.self)
            $0.estimatedRowHeight = UITableView.automaticDimension
            $0.delegate = self
            $0.dataSource = self
        }
    }

    func bindViewModel() {
        
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.home
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: FeaturedTBCell.self).then {
                $0.setCollectionViewDataSourceDelegate(dataSourceDelegate: self)
            }

            return cell
        default:
            let cell = tableView.dequeueReusableCell(
                for: indexPath,
                cellType: RecipeTBCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 160 : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeTableHeaderView.loadFromNib()
        header.setUp(title: section == 0 ? "FEATURED" : "LASTEST")
        
        return header
    }
}

//MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: FeaturedCLCell.self)
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = 160
        let width = height / 393 * 636
        return CGSize(width: width, height: height)
    }
}
