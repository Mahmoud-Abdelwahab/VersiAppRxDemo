//
//  TrendingRepoCell.swift
//  VersiAppRxDemo
//
//  Created by Mahmoud Abdul-Wahab on 20/03/2021.
//

import UIKit
import Kingfisher

class TrendingRepoCell: UITableViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoImage: UIImageView!
    
    @IBOutlet weak var numberoFContributorsLable: UILabel!
    @IBOutlet weak var languageLable: UILabel!
    @IBOutlet weak var numberofForkeslable: UILabel!
    @IBOutlet weak var repoDesriptionLable: UILabel!
    @IBOutlet weak var repoNameLable: UILabel!
    @IBOutlet weak var viewReadmeBtn: RoundedButton!
    
    private var repoUrl: String?
    
    func configureCell(item: Item){
        numberoFContributorsLable.text = String(item.watchersCount ?? 0)
        languageLable.text             = item.language
        numberofForkeslable.text       = String(item.forksCount ?? 0)
        repoNameLable.text             = item.name
        repoDesriptionLable.text       = item.itemDescription
        
        guard  let imageUrl = item.owner?.avatarURL ,  let url = URL(string:imageUrl) else  {
                return
            }
            
        repoImage.kf.setImage(with: url)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        backView.layer.cornerRadius = 16
        backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
      //  backView.layer.opacity        = 0.25
     //   backView.layer.shadowRadius  = 5.0
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}
