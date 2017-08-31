//
//  RatingCell.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/31/17.
//
//

import UIKit

class RatingCell: UITableViewCell {

    @IBOutlet weak var trophy: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var score: UILabel!
    
    func generate(with user: UserScore) {
        trophy.image = #imageLiteral(resourceName: "trophy")
        userName.text = user.username
        score.text = "\(user.score)"
        time.text = user.date.timeSinceDate()
    }

}
