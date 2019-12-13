//
//  CategoryCell.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/12/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell {

    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(user:Article) {
        
        avatarImage.image = UIImage(named: user.avatar)
        
        descriptionLabel.text = user.description
        nameLabel.text = user.name
    
    }

}
