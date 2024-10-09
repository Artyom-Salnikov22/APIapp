//
//  TableViewCell.swift
//  appapi
//
//  Created by Артём Сальников on 05.10.2024.
//

import UIKit
import SDWebImage

class TableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var InfoLabel: UILabel!
    @IBOutlet weak var liveLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var pictureImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData1(character: Characters) {
        nameLabel.text = character.name
        InfoLabel.text = "\(character.status) - \(character.species)"
        genderLabel.text = "Gender: \(character.gender)"
        
        pictureImageView.sd_setImage(with: URL(string: character.image), completed: nil)
    }
    
    func setData2(location: Location) {
        liveLabel.text = "Live in: \(location.name)"
    }

}
