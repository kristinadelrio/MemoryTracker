//
//  GameController.swift
//  MemoryTracker
//
//  Created by Alejandro Del Rio Albrechet on 8/30/17.
//
//

import UIKit

class GameController: UIViewController {
    
    @IBOutlet weak var gameContainer: UIView!
    
    var detailsController: PanelControlController!
    var gameMapController: GameMapController!
    
    var pause = UIButton()
    var timeLimit: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPauseButtonLayer()
        
        GameLogic.shared.presentScore = { [weak self] score in
            self?.showScore(score: score)
        }
    }
    
    // create pause button
    func initPauseButtonLayer() {
        pause.backgroundColor = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.6)
        
        pause.imageView?.contentMode = .scaleAspectFit
        pause.tintColor = UIColor(displayP3Red: 0.986, green: 0.909, blue: 0.921, alpha: 1)
        pause.setImage(#imageLiteral(resourceName: "pause").withRenderingMode(.alwaysTemplate), for: .normal)
        
        pause.addTarget(self, action: #selector(turnOffpause), for: .touchUpInside)
    }
    
    // Turns off pause from game scene
    func turnOffpause() {
        detailsController.isPause = false
        pause.removeFromSuperview()
    }
    
    // Catchs pause state from details
    func turnOnPause(state: Bool) {
        if state {
            pause.frame = gameMapController.view.frame
            gameContainer.addSubview(pause)
            
        } else {
            pause.removeFromSuperview()
        }
    }
    
    // Returns to menu page
    func turnToHome() {
        dismiss(animated: true, completion: nil)
    }
    
    // presents current score
    func showScore(score: Int) {
        detailsController.present(score: Double(score))
    }
    
    func gameOver() {
        detailsController.stopTimer()
        saveScore()
    }
    
    // Save score in rating desk
    func saveScore() {
        let alert = UIAlertController(title: "Save your score", message: "Input your name here", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
            let nicknameField = alert.textFields?[0]
            let score = UserScore(username: nicknameField?.text ?? "User", score: GameLogic.shared.score)
            RatingStorage.shared.saveData(score: score)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil)
        
        alert.addTextField { (nicknameField: UITextField) in
            nicknameField.placeholder = "your name is..."
            nicknameField.clearButtonMode = .whileEditing
            nicknameField.keyboardType = .default
            nicknameField.keyboardAppearance = .dark
            
            alert.addAction(confirmAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion:  nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PanelControlControllerSegue",
            let controller = segue.destination as? PanelControlController {
            prepareControlPanelController(controller: controller)
            
        } else if segue.identifier == "GameMapControllerSegue",
            let controller = segue.destination as? GameMapController {
            prepareGameMapController(controller: controller)
        }
    }
    
    // Binds methods between control panel and game scene
    func prepareGameMapController(controller: GameMapController) {
        gameMapController = controller
        
        gameMapController.gameOver = { [weak self] in
            self?.gameOver()
        }
    }
    
    // binds methods between details and game scene
    func prepareControlPanelController(controller: PanelControlController) {
        detailsController = controller
        detailsController.timeConstraints = timeLimit ?? 60.0
        
        detailsController.onPauseTap = { [weak self] state in
            self?.turnOnPause(state: state)
        }
        
        detailsController.onHomeTap = { [weak self] in
            self?.turnToHome()
        }
        
        detailsController.timeOver = { [weak self] in
            self?.gameOver()
        }
    }
}
