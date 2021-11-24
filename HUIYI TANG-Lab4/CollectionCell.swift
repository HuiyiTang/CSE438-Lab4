//
//  CollectionCell.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 10/22/21.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    let title = UILabel(frame: CGRect(x: 0, y: 80, width: 80, height: 40))
    let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 80, height: 120))
        
    override func prepareForReuse() {
        super.prepareForReuse()
        title.removeFromSuperview()
        image.removeFromSuperview()
    }
}
