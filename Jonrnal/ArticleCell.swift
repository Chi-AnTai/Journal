//
//  ArticleCell.swift
//  Jonrnal
//
//  Created by 戴其安 on 2017/8/4.
//  Copyright © 2017年 戴其安. All rights reserved.
//

import Foundation
import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!

    @IBOutlet weak var artiecleTitleLabel: UILabel!


}

struct article {
    var title: String
    var content: String
    var image: UIImage
}
