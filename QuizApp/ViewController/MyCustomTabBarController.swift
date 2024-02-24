//
//  MyCustomTabBarController.swift
//  QuizApp
//
//  Created by Marek Srutka on 23.02.2024.
//

import UIKit

class MyCustomTabBarController: UITabBarController {
    
// MARK: - Properties
    
    let playQuizBtn: UIButton = {
       
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 25, weight: .bold, scale: .large)
        
        btn.backgroundColor = UIColor(hex: "#23d602", alpha: 1.0)
        btn.layer.cornerRadius = 30
        btn.layer.shadowColor = UIColor.black.cgColor
        btn.layer.shadowOpacity = 0.2
        btn.layer.shadowOffset = CGSize(width: 4, height: 4)
        btn.setImage(UIImage(systemName: "flag.checkered", withConfiguration: largeConfig)?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addTabItems()
    }
    
    override func loadView() {
        super.loadView()
        self.tabBar.addSubview(playQuizBtn)
        setupUI()
    }

}


// MARK: - Private extension

private extension MyCustomTabBarController {
    
// MARK: - Setup
    
    func setupUI() {
        
        // shape
        let path: UIBezierPath = getPathForTabBar()
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        shape.lineWidth = 3
        shape.strokeColor = UIColor.white.cgColor
        shape.fillColor = UIColor.white.cgColor
        
        //tabbar
        self.tabBar.layer.insertSublayer(shape, at: 0)
        self.tabBar.itemWidth = 40
        self.tabBar.itemPositioning = .centered
        self.tabBar.itemSpacing = 180
        self.tabBar.tintColor = UIColor(hex: "#23d602", alpha: 1.0)
        
        //button
        playQuizBtn.frame = CGRect(x: (self.tabBar.bounds.width)/2 - 30, y: -20, width: 60, height: 60)
    }
    
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
    
    
// MARK: - Functions
    
    func addTabItems() {
        let vc1 = MainViewController()
        let vc2 = SettingsViewController()
        
        vc1.title = "Home"
        vc2.title = "Setings"
        
//        vc1.isNavigationBarHidden = true
//        vc2.isNavigationBarHidden = true
        
        setViewControllers([vc1, vc2], animated: false)
        guard let items = tabBar.items else {
            return
        }
        items[0].image = UIImage(systemName: "house.fill")
        items[1].image = UIImage(systemName: "gearshape.fill")
    }
}
