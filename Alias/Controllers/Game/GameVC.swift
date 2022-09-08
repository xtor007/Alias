//
//  GameVC.swift
//  Alias
//
//  Created by Anatoliy Khramchenko on 08.09.2022.
//

import UIKit

class GameVC: UIViewController {
    
    private enum ActionStatus {
        
        case right, wrong
        
        func getCoef() -> CGFloat {
            switch self {
            case .right:
                return 1
            case .wrong:
                return -1
            }
        }
        
    }
    
    //card
    @IBOutlet weak var currentCard: UIView!
    @IBOutlet weak var currentWord: UILabel!
    @IBOutlet weak var nextCard: UIView!
    @IBOutlet weak var nextWord: UILabel!
    
    //animation settings
    private let animationDuration = 0.3
    private let buttonScale = 1.2
    private let cardScale = 0.8
    private let cardTranslation: CGFloat = 200
    
    private let actionStatuses = [ActionStatus.wrong,.right]
    
    //timer
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerLine: UIView!
    private var timer: Timer?
    private var timeLeft = 60
    
    private var score = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let word = WordsManager.shared.getWord()
        if let word = word {
            currentWord.text = word
        } else {
            backAction(0)
        }
        startTimer()
    }
    
    @IBAction func action(_ sender: Any) {
        if let button = sender as? UIButton {
            UIView.animate(withDuration: self.animationDuration/2, delay: 0.05, options: .curveEaseIn) {
                button.transform = CGAffineTransform(scaleX: self.buttonScale, y: self.buttonScale)
            } completion: { isFinish in
                if isFinish {
                    UIView.animate(withDuration: self.animationDuration/2, delay: 0, options: .curveEaseOut) {
                        button.transform = .identity
                    }
                }
            }
            setNewWord(status: actionStatuses[button.tag])
            if button.tag == 0 { //is wrong
                score -= 1
            } else {
                score += 1
            }
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        WordsManager.shared.finishRaund()
        dismiss(animated: false)
    }
    
    @objc func updateTimer() {
        timeLeft -= 1
        let timeWas = 60 - CGFloat(timeLeft)
        timerLabel.text = String(timeLeft)
        timerLine.transform = CGAffineTransform(translationX: -timerLine.frame.width/60*timeWas, y: 0)
        if timeLeft == 0 {
            timer?.invalidate()
            finish()
        }
    }
    
    private func setNewWord(status: ActionStatus) {
        let newWord = WordsManager.shared.getWord()
        if let newWord = newWord {
            nextWord.text = newWord
            self.nextCard.transform = CGAffineTransform(scaleX: self.cardScale, y: self.cardScale)
            UIView.animate(withDuration: self.animationDuration, delay: 0, options: .curveEaseOut) { //swipe card
                self.nextCard.transform = .identity
                self.currentCard.transform = CGAffineTransform(translationX: status.getCoef()*self.cardTranslation, y: 0)
            } completion: { isFinish in
                if isFinish {
                    self.currentWord.text = newWord
                    self.currentCard.transform = .identity
                }
            }
        } else {
            backAction(0)
        }
    }
    
    private func finish() {
        WordsManager.shared.finishRaund()
        let popUp = PopUpVC(score: score, delegate: self)
        present(popUp, animated: true)
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true
        )
    }
    
}

extension GameVC: GameDelegate {
    
    func startAgain() {
        let word = WordsManager.shared.getWord()
        if let word = word {
            currentWord.text = word
        } else {
            toMain()
        }
        timeLeft = 60
        startTimer()
    }
    
    func toMain() {
        dismiss(animated: false)
    }
    
}
