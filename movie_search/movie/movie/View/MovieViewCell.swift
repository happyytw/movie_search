//
//  MovieViewCell.swift
//  movie
//
//  Created by Taewon Yoon on 2023/06/27.
//

import UIKit

class MovieViewCell: UITableViewCell {
    @IBOutlet var movieImage: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieSummery: UILabel!
    @IBOutlet var movieStart: UILabel!
    @IBOutlet var movieRate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        movieSummery.lineBreakMode = .byCharWrapping
        
        movieSummery.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
