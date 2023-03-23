//
//  ViewController.swift
//  Oko Future
//
//  Created by Denis on 23.03.2023.
//

import UIKit
import SceneKit

enum AvatarMode {
    case general
    case wardrobe
}

final class GeneralViewController: UIViewController {
    
    private var chooseModel = 1
    
    private var mode: AvatarMode = .general
    
    private var sceneView: SCNView = {
        let scn = SCNView()
        scn.allowsCameraControl = true
        scn.autoenablesDefaultLighting = true
        scn.antialiasingMode = .multisampling2X
        scn.backgroundColor = .clear
        return scn
    }()
    
    private let sceneGirl: SCNScene = {
        let sceneGirl: SCNScene = .init(named: "Girlo.usdz")!
        return sceneGirl
    }()
    
    private let sceneWraith: SCNScene = {
        let sceneWraith: SCNScene = .init(named: "wraith.usdz")!
        return sceneWraith
    }()
    
//    private let zoomInButton: UIButton = {
//        let btn = UIButton()
//        return btn
//    }()
//
//    private let zoomOutButton: UIButton = {
//        let btn = UIButton()
//        return btn
//    }()

    private var interfaceBottomStack: UIStackView = {
        let stk = UIStackView()
        return stk
    }()
    
    private let wardrobeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("skin", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    private let arViewButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("AR", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    private let backWardrobeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("back", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    private let firstModelWardrobeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("first", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    private let secondModelWardrobeButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("second", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor.systemMint
        view.addSubview(sceneView)
//        view.addSubview(interfaceBottomStack)
        view.addSubview(firstModelWardrobeButton)
        view.addSubview(secondModelWardrobeButton)
        
        view.addSubview(wardrobeButton)
        view.addSubview(backWardrobeButton)
        view.addSubview(arViewButton)
        
//        interfaceBottomStack.addArrangedSubview(firstModelWardrobeButton)
//        interfaceBottomStack.addArrangedSubview(secondModelWardrobeButton)
        
        sceneView.scene = sceneGirl
        
        firstModelWardrobeButton.addTarget(self, action: #selector(tapFirst), for: .touchUpInside)
        secondModelWardrobeButton.addTarget(self, action: #selector(tapSecond), for: .touchUpInside)
        
        wardrobeButton.addTarget(self, action: #selector(tapWardrobe), for: .touchUpInside)
        backWardrobeButton.addTarget(self, action: #selector(tapBackWardrobe), for: .touchUpInside)
        
        arViewButton.addTarget(self, action: #selector(tapArView), for: .touchUpInside)
    }
    
    private func setupLayout() {
        sceneView.frame = view.frame
        
        changeMode()
        
        let weightButtonWardrobe: CGFloat = view.frame.width / 5
        
        firstModelWardrobeButton.frame = CGRect(x: weightButtonWardrobe/2, y: view.frame.height - weightButtonWardrobe - 20, width: weightButtonWardrobe, height: weightButtonWardrobe)
        firstModelWardrobeButton.layer.cornerRadius = firstModelWardrobeButton.bounds.size.width / 2.0
        
        secondModelWardrobeButton.frame = CGRect(x: weightButtonWardrobe*2, y: view.frame.height - weightButtonWardrobe - 20, width: weightButtonWardrobe, height: weightButtonWardrobe)
        secondModelWardrobeButton.layer.cornerRadius = secondModelWardrobeButton.bounds.size.width / 2.0
        
        backWardrobeButton.frame = CGRect(x: weightButtonWardrobe*4 - weightButtonWardrobe/2, y: view.frame.height - weightButtonWardrobe - 20, width: weightButtonWardrobe, height: weightButtonWardrobe)
        backWardrobeButton.layer.cornerRadius = backWardrobeButton.bounds.size.width / 2.0
        
        wardrobeButton.frame = CGRect(x: weightButtonWardrobe, y: view.frame.height - weightButtonWardrobe - 20, width: weightButtonWardrobe, height: weightButtonWardrobe)
        wardrobeButton.layer.cornerRadius = wardrobeButton.bounds.size.width / 2.0
        
        arViewButton.frame = CGRect(x: weightButtonWardrobe*3, y: view.frame.height - weightButtonWardrobe - 20, width: weightButtonWardrobe, height: weightButtonWardrobe)
        arViewButton.layer.cornerRadius = arViewButton.bounds.size.width / 2.0
        
    }
    
    @objc private func tapFirst() {
        if self.chooseModel != 1 {
            self.chooseModel = 1
            self.sceneView.scene = sceneGirl
        }
    }

    @objc private func tapSecond() {
        if self.chooseModel != 2 {
            self.chooseModel = 2
            self.sceneView.scene = sceneWraith
        }
    }
    
    @objc private func tapWardrobe() {
        mode = .wardrobe
        changeMode()
    }
    
    @objc private func tapBackWardrobe() {
        mode = .general
        changeMode()
    }
    
    @objc private func tapArView() {
        let vc = ArViewController()
        self.navigationController?.pushViewController(vc,
         animated: true)
    }
    
    private func changeMode() {
        switch mode {
        case .general:
            firstModelWardrobeButton.isHidden = true
            secondModelWardrobeButton.isHidden = true
            backWardrobeButton.isHidden = true
            
            wardrobeButton.isHidden = false
            arViewButton.isHidden = false
        case .wardrobe:
            firstModelWardrobeButton.isHidden = false
            secondModelWardrobeButton.isHidden = false
            backWardrobeButton.isHidden = false
            
            wardrobeButton.isHidden = true
            arViewButton.isHidden = true
        }
    }
    
}

