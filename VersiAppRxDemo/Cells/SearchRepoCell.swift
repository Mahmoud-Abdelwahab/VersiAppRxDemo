//
//  SearchRepoCell.swift
//  VersiAppRxDemo
//
//  Created by Asis on 3/21/21.
//

import UIKit

class SearchRepoCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoNameLable: UILabel!
    @IBOutlet weak var repoDescriptionLable: UILabel!
    @IBOutlet weak var numberOfForksLable: UILabel!
    @IBOutlet weak var languageLable: UILabel!
    static let identifier = "SearchRepoCell"
    
    
    func configureCell(item: Item){
     
        languageLable.text             = item.language
        numberOfForksLable.text       = String(item.forksCount ?? 0)
        repoNameLable.text             = item.name
        repoDescriptionLable.text       = item.itemDescription
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
