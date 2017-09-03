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
    
    var pause = PauseView()
    var gameOverView = GameOverView()
    
    var timeLimit: Double?
    let logic = GameLogic.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logic.presentScore = { [weak self] score in
            self?.showScore(score: score)
        }
        
        gameOverView.onRepeatButtTap = { [weak self] in
            self?.resrtartGame()
        }
        
        pause.onPauseButtTap = { [weak self] in
            self?.turnOffpause()
        }
    }
    
    // Turns off pause from game scene
    func turnOffpause() {
        detailsController.isPause = false
        detailsController.changeTimerState()
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
        GameLogic.shared.score = 0
        dismiss(animated: true, completion: nil)
    }
    
    // Presents current score
    func showScore(score: Double) {
        detailsController.present(score: score)
    }
    
    /* To restart game we need to give set of instraction for game:
     *  stop timer, clear labels for details panel control
     *  clear score nd time in game logic
     *  redraw scene in map scene
     *  run timer again
     */
    func resrtartGame() {
        gameOverView.removeFromSuperview()
        
        detailsController.stopTimer()
        detailsController.scoreLabel.text = "0.0"
        detailsController.timeLabel.text = "00:00"
        
        logic.score = 0
        logic.totalScore = 0
        logic.currentTime = logic.timeLimit
        
        gameMapController.redrawScene()
        detailsController.runTimer()
    }
    
    // When game over controller stop timer and put gameOver subview
    func gameOver() {
        detailsController.stopTimer()
        gameOverView.frame = gameContainer.bounds
        gameContainer.addSubview(gameOverView)

        if logic.totalScore > 0 {
            saveScore()
        }
    }
    
    /// Saves score in rating desk
    func saveScore() {
        let alert = UIAlertController(title: "Save your score", message: "Input your name here", preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: "Done", style: .default, handler: { (action) -> Void in
            let nicknameField = alert.textFields?[0]
            let score = UserScore(username: nicknameField?.text ?? "User",
                                  score: Int(GameLogic.shared.totalScore))
            
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
    
    // MARK: Preparing block
    
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
    
    // Binds methods between details and game scene
    func prepareControlPanelController(controller: PanelControlController) {
        detailsController = controller
        
        detailsController.onPauseTap = { [weak self] state in
            self?.turnOnPause(state: state)
        }
        
        detailsController.onHomeTap = { [weak self] in
            self?.turnToHome()
        }
        
        detailsController.timeOver = { [weak self] in
            self?.gameOver()
        }
        
        detailsController.onRestartTap = { [weak self] in
            self?.resrtartGame()
        }
    }
}
