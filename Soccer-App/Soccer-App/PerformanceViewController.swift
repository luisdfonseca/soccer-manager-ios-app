
import UIKit

class PerformanceViewController: UIViewController {
    
    let statStore = StatStore.sharedInstance
    
    @IBOutlet weak var gamesPlayedLabel: UILabel!
    @IBOutlet weak var winLabel: UILabel!
    @IBOutlet weak var lostLabel: UILabel!
    @IBOutlet weak var drawLabel: UILabel!
    @IBOutlet weak var avgGoalsScoredLabel: UILabel!
    @IBOutlet weak var avgGoalsReceivedLabel: UILabel!
    @IBOutlet weak var avgShots: UILabel!
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        statStore.updateData()
        
        gamesPlayedLabel.text = String(statStore.getGamesPlayed())
        winLabel.text = statStore.getGamesWon()
        lostLabel.text = statStore.getGamesLost()
        drawLabel.text = statStore.getGamesDraw()
        
        avgGoalsScoredLabel.text = statStore.getAverageGoalsScored()
        avgGoalsReceivedLabel.text = statStore.getAverageGoalsRecieved()
        avgShots.text = statStore.getAverageShots()
        
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
    }
    
    
}