//
//  ViewController.swift
//  ApplePie
//
//  Created by Ahmed Elsayed on 03/08/2023.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var letterButtons: [UIButton]!
    
    @IBOutlet weak var treeImageView: UIImageView!
    
    @IBOutlet weak var correctWordLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading
        newRound()
    }
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        sender.isEnabled = false
        let letterString = sender.title(for: .normal)!
        let letter = Character(letterString.lowercased())
        currentGame.playerGuessed(letter: letter)
        updateGameState()
    }
    
    var listOfWords = [
      "buccaneer", "swift", "glorious", "incandescent", "bug", "program",
      "vexed", "captivate", "catastrophe", "iridescent", "magnificent",
      "jubilant", "spectacular", "colossal", "quizzical", "extravagant",
      "exuberant", "fascinate", "mellifluous", "zephyr", "effervescent",
      "whimsical", "preposterous", "wonderful", "benevolent", "luminous",
      "grandiose", "serendipity", "enigmatic", "murmuration", "resplendent",
      "effulgent", "melancholy", "quintessential", "bewilder", "vivacious",
      "nurturing", "conundrum", "effervescent", "labyrinth", "evanescent",
      "ephemeral", "enchanting", "effulgent", "iridescence", "phenomenal",
      "splendiferous", "cynosure", "ebullient", "luminosity", "efflorescence",
      "capricious", "resilient", "enigmatic", "surreptitious", "breathtaking",
      "sensational", "effervescent", "lackadaisical", "flabbergasted", "serene",
      "magnanimous", "petrichor", "perpendicular", "astounding", "diaphanous",
      "mellifluous", "belligerent", "scintillating", "whimsical", "vibrant",
      "effulgence", "evanescence", "resonate", "melodious", "labyrinthine",
      "ebullience", "benevolence", "effervescence", "captivating", "enrapture",
      "magnificence", "flummox", "bucolic", "iridescent", "resplendence",
      "effortless", "languorous", "opulence", "cogent", "efficacious",
      "scrumptious", "effulgent", "enchant", "resplendent", "magniloquent",
      "whimsical", "breathtaking", "scintillate", "exquisite", "mellifluous",
      "benevolence", "effulgence", "captivating", "enrapture", "magnificence",
      "effervescent", "resonate", "melodious", "labyrinthine", "ebullience",
      "buccaneer", "swift", "glorious", "incandescent", "bug", "program"
    ];
    
    var incorrectMovesAllowed = 7
    var totalWins = 0 {
        didSet {
            newRound()
        }
    }
    var totalLosses = 0 {
        didSet {
            newRound()
        }
    }
    var currentGame: Game!
    
    func newRound() {
        if !listOfWords.isEmpty {
            let newWord = listOfWords.removeFirst()
            currentGame = Game(word: newWord, incorrectMovesRemaining: incorrectMovesAllowed, guessedLetters: [])
            enableLetterButtons(true)
            updateUI()
        } else {
            enableLetterButtons(false)
        }
    }
    
    func updateUI() {
        var letters = [String]()
        for letter in currentGame.formattedWord {
            letters.append(String(letter))
        }
        let wordWithSpacing = letters.joined(separator: " ")
        correctWordLabel.text = wordWithSpacing
        
        scoreLabel.text = "Wins: \(totalWins), Losses: \(totalLosses)"
        treeImageView.image = UIImage(named: "Tree \(currentGame.incorrectMovesRemaining)")
    }
    
    func updateGameState() {
        if currentGame.incorrectMovesRemaining == 0 {
            totalLosses += 1
        } else if currentGame.word == currentGame.formattedWord {
            totalWins += 1
        } else {
            updateUI()
        }
    }
    
    func enableLetterButtons(_ enable: Bool) {
        for button in letterButtons {
            button.isEnabled = enable
        }
    }
}


