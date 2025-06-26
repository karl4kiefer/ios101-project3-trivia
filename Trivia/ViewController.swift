import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet var answerButtons: [UIButton]!
    
    var questions = [TriviaQuestion]()
    var currentQuestionIndex = 0
    var score = 0
    
    struct TriviaQuestion {
        let question: String
        let answers: [String]
        let correctAnswerIndex: Int
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupQuestions()
        displayQuestion()
        updateUI()
    }
    
    func setupQuestions() {
        questions = [
            TriviaQuestion(question: "What is the largest ocean on Earth?",
                           answers: ["Atlantic", "Indian", "Arctic", "Pacific"],
                           correctAnswerIndex: 3),
            TriviaQuestion(question: "What is the chemical symbol for gold?",
                           answers: ["Au", "Ag", "Go", "Gd"],
                           correctAnswerIndex: 0),
            TriviaQuestion(question: "How many colors are in a rainbow?",
                           answers: ["6", "7", "8", "5"],
                           correctAnswerIndex: 1),
            TriviaQuestion(question: "What planet is known as the Red Planet?",
                           answers: ["Jupiter", "Venus", "Mars", "Saturn"],
                           correctAnswerIndex: 2)
                    ]
    }
    
    func displayQuestion() {
        guard currentQuestionIndex < questions.count else {
            showFinalScore()
            return
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        questionLabel.text = currentQuestion.question
        
        for i in 0..<answerButtons.count {
            answerButtons[i].setTitle(currentQuestion.answers[i], for: .normal)
        }
    }
    
    @IBAction func answerButtonTapped(_ sender: UIButton) {
        guard let buttonIndex = answerButtons.firstIndex(of: sender) else {
            return
        }
        
        let currentQuestion = questions[currentQuestionIndex]
        if buttonIndex == currentQuestion.correctAnswerIndex {
            score += 1
        }
        
        currentQuestionIndex += 1
        updateUI()
        displayQuestion()
    }
    
    func updateUI() {
        scoreLabel.text = "Score: \(score)"
    }
    
    func showFinalScore() {
        questionLabel.text = "Finish!\nFinal Score: \(score) out of \(questions.count)"
        for button in answerButtons {
            button.isHidden = true
        }
    }
}
