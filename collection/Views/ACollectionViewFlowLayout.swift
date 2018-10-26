//
//  ACollectionViewFlowLayout.swift
//  collection
//
//  Created by 薛永伟 on 2018/10/24.
//  Copyright © 2018年 薛永伟. All rights reserved.
//

import UIKit

class ADecorationView: UICollectionReusableView {
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let att = layoutAttributes as? ACollectionViewLayoutAttributes {
            self.backgroundColor =  att.bgColor
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        customSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customSubviews()
    }
    func customSubviews(){
        self.layer.cornerRadius = 10
    }
}
class ACollectionViewLayoutAttributes: UICollectionViewLayoutAttributes{
    var bgColor = UIColor.white
}


protocol ACollectionViewDelegateFlowLayout: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, backgroundColorForSectionAt section: Int) -> UIColor
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, topOffSetAt section: Int) -> CGFloat
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, bottomOffSetAt section: Int) -> CGFloat
}

class ACollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    fileprivate var decorationAtts = [ACollectionViewLayoutAttributes]()
    
    override func prepare() {
        super.prepare()
        
        
        self.register(ADecorationView.self, forDecorationViewOfKind: "ADecorationView")
        
        guard let deleagte = self.collectionView?.delegate as? ACollectionViewDelegateFlowLayout,let numberOfSections = self.collectionView?.numberOfSections else { return  }
        
        decorationAtts.removeAll()
        for section in 0..<numberOfSections {
            guard let numberOfItems = self.collectionView?.numberOfItems(inSection: section),numberOfItems > 0 ,
            let firstItem = self.layoutAttributesForItem(at: IndexPath.init(item: 0, section: section)),
            let lastItem = self.layoutAttributesForItem(at: IndexPath.init(item: numberOfItems - 1, section: section))
            else {continue}
            
            var sectionInset = self.sectionInset
            
            if let inset = deleagte.collectionView?(self.collectionView!, layout: self, insetForSectionAt: section){
                sectionInset = inset
            }
            var sectionFrame = firstItem.frame.union(lastItem.frame)
            sectionFrame.origin.x = 0
            
            if scrollDirection == .horizontal {
                sectionFrame.size.width += (sectionInset.left + sectionInset.right)
                sectionFrame.size.height = collectionViewContentSize.height
            }else{
                sectionFrame.size.width = collectionViewContentSize.width
                sectionFrame.size.height += (sectionInset.top + sectionInset.bottom)
            }
            
            
            let headerOffset = deleagte.collectionView(self.collectionView!, layout: self, topOffSetAt: section)
            sectionFrame.origin.y -=  headerOffset
            sectionFrame.size.height += headerOffset
            
            
            
            let footerOffset = deleagte.collectionView(self.collectionView!, layout: self, bottomOffSetAt: section)
            sectionFrame.size.height += footerOffset
            
            let newAtt = ACollectionViewLayoutAttributes(forDecorationViewOfKind: "ADecorationView", with: IndexPath(item: 0, section: section))
            newAtt.frame = sectionFrame
            newAtt.zIndex = -1
            
            newAtt.bgColor = deleagte.collectionView(self.collectionView!, layout: self, backgroundColorForSectionAt: section)
            
            decorationAtts.append(newAtt)
        }
        
    }
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attrs = super.layoutAttributesForElements(in: rect)
        let bgAtts = self.decorationAtts.filter({ (att) -> Bool in
            return rect.intersects(att.frame)
        })
        attrs?.append(contentsOf: bgAtts)
//        attrs?.append(contentsOf: self.decorationAtts.filter(
//            return rect.intersects(att.frame)
//        }))
//
//        var attrs = [UICollectionViewLayoutAttributes]()
//
//        if let olds = super.layoutAttributesForElements(in: rect) {
//            attrs.append(contentsOf: olds)
//        }
//        for att in attrs {
//            if att.representedElementKind == nil && att.frame.origin.x == self.sectionInset.left {
//                let decorationAttributes = ACollectionViewLayoutAttributes.init(forDecorationViewOfKind: "ADecorationView", with: att.indexPath)
//
////                if let collection = self.collectionView ,
////                    let color = self.delegate?.collectionBgColor(for: collection, layout: self, atSectionAt: att.indexPath.section)
////                {
////                    decorationAttributes.bgColor = color
////                }
//
//                decorationAttributes.bgColor = UIColor.lightGray
//                decorationAttributes.frame = CGRect.init(x: 0, y: att.frame.origin.y-(self.sectionInset.top), width: self.collectionViewContentSize.width, height: self.itemSize.height + self.sectionInset.top + self.sectionInset.bottom + self.minimumLineSpacing)
//                decorationAttributes.zIndex = att.zIndex - 1
//                attrs.append(decorationAttributes)
//            }
//        }
        
        return attrs
    }
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
//    override func shouldInvalidateLayout(forPreferredLayoutAttributes preferredAttributes: UICollectionViewLayoutAttributes, withOriginalAttributes originalAttributes: UICollectionViewLayoutAttributes) -> Bool {
//        <#code#>
//    }
}
