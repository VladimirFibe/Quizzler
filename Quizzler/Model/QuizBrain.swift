import Foundation
import UIKit

struct QuizBrain {
    var questionNumber: Int = 0
    let quiz = Question.questions()
    mutating func nextQuestion() {
        questionNumber = (questionNumber < quiz.count - 1) ? questionNumber + 1 : 0
    }
    func checkAnswer(_ answer: String?) -> Bool {
        quiz[questionNumber].correctAnswer == answer
    }
    var currentQuestion: String {
        quiz[questionNumber].ask
    }
    var progress: Float {
        Float(questionNumber + 1) / Float(quiz.count)
    }
}
