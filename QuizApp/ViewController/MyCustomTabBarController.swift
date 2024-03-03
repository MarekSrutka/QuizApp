//
//  MyCustomTabBarController.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class MyCustomTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let playQuizBtn = QAPlayButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [createMainNC(), createSettingsNC()]
        setupUI()
    }
    
    // MARK: - Functions
    
    func setupUI() {
        layouUI()
        configureTabbar()
        configurePlayButton()
    }
    
    func layouUI() {
        let path: UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        
        tabBar.layer.insertSublayer(shape, at: 0)
    }
    
    func createMainNC() -> UINavigationController {
        let mainVC = MainVC()
        mainVC.tabBarItem.image = UIImage(systemName: "house.fill")
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func createSettingsNC() -> UINavigationController {
        let mainVC = SettingsVC()
        mainVC.tabBarItem.image = UIImage(systemName: "gearshape.fill")
        
        return UINavigationController(rootViewController: mainVC)
    }
    
    func configureTabbar() {
        tabBar.addSubview(playQuizBtn)
        tabBar.itemWidth = 40
        tabBar.itemPositioning = .centered
        tabBar.itemSpacing = 180
        tabBar.tintColor = UIColor(hex: "#23d602", alpha: 1.0)
    }
    
    func configurePlayButton() {
        playQuizBtn.set(icon: UIImage(systemName: "flag.checkered")!)
        playQuizBtn.frame = CGRect(x: (self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
        playQuizBtn.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
    }
    
    func pushGameVC() {
        if let selectedNavController = selectedViewController as? UINavigationController {
            let newViewController = GameVC()
            selectedNavController.pushViewController(newViewController, animated: true)
        }
    }
    
    @objc func didTapPlay() {
        pushGameVC()
    }
}


// MARK: - Private extension

private extension MyCustomTabBarController {
    func getPathForTabBar() -> UIBezierPath {
        let frameWidth = self.tabBar.bounds.width
        let frameHeight = view.bounds.height
        let holeWidth = 150
        let holeHeight = 50
        let leftXUntilHole = Int(frameWidth/2) - Int(holeWidth/2)
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: leftXUntilHole, y: 0))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (holeWidth/3), y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*6, y: 0), controlPoint2: CGPoint(x: leftXUntilHole + ((holeWidth/3)/8)*8, y: holeHeight/2))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint1: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2/5, y: (holeHeight/2)*6/4), controlPoint2: CGPoint(x: leftXUntilHole + (holeWidth/3) + (holeWidth/3)/3*2 + (holeWidth/3)/3*3/5, y: (holeHeight/2)*6/4))
        
        path.addCurve(to: CGPoint(x: leftXUntilHole + holeWidth, y: 0), controlPoint1: CGPoint(x: leftXUntilHole + (2*holeWidth)/3, y: holeHeight/2), controlPoint2: CGPoint(x: leftXUntilHole + (2*holeWidth)/3 + (holeWidth/3)*2/8, y: 0))
        
        path.addLine(to: CGPoint(x: frameWidth, y: 0))
        
        path.addLine(to: CGPoint(x: frameWidth, y: frameHeight))
        
        path.addLine(to: CGPoint(x: 0, y: frameHeight))
        
        path.addLine(to: CGPoint(x: 0, y: 0))
        
        path.close()
        return path
    }
}
