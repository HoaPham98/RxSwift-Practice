//
//  CustomRefreshControl.swift
//  Delicious
//
//  Created by HoaPQ on 7/13/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RefreshControl: UIView {

    // MARK: - properties

    //enum for observers
    enum Observer {
        case contentOffset
        case panGesture
    }

    //enum for radius of refresh circle
    enum RefreshCircleSize: CGFloat {
        case small = 12.0
        case medium = 17.0
        case large = 22.0
    }

    /// indicates refreshing status
    private var refreshingStatus = false

    let bag = DisposeBag()

    // MARK: - layers
    private let indicator = UIActivityIndicatorView().then {
        $0.hidesWhenStopped = true
        $0.style = .medium
        $0.color = .white
    }

    // MARK: - points on path of border

    ///content offset of scroll view that  keeps updated according to scroll detected
    private var scrollViewContentYOffset: CGFloat = 0

    ///dynamic xposition of panGesture over scroll view
    private var xPositionOfPan: CGFloat = 0

    /// y offset for middle bottom point
    private var middleBottomPointYOffset: CGFloat = 0

    /// center point for circle
    private var centerForCircle: CGPoint = CGPoint(x: 0, y: 0)

    ///threshold drag value
    private var thresholdDrag: CGFloat = 130

    ///maximum height of refresh control
    private var maxHeightOfRefreshControl: CGFloat = 170

    ///called when user refresh is triggered
    private var _onRefreshing: () -> Void = {
        debugPrint("refresh triggerd. Implement setOnRefreshing of RefreshControl to call your own function.")
    }
    
    private var initialInset: CGFloat = 0

    // MARK: - set
    ///set maxHeight of refreshControl. minimum is 130
    var setMaxHeightOfRefreshControl: CGFloat = 0 {
        didSet {
            maxHeightOfRefreshControl = max(setMaxHeightOfRefreshControl, 170)
        }
    }

    //set function to be called after refresh is triggerd
    var onRefreshing: () -> Void = { } {
        didSet {
            _onRefreshing = onRefreshing
        }
    }

    ///return super view as scroll view. may be table view or collection view too. if superView doesnot exist then return nil
    var scrollView: UIScrollView? {
        didSet {
            guard let scrollView = scrollView else { return }
            initialInset = scrollView.contentInset.top
            addObserver(.contentOffset)
            addObserver(.panGesture)
        }
    }
    
    private var containerScrollView: UIScrollView? {
        return scrollView != nil ? scrollView : superview as? UIScrollView
    }
    
    // Rx
    var isRefreshing: Binder<Bool> {
        return Binder(self) { (view, loading) in
            if loading {
                
            } else {
                view.endRefreshing()
            }
        }
    }
    
    private var _refreshTrigger = PublishSubject<Void>()
    
    var refreshTrigger: Driver<Void> {
        return _refreshTrigger.asDriver(onErrorJustReturn: ())
    }

    // MARK: - initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addObserver(.contentOffset)
        addObserver(.panGesture)
    }

    // MARK: - common init
    private func commonInit() {
        addSubview(indicator)
    }

    // MARK: - draw rect
    override func draw(_ rect: CGRect) {

        guard let _ = containerScrollView else { return }
        calculate(rect)

        if !refreshingStatus {
            indicator.startAnimating()
        }
    }

    // MARK: - observers
    /// Add scroll view content y offset and scroll view panGesture observers
    /// - Parameter observer: RefreshControl.Observer type
    private func addObserver(_ observer: Observer) {
        guard let scrollView = containerScrollView else { return }

        switch observer {
        case .contentOffset:
            scrollView.rx.contentOffset.bind(onNext: { [weak self] offset in
                self?.scrollViewContentYOffset = -offset.y
                self?.setNeedsDisplay()
            }).disposed(by: bag)

        case .panGesture:
            scrollView.panGestureRecognizer.rx.event.bind(onNext: { [weak self] panGesture in
                guard let `self` = self else { return }
                self.xPositionOfPan = panGesture.location(in: self.containerScrollView).x
                self.setNeedsDisplay()

                switch panGesture.state {
                case .cancelled, .failed, .ended:
                    if self.scrollViewContentYOffset > self.thresholdDrag {
                        self.refreshingStatus = true
                        self.setNeedsDisplay()
                        self.indicator.startAnimating()
                        self._onRefreshing()
                        self._refreshTrigger.onNext(())
                    }
                default:
                    break
                }
            }).disposed(by: bag)
        }
    }

    // MARK: - calculation
    private func calculate(_ rect: CGRect) {
        guard scrollViewContentYOffset >= 0 else {
            middleBottomPointYOffset = initialInset
            return
        }
        if !refreshingStatus {
            middleBottomPointYOffset = min(scrollViewContentYOffset, maxHeightOfRefreshControl) - 20 - initialInset
        } else {
            middleBottomPointYOffset = min(scrollViewContentYOffset, thresholdDrag)
        }
        centerForCircle = CGPoint(x: rect.midX, y: middleBottomPointYOffset)
        indicator.frame = CGRect(x: centerForCircle.x, y: centerForCircle.y, width: 0, height: 0)
    }

    func endRefreshing() {
        indicator.stopAnimating()
        refreshingStatus = false
    }
}
