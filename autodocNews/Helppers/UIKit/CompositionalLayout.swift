//
//  CompositionalLayout.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import UIKit

struct NewsCollectionLayout {
    static func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment -> NSCollectionLayoutSection? in
            
            let isPad = environment.traitCollection.userInterfaceIdiom == .pad
            
            let groupWidthFraction: CGFloat
            let sectionInsets: NSDirectionalEdgeInsets
            
            if !isPad {
                groupWidthFraction = 1.0
                sectionInsets = .zero
            } else {
                groupWidthFraction = 1.0
                sectionInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            }
            
            // Item
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                  heightDimension: .fractionalHeight(1.0))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .zero
            
            // Group
            let groupHeight = environment.container.effectiveContentSize.width * 0.6
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(groupWidthFraction),
                                                   heightDimension: .absolute(groupHeight))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
            
            // Section
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = sectionInsets
            section.interGroupSpacing = 12
            
            return section
        }
        
        return layout
    }
}
