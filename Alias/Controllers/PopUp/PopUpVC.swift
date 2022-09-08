//
//  PopUpVC.swift
//  Alias
//
//  Created by Anatoliy Khramchenko on 08.09.2022.
//

import UIKit

class PopUpVC: UIViewController {
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var emojiLabel: UILabel!
    
    private let score: Int
    private let delegate: GameDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLabel.text = String(score)
        emojiLabel.text = getEmoji()
    }
    
    init(score: Int, delegate: GameDelegate) {
        self.score = score
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func startAgainAction(_ sender: Any) {
        dismiss(animated: false) {
            self.delegate.startAgain()
        }
    }
    
    @IBAction func backAction(_ sender: Any) {
        dismiss(animated: false) {
            self.delegate.toMain()
        }
    }
    
    private func getEmoji() -> String {
        let rightWall = 5
        let leftWall = -5
        switch score {
        case ..<leftWall:
            return "😔"
        case leftWall...rightWall:
            return "😊"
        default:
            return "😁"
        }
    }
    
}
