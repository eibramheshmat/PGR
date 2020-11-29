//
//  ReposMainListTableViewCell.swift
//  PGR
//
//  Created by Ibram on 26/11/2020.
//  Copyright © 2020 Ibram. All rights reserved.
//

import UIKit
import Kingfisher

class ReposMainListTableViewCell: UITableViewCell {

    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoOwnerName: UILabel!
    @IBOutlet weak var repoOwnerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    func fillCellData(cellData: ReposModel){
        repoName.text = cellData.name
        repoOwnerName.text = cellData.owner.login
        repoOwnerImage.kf.setImage(with: URL(string: cellData.owner.avatar_url ?? ""))
    }
    
}
