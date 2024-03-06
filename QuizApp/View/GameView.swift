import UIKit

// MARK: - GameViewDelegate

// Delegate for communication between GameView and GameVC
protocol GameViewDelegate: AnyObject {
    func didTapAnswer()
}

// MARK: - GameView

// Class representing the game view
class GameView: UIView {

    // MARK: - Properties
    
    var questionTitle = QALabel(textAlignment: .center, fontSize: 24, weight: .bold)
    var questionNumberOfCorrectAnswers = QALabel(textAlignment: .center, fontSize: 12, weight: .medium)
    let progressView = UIProgressView()
    let stackView = UIStackView()
    var answerButtons = QAButton()
    var groupButtons: [QAButton] = []
    let nextButton = QAButton()
    
    weak var delegate: GameViewDelegate?
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Configuration
    
    private func setupUI() {
        configureProgressView()
        configureQuestionTitle()
        configureQuestionNumber()
        configureAnswerButton()
        configureStackView()
        //configureNextButton() // It seems it's not needed for now, commented out.
    }
    
    private func configureProgressView() {
        addSubview(progressView)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func configureQuestionTitle() {
        addSubview(questionTitle)
        questionTitle.set(textAlignment: .center, fontSize: 24, weight: .bold, numberOfLines: 0)
        
        NSLayoutConstraint.activate([
            questionTitle.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 10),
            questionTitle.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionTitle.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionTitle.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func configureQuestionNumber() {
        addSubview(questionNumberOfCorrectAnswers)
        
        questionNumberOfCorrectAnswers.set(textAlignment: .center,
                                           fontSize: 14,
                                           weight: .bold)
        
        NSLayoutConstraint.activate([
            questionNumberOfCorrectAnswers.topAnchor.constraint(equalTo: questionTitle.bottomAnchor, constant: 10),
            questionNumberOfCorrectAnswers.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionNumberOfCorrectAnswers.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionNumberOfCorrectAnswers.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    private func configureStackView() {
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: questionNumberOfCorrectAnswers.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
        ])
    }
    
    private func clearStackView() {
        stackView.subviews.forEach { $0.removeFromSuperview() }
    }
    
    func configureAnswerButton() {
        for button in groupButtons {
            button.addTarget(self, action: #selector(didTapAnswer), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor),
                button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
                button.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
    }
    
    // MARK: - Actions
    
    @objc func didTapAnswer() {
        clearStackView()
        delegate?.didTapAnswer()
    }
}
