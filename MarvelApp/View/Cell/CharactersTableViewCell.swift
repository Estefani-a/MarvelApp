//
//  CharactersTableViewCell.swift
//  MarvelApp
//
//  Created by Estefania Sassone on 21/07/2022.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    
    var character: Character? {
        didSet {
            guard let character = character else { return }
            charactersNameLabel?.text = character.name
            
            guard let characterImageUrl = character.thumbnail.path else { return }
            let thumbnailExtension = character.thumbnail.thumbnailExtension.rawValue
            
            charactersImageView?.loadImage(urlString: characterImageUrl + "." + thumbnailExtension)
        }
    }
    
    @IBOutlet weak var charactersImageView: ImageViewCache?
    @IBOutlet weak var charactersNameLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
