//
//  LeftAlignedLayout.swift
//  Delicious
//
//  Created by HoaPQ on 7/19/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

import Foundation

//extension UICollectionViewLayoutAttributes {
//    func leftAlignFrame(withSectionInset sectionInset: UIEdgeInsets) {
//        let frame = self.frame
//        self.frame.origin.x = sectionInset.left
//        self.frame = frame
//    }
//}
//
//protocol UICollectionViewDelegateLeftAlignedLayout: UICollectionViewDelegateFlowLayout {
//    
//}
//
//class UICollectionViewLeftAlignedLayout : UICollectionViewFlowLayout {
//    // MARK: - UICollectionViewLayout
//    func layoutAttributesForElements(in rect: CGRect) -> [AnyHashable]? {
//        let originalAttributes = super.layoutAttributesForElements(in: rect)
//        var updatedAttributes: [UICollectionViewLayoutAttributes]? = nil
//        if let originalAttributes = originalAttributes {
//            updatedAttributes = originalAttributes
//        }
//        for attributes in originalAttributes ?? [] {
//            if attributes.representedElementKind == nil {
//                let index = updatedAttributes?.firstIndex(of: attributes) ?? NSNotFound
//                updatedAttributes?[index] = layoutAttributesForItem(at: attributes.indexPath)!
//            }
//        }
//
//        return updatedAttributes
//    }
//    
//    override func layoutAttributesForItem(at indexPath: IndexPath?) -> UICollectionViewLayoutAttributes? {
//        var currentItemAttributes: UICollectionViewLayoutAttributes? = nil
//        guard let indexPath = indexPath, let collectionView = collectionView else { return nil }
//    
//        currentItemAttributes = super.layoutAttributesForItem(at: indexPath)
//        let sectionInset = evaluatedSectionInsetForItem(at: indexPath.section)
//
//        let isFirstItemInSection = indexPath.item == 0
//        let layoutWidth = collectionView.frame.width - sectionInset.left - sectionInset.right
//
//        if isFirstItemInSection {
//            currentItemAttributes?.leftAlignFrame(withSectionInset: sectionInset)
//            return currentItemAttributes
//        }
//
//        let previousIndexPath = IndexPath(item: indexPath.item - 1, section: indexPath.section)
//        guard let previousFrame = self.layoutAttributesForItem(at:previousIndexPath)?.frame else { return nil }
//        let previousFrameRightPoint: CGFloat = previousFrame.origin.x + previousFrame.size.width
//        let currentFrame = currentItemAttributes!.frame
//        let strecthedCurrentFrame = CGRect(x: sectionInset.left,
//                                           y: currentFrame.origin.y,
//                                           width: layoutWidth,
//                                           height: currentFrame.size.height)
//        // if the current frame, once left aligned to the left and stretched to the full collection view
//        // width intersects the previous frame then they are on the same line
//        let isFirstItemInRow = !previousFrame.intersects(strecthedCurrentFrame)
//
//        if (isFirstItemInRow) {
//            // make sure the first item on a line is left aligned
//            currentItemAttributes?.leftAlignFrame(withSectionInset:sectionInset)
//            return currentItemAttributes;
//        }
//
//        var frame = currentItemAttributes!.frame
//        frame.origin.x = previousFrameRightPoint + self.evaluatedMinimumInteritemSpacingForSection(at: indexPath.section);
//        currentItemAttributes!.frame = frame
//        return currentItemAttributes
//    }
//    
//    func evaluatedMinimumInteritemSpacingForSection(at sectionIndex: Int) -> CGFloat {
//        guard let collectionView = collectionView, let delegate = collectionView.delegate as? UICollectionViewDelegateLeftAlignedLayout else {
//            return minimumInteritemSpacing
//        }
//        
//        return delegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: sectionIndex) ?? 0.0
//    }
//    
//    func evaluatedSectionInsetForItem(at index: Int) -> UIEdgeInsets {
//        guard let collectionView = collectionView, let delegate = collectionView.delegate as? UICollectionViewDelegateLeftAlignedLayout else {
//            return sectionInset
//        }
//        return delegate.collectionView?(collectionView, layout: self, insetForSectionAt: index) ?? .zero
//    }
//}
//
//
//fileprivate class RowInformation {
//    var spacing: CGFloat
//    var cells: [UICollectionViewCell] = [] {
//        didSet {
//            width = cells.reduce(0.0, { $0 + $1.intrinsicContentSize.width })
//            if !cells.isEmpty {
//                width += CGFloat(cells.count - 1) * spacing
//            }
//        }
//    }
//    var width: CGFloat = 0.0
//    
//    init(spacing: CGFloat) {
//        self.spacing = spacing
//    }
//}
//
//extension UICollectionView {
//    func getOptimalCells(_ cells: [UICollectionViewCell], maxWidth: CGFloat) -> [UICollectionViewCell] {
//        var rows: [RowInformation] = []
//        let spacing = (self.collectionViewLayout
//            as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0
//        
//        var cellsCopy = cells
//        cellsCopy.sort(by: { $0.intrinsicContentSize.width > $1.intrinsicContentSize.width })
//        
//        cellsCopy.forEach { (cell) in
//            var isAdded: Bool = false
//            for row in rows {
//                if row.width + cell.intrinsicContentSize.width + spacing < maxWidth {
//                    row.cells.append(cell)
//                    isAdded = true
//                    break
//                }
//            }
//            if !isAdded {
//                let newRow = RowInformation(spacing: spacing)
//                newRow.cells.append(cell)
//                rows.append(newRow)
//            }
//        }
//        
//        cellsCopy = rows.reduce(into: [UICollectionViewCell](), { (cells, row) in
//            cells.append(contentsOf: row.cells)
//        })
//        
//        return cellsCopy
//    }
//}
