//
//  RecipeInfoViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Then
import NSObject_Rx
import MGArchitecture
import MGLoadMore
import Reusable
import SnapKit

final class RecipeInfoViewController: UIViewController, BindableType {
    
    @IBOutlet weak var tableView: RefreshTableView!
    @IBOutlet weak var navigationBackground: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    
    var viewModel: RecipeInfoViewModel!
    
    private var recipeId: Int = 0
    
    private var navigationBarHeight: CGFloat = (Helpers.statusBarSize?.height ?? 0) + 44
    private var headerHeight: CGFloat = 150
    private var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.navigationBar.do {
            $0.setBackgroundImage(nil, for: .default)
        }
    }
    
    func setUpData(id: Int) {
        recipeId = id
    }
    
    func configViews() {
        headerHeight = headerHeightConstraint.constant + navigationBarHeight
        tableView.do {
            $0.register(cellType: IngredientTBCell.self)
            $0.register(cellType: StepTBCell.self)
            $0.refreshFooter = nil
            $0.dataSource = self
            $0.delegate = self
            $0.contentInset = UIEdgeInsets(top: navigationBarHeight, left: 0, bottom: 0, right: 0)
        }
 
        view.bringSubviewToFront(navigationBackground)
    }
    
    private func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
    
    func bindViewModel() {
        let input = RecipeInfoViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: tableView.loadMoreTopTrigger,
            addToShoppingListTrigger: Driver.of())
        
        let output = viewModel.transform(input)
        
        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(tableView.isLoadingMoreTop).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.isReloading.drive(onNext: { (status) in
            print(status)
        }, onCompleted: nil, onDisposed: nil)
    }
    
    @IBAction func tapFavorite(_ sender: Any) {
        guard let button = sender as? UIBarButtonItem else { return }
        isFavorite = !isFavorite
        let image = isFavorite ? #imageLiteral(resourceName: "ic_favorites_grey") : #imageLiteral(resourceName: "ic_favorite")
        button.image = image
    }
}

extension RecipeInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        default:
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IngredientTBCell.self)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SegmentHeaderView.loadFromNib()
        header.setUp(titles: ["Nutritions", "Ingredients", "Instructions"])
        header.segmentControl.rx.selectedSegmentIndex.subscribe {
            print($0)
        }.disposed(by: rx.disposeBag)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let base = -navigationBarHeight
        if offset < base {
            headerTopConstraint.constant = offset
            headerHeightConstraint.constant = headerHeight + abs(base - offset)
        } else {
            let navBarOffset = navigationBarHeight + offset
            let imageBottom = base + headerHeight
            
            if navBarOffset >= imageBottom {
                headerTopConstraint.constant = base + abs(navBarOffset - imageBottom)
            } else {
                headerTopConstraint.constant = base
            }
            headerHeightConstraint.constant = headerHeight
        }
        let alpha = offset / (headerHeight - navigationBarHeight*2)
        if alpha < 1 {
            navigationBackground.alpha = alpha
        } else {
            navigationBackground.alpha = 1
        }
    }
}

extension RecipeInfoViewController: StoryboardSceneBased {
    static var sceneStoryboard: UIStoryboard = StoryBoards.recipeInfo
}
