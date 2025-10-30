//
//  UICollectionView + Ext.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import UIKit

extension UICollectionView {
    func makeDiffableDataSource<Cell: UICollectionViewCell, Item: Hashable>(
        cellProvider: @escaping (UICollectionView, IndexPath, Item) -> Cell
    ) -> UICollectionViewDiffableDataSource<Int, Item> {
        let dataSource = UICollectionViewDiffableDataSource<Int, Item>(collectionView: self, cellProvider: cellProvider)
        return dataSource
    }
    
    func applySnapshot<Item: Hashable>(_ items: [Item], dataSource: UICollectionViewDiffableDataSource<Int, Item>?) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(items)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }
}
