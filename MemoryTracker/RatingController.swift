//
//  RatingController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit

class RatingController: UIViewController {
    
    var scoreList: [UserScore]?
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func moveRatingToTrash(_ sender: UIBarButtonItem) {
        createScoreAlert(title: "Do you really want clean scores?" , messege: "Your records will be empty")
    }
    
    /// Close controller
    @IBAction func close(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    func clearScores() {
        scoreList?.removeAll()
        tableView.reloadData()
        
        // delete from storage
    }
    
    /// Creates alert with 2 action OK and Cancel
    func createScoreAlert(title: String, messege: String) {
        let alert = UIAlertController(title: title, message: messege, preferredStyle: .alert)
        
        // OK action
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self] (action) in
            self?.clearScores()
        }))
        
        // Cancel action
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        self.present(alert, animated: true, completion:  nil)
    }
}

extension RatingController:  UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scoreList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath) as? RatingCell,
            let score = scoreList?[indexPath.row] {
            cell.generate(with: score)
            
            return cell
        }
        
        return UITableViewCell()
    }
}
