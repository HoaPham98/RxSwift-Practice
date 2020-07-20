//
//  RecipeInfoViewController.swift
//  Delicious
//
//  Created by HoaPQ on 7/9/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import SnapKit
import MBSegmentControl
import MagicalRecord
import RxDataSources

final class RecipeInfoViewController: UIViewController, BindableType {

    @IBOutlet weak var tableView: HeaderTableView!
    @IBOutlet weak var navigationBackground: UIView!
    @IBOutlet weak var headerHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var refreshControl: RefreshControl!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var headerView: RecipeHeaderView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addToShoppingButton: UIButton!
    @IBOutlet weak var shoppingViewBottomConstraint: NSLayoutConstraint!

    private let segmentControl = MBSegmentControl().then {
        var settings = MBSegmentStripSettings()
        settings.stripRange = .segment

        $0.selectedIndex = 0
        $0.backgroundColor = .white
        $0.style = .strip(settings)
        $0.segments = ["Nutritions", "Ingredients", "Instructions"].map { TextSegment(text: $0) }
    }

    var viewModel: RecipeInfoViewModel!

    private var navigationBarHeight: CGFloat = (Helpers.statusBarSize?.height ?? 0) + 44
    private var headerHeight: CGFloat = 150
    private var _isFavorite: Bool = false {
        didSet {
            let image = _isFavorite ? Icon.icFavoriteSelected : Icon.icFavorite
            favoriteButton.image = image
        }
    }

    private let favoriteTap = PublishSubject<Bool>()
    private let loadShopingListTrigger = PublishSubject<Void>()

    private var isShoppingButtonHidden: Binder<Bool> {
        return Binder(self) { (viewController, status) in
            viewController.animateShoppingButton(status: status)
        }
    }

    private var isFavorited: Binder<Bool> {
        return Binder(self) { (viewController, status) in
            viewController._isFavorite = status
        }
    }

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

    func configViews() {
        headerHeight = headerHeightConstraint.constant + navigationBarHeight
        headerTopConstraint.constant = -navigationBarHeight
        headerHeightConstraint.constant = headerHeight
        tableView.do {
            $0.register(cellType: NutritionTBCell.self)
            $0.register(cellType: IngredientTBCell.self)
            $0.register(cellType: StepTBCell.self)
            $0.tableHeaderView?.frame = CGRect(x: 0,
                y: 0,
                width: $0.width,
                height: headerHeight - navigationBarHeight + 44)
            $0.tableFooterView = UIView(frame: CGRect(x: 0,
                y: 0,
                width: tableView.width,
                height: .leastNonzeroMagnitude))
            $0.contentInset = UIEdgeInsets(top: navigationBarHeight,
                left: 0,
                bottom: 0,
                right: 0)
            $0.rx.setDelegate(self).disposed(by: rx.disposeBag)
        }
        refreshControl.do {
            $0.setMaxHeightOfRefreshControl = headerHeight
            $0.scrollView = tableView
        }

        view.bringSubviewToFront(navigationBackground)
        view.addSubview(segmentControl)
        segmentControl.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(headerView.snp.bottom)
            $0.height.equalTo(44)
        }

        addToShoppingButton.do {
            $0.applyCornerRadius(radius: 15)
            $0.applyShadowWithColor(color: .black, opacity: 0.6, radius: 7)
        }
    }

    private func animateShoppingButton(status: Bool) {
        if !status {
            shoppingViewBottomConstraint.constant = 16
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        } else {
            shoppingViewBottomConstraint.constant = -150
            UIView.animate(withDuration: 0.25) {
                self.view.layoutIfNeeded()
            }
        }
    }

    private func configNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    func bindViewModel() {
        let dataSource = RxTableViewSectionedReloadDataSource<RecipeTableViewSection>(
            configureCell: { (dataSource, tableView, indexPath, _) -> UITableViewCell in
                switch dataSource[indexPath] {
                case .nutrientItem(let item):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: NutritionTBCell.self)
                    cell.setData(data: item)
                    return cell
                case .ingredientItem(let item):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: IngredientTBCell.self)
                    cell.setUp(data: item)
                    return cell
                case .stepItem(let step):
                    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: StepTBCell.self)
                    cell.setUp(data: step)
                    return cell
                }
            }, titleForHeaderInSection: { (section, index) in
                switch section.sectionModels[index] {
                case .stepItem:
                    return "Method \(index + 1)"
                default:
                    return ""
                }
            })

        let input = RecipeInfoViewModel.Input(
            loadTrigger: Driver.just(()),
            reloadTrigger: refreshControl.refreshTrigger,
            favoriteTrigger: favoriteButton.rx.tap.map { _ in return !self._isFavorite }.asDriverOnErrorJustComplete(),
            segmentTrigger: segmentControl.rx.selectedSegmentIndex.asDriver(),
            loadShoppingListTrigger: loadShopingListTrigger.asDriverOnErrorJustComplete(),
            addToShoppingListTrigger: addToShoppingButton.rx.tap.asDriver())

        let output = viewModel.transform(input)

        output.isLoading.drive(rx.isLoading).disposed(by: rx.disposeBag)
        output.isReloading.drive(refreshControl.isRefreshing).disposed(by: rx.disposeBag)
        output.error.drive(rx.error).disposed(by: rx.disposeBag)
        output.recipe
            .drive(headerView.recipe)
            .disposed(by: rx.disposeBag)
        output.title.drive(titleLabel.rx.text).disposed(by: rx.disposeBag)
        output.dataSource
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: rx.disposeBag)
        output.shoppingButtonHidden
            .drive(isShoppingButtonHidden)
            .disposed(by: rx.disposeBag)
        output.isFavorited.drive(isFavorited).disposed(by: rx.disposeBag)
        output.tapShopingList.do(onNext: { [weak self] _ in
            self?.loadShopingListTrigger.onNext(())
            self?.showAlertConfirm(title: "Success", message: "Added to shoping list!")
        }).drive().disposed(by: rx.disposeBag)
    }
}

extension RecipeInfoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        let alpha = offset / (headerHeight - navigationBarHeight * 2)
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
