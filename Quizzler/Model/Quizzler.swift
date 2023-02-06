import Foundation

struct Quizzler {
    var quiz = Question.questions()

    private var score = 0
    private var questionNumber = 0
    
    var currentQuestion: String {
        quiz[questionNumber].ask
    }
    
    var currentProgress: Float {
        quiz.isEmpty ? 1 : (Float(questionNumber + 1)) / Float(quiz.count)
    }
    
    var currentScore: Int {
        score
    }
    
    var currentAnswers: [String] {
        var result = quiz[questionNumber].wrongAnswers
        result.append(quiz[questionNumber].correctAnswer)
        return result.shuffled()
    }
    
    mutating func checkAnswer(_ answer: String) -> Bool {
        if quiz[questionNumber].correctAnswer == answer {
            score += 1
            return true
        } else {
            return false
        }
    }
    
    mutating func nextQuestion() {
        if questionNumber < quiz.count - 1 {
            questionNumber += 1
        } else {
            reset()
        }
    }
    
    mutating func reset() {
        score = 0
        questionNumber = 0
    }
    
    
}
