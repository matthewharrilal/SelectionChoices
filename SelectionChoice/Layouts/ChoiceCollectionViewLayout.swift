//
//  ChoiceCollectionViewLayout.swift
//  SelectionChoice
//
//  Created by Space Wizard on 8/6/24.
//

import Foundation
import UIKit

class ChoiceCollectionViewLayout: UICollectionViewLayout {
    
    enum Constants {
        static let itemWidth: CGFloat = 100
        static let itemHeight: CGFloat = 75
        static let spacing: CGFloat = 25
        static let contentInset: CGFloat = 16
    }
    
    private var cache: [UICollectionViewLayoutAttributes] = []
    private var contentHeight: CGFloat = 0
    
    private var contentWidth: CGFloat {
        collectionView?.bounds.width ?? 0
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        
        contentHeight = 0
        cache.removeAll()
        
        let numberOfSections = collectionView.numberOfSections
        let numberOfItems = collectionView.numberOfItems(inSection: numberOfSections - 1)
        
        let itemSize = CGSize(
            width: Constants.itemWidth, 
            height: Constants.itemHeight
        )
        
        // Calculate the available width minus the left/right margins
        let availableWidth: CGFloat = contentWidth - (Constants.contentInset * 2)
        
        // Given the available width calculate the number of items
        // Divide the available width by the size of the item and it's corresponding spacing
        let numberOfItemsPerRow: CGFloat = (availableWidth + Constants.contentInset) / (itemSize.width + Constants.spacing)
        
        // Initial offsets for the first item
        var xOffset: CGFloat = Constants.contentInset
        var yOffset: CGFloat = Constants.contentInset
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: numberOfSections - 1)
            
            if item != 0 && item % Int(numberOfItemsPerRow) == 0 {
                xOffset = Constants.contentInset
                yOffset += itemSize.height + Constants.spacing
            }
            
            let frame = CGRect(x: xOffset, y: yOffset, width: itemSize.width, height: itemSize.height)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = frame
            
            cache.append(attributes)
            xOffset += Constants.spacing + itemSize.width
        }
        
        contentHeight += yOffset + Constants.spacing
    }
    
    override var collectionViewContentSize: CGSize {
        CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        super.layoutAttributesForElements(in: rect)
        
        return cache.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        super.layoutAttributesForItem(at: indexPath)
        
        return cache.first { $0.indexPath == indexPath }
    }
}
