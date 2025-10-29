//
//  NewsViewController + Ext.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import UIKit

extension NewsViewController {
    func makeCollectionView() -> UICollectionView {
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: NewsCollectionLayout.createLayout())
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
}
