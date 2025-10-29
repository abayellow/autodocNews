//
//  CollectionViewFactory.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import UIKit

struct CollectionViewFactory {
    static func makeNewsCollectionView(delegate: UICollectionViewDelegate) -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: NewsCollectionLayout.createLayout())
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = delegate
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }
}
