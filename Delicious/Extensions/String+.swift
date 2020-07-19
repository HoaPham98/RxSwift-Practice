//
//  String+.swift
//  Delicious
//
//  Created by HoaPQ on 7/18/20.
//  Copyright © 2020 HoaPQ. All rights reserved.
//

extension String {
    func textSize(font: UIFont?, collectionView: UICollectionView) -> CGSize {
        var frame = collectionView.bounds
        frame.size.height = 9999.0
        let label = UILabel()
        label.numberOfLines = 0
        label.text = self
        label.font = font
        var size = label.sizeThatFits(frame.size)
        size.height = max(54, size.height)
        return size
    }
}
