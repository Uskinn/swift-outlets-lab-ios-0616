//
//  ViewController.swift
//  SimonSaysLab
//
//  Created by James Campagno on 5/31/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayColorView: UIView!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var winLabel: UILabel!
    
    @IBOutlet var buttons: [UIButton]!
    
    var simonSaysGame = SimonSays()
    var buttonsClicked = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        winLabel.hidden = true
        
        for button: UIButton in buttons {
            button.hidden = true
        }

        
    }
}


// MARK: - SimonSays Game Methods
extension ViewController {
  
    
    @IBAction func startGameTapped(sender: UIButton) {
        winLabel.hidden = true
        buttonsClicked = 0

        UIView.transitionWithView(startGameButton, duration: 0.9, options: .TransitionFlipFromBottom , animations: {
            self.startGameButton.hidden = true
            }, completion: nil)
        
        simonSaysGame = SimonSays()
        
        displayTheColors()
    }
    
    @IBAction func colorButtonsView(sender: UIButton) {
        
        buttonsClicked += 1
        
        switch sender.tag {
            
        case 0:
            simonSaysGame.guessRed()
        case 1:
            simonSaysGame.guessGreen()
        case 2:
            simonSaysGame.guessYellow()
        case 3:
            simonSaysGame.guessBlue()
        default:
            break
        }
        
        winCheck()
    }
    
    func winCheck() {
        
        if buttonsClicked == 5 {
            
            for button: UIButton in buttons {
                button.hidden = true
            } 
            
            winLabel.hidden = false
            
            if simonSaysGame.wonGame() {
               
                winLabel.text = "You Win!"
            } else {
                winLabel.text = "You Lost"
            }

            startGameButton.hidden = false
            
        }
        
}
    
    
    private func displayTheColors() {
        self.view.userInteractionEnabled = false
        UIView.transitionWithView(displayColorView, duration: 1.5, options: .TransitionCurlUp, animations: {
            self.displayColorView.backgroundColor = self.simonSaysGame.nextColor()?.colorToDisplay
            self.displayColorView.alpha = 0.0
            self.displayColorView.alpha = 1.0
            }, completion: { _ in
                if !self.simonSaysGame.sequenceFinished() {
                    self.displayTheColors()
                } else {
                    self.view.userInteractionEnabled = true
                    print("Pattern to match: \(self.simonSaysGame.patternToMatch)")
                    
                    for button: UIButton in self.buttons {
                        button.hidden = false
                    }

                }
        })
    }
}
