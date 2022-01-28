//
//  ViewController.swift
//  Quizzler
//
//  Created by Vladimir Fibe on 28.01.2022.
//

import UIKit

class ViewController: UIViewController {
  

  var quizBrain = QuizBrain()
  let questionLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 30)
    label.text = "Question text"
    label.numberOfLines = 0
    return label
  }()
  let trueButton: AnswerButton = {
    let button = AnswerButton(type: .system)
    button.setTitle("True", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
    return button
  }()
  let falseButton: AnswerButton = {
    let button = AnswerButton(type: .system)
    button.setTitle("False", for: .normal)
    button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 25)
    button.addTarget(self, action: #selector(answerButtonPressed), for: .touchUpInside)
    return button
  }()
  
  let progressBar: UIProgressView = {
    let progress = UIProgressView()
    progress.progressViewStyle = .bar
    progress.progress = 0.5
    progress.tintColor = #colorLiteral(red: 1, green: 0.4588235294, blue: 0.6588235294, alpha: 1)
    progress.trackTintColor = .white
    progress.translatesAutoresizingMaskIntoConstraints = false
    progress.heightAnchor.constraint(equalToConstant: 10).isActive = true
    return progress
  }()
  let bubblesView: UIImageView = {
    let image = UIImageView(image: #imageLiteral(resourceName: "Background-Bubbles"))
    return image
  }()
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = #colorLiteral(red: 0.1450980392, green: 0.1725490196, blue: 0.2901960784, alpha: 1)
    view.addSubview(bubblesView)
    bubblesView.translatesAutoresizingMaskIntoConstraints = false
    bubblesView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    bubblesView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    bubblesView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    view.addSubview(questionLabel)
    view.addSubview(trueButton)
    view.addSubview(falseButton)
    view.addSubview(progressBar)
    
    let stack = UIStackView(arrangedSubviews: [questionLabel, trueButton, falseButton, progressBar])
    view.addSubview(stack)
    stack.axis = .vertical
    stack.alignment = .fill
    stack.distribution = .fillProportionally
    stack.spacing = 10
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
    stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
    updateUI()
  }
  
  @objc func answerButtonPressed(_ sender: UIButton) {
    let userAnswer = sender.currentTitle
    sender.backgroundColor = quizBrain.checkAnswer(userAnswer) ? .green : .red
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
      sender.backgroundColor = .clear
      self.quizBrain.nextQuestion()
      self.updateUI()
    }
  }
  func updateUI() {
    questionLabel.text = quizBrain.currentQuestion
    progressBar.progress = quizBrain.progress
  }
}

class AnswerButton: UIButton {
  override init(frame: CGRect) {
    super.init(frame: frame)
    layer.cornerRadius = 16
    layer.borderWidth = 4
    layer.borderColor = UIColor.white.cgColor
    heightAnchor.constraint(equalToConstant: 80).isActive = true
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}


