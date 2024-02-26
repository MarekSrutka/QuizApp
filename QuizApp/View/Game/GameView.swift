//
//  GameView.swift
//  QuizApp
//
//  Created by Marek Srutka on 24.02.2024.
//

import UIKit

/*
 What we need
  = questionLbl = text
  - questionNumberOfCorrectAnwersLbl = text
  -
 */

class GameView: UIView {

// MARK: - Properties
    
    lazy var questionLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var questionNumberOfCorrectAnwersLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    lazy var progressVw: UIProgressView = {
        
        let prgs = UIProgressView()
        prgs.translatesAutoresizingMaskIntoConstraints = false
        return prgs
    }()
    
    lazy var singleStackVw: UIStackView = {
        let vw = UIStackView()
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 15
        return vw
    }()
    
    lazy var singleBtn1 = UIButton()
    
    lazy var singleBtn2 = UIButton()
    
    lazy var singleBtn3 = UIButton()
    
    lazy var singleBtn4 = UIButton()
    
    lazy var nextBtn = UIButton()
    
    
// MARK: = Init
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


// MARK: - Private extension

private extension GameView {
    
// MARK: = SetupUI
    
    func setupUI() {
        
        self.addSubview(questionLbl)
        self.addSubview(questionNumberOfCorrectAnwersLbl)
        self.addSubview(singleStackVw)
        self.addSubview(progressVw)
        
        singleStackVw.addArrangedSubview(singleBtn1)
        singleStackVw.addArrangedSubview(singleBtn2)
        singleStackVw.addArrangedSubview(singleBtn3)
        singleStackVw.addArrangedSubview(singleBtn4)
        
        self.addSubview(nextBtn)
        
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        singleBtn1.tag = 0
        singleBtn2.tag = 1
        singleBtn3.tag = 2
        singleBtn4.tag = 3
        
        NSLayoutConstraint.activate([
            
            progressVw.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            progressVw.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            progressVw.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            questionLbl.topAnchor.constraint(equalTo: progressVw.bottomAnchor, constant: 10),
            questionLbl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionLbl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionLbl.heightAnchor.constraint(equalToConstant: 100),
            
            questionNumberOfCorrectAnwersLbl.topAnchor.constraint(equalTo: questionLbl.bottomAnchor, constant: 10),
            questionNumberOfCorrectAnwersLbl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            questionNumberOfCorrectAnwersLbl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            questionNumberOfCorrectAnwersLbl.heightAnchor.constraint(equalToConstant: 50),
            
            singleStackVw.topAnchor.constraint(equalTo: questionNumberOfCorrectAnwersLbl.bottomAnchor, constant: 10),
            singleStackVw.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            singleStackVw.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
//            singleStackVw.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
//            nextBtn.topAnchor.constraint(equalTo: singleStackVw.bottomAnchor, constant: 20),
            nextBtn.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextBtn.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            nextBtn.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10)
        ])
        
    }
}
