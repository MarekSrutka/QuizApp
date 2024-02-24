//
//  HeaderView.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class HeaderView: UIView {

    private let easyToUse = EasyToUse()
    var greetings: String
    
    
// MARK: - Properties
    
    private lazy var header_userNameLbl: UILabel = {
        
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "@\(easyToUse.defaults.string(forKey: "username") ?? "")"
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return lbl
    }()
    
    private lazy var header_welcomeLbl: UILabel = {
        
        let lbl = UILabel()
        
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = greetings
        lbl.font = .systemFont(ofSize: 24, weight: .bold)
        
        return lbl
    }()
    
    private lazy var header_stackVw: UIStackView = {
        
        let vw = UIStackView()
        
        vw.translatesAutoresizingMaskIntoConstraints = false
        vw.axis = .vertical
        vw.spacing = 4
        
        return vw
    }()
    
    
// MARK: - Init
    
    init(_ greetings: String) {
        self.greetings = greetings
        
        super.init(frame: .zero)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private extesion

private extension HeaderView {
    
// MARK: - Setup UI
    
    func setupUI() {
        
        self.addSubview(header_stackVw)
        
        header_stackVw.addArrangedSubview(header_welcomeLbl)
        header_stackVw.addArrangedSubview(header_userNameLbl)
        
        NSLayoutConstraint.activate([
            header_stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            header_stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            header_stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            header_stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
