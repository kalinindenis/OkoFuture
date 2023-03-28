//
//  ViewController.swift
//  Oko Future
//
//  Created by Denis on 23.03.2023.
//

import UIKit
import SceneKit
import RealityKit
import Combine

enum AvatarMode {
    case general
    case wardrobe
}

final class GeneralViewController: UIViewController {
    
    public var chooseModel = 0
    
    public let arrayNameScene = ["Girlo.usdz", "avatar.usdz"]
    
    private var mode: AvatarMode = .general
    
    public var sceneView: ARView = {
        let scn = ARView()
        scn.cameraMode = .nonAR
        scn.backgroundColor = .clear
        scn.debugOptions = .showStatistics
        return scn
    }()
    
    public var nodeGirl: Entity? = nil
    public var nodeAvatar: Entity? = nil
    
    private let zoomInButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("+", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
    }()

    private let zoomOutButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("-", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.backgroundColor = .black
        btn.clipsToBounds = true
        btn.layer.borderWidth = 2
        btn.layer.borderColor = UIColor.white.cgColor
        return btn
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

        self.navigationItem.setHidesBackButton(true, animated:false)
        setupView()
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        if self.chooseModel == 0 {
            self.nodeAvatar = nil
        } else {
            self.nodeGirl = nil
        }
    }
    
    private func setupView() {
        
        view.backgroundColor = UIColor.systemMint
        view.addSubview(sceneView)
        view.addSubview(firstModelWardrobeButton)
        view.addSubview(secondModelWardrobeButton)
        
        view.addSubview(wardrobeButton)
        view.addSubview(backWardrobeButton)
        view.addSubview(arViewButton)
        
        view.addSubview(zoomInButton)
        view.addSubview(zoomOutButton)
        
//        let dragRotateGesture = UIPanGestureRecognizer(target: self, action: #selector(rotateDragY))
//        sceneView.addGestureRecognizer(dragRotateGesture)
        
        firstModelWardrobeButton.addTarget(self, action: #selector(tapFirst), for: .touchUpInside)
        secondModelWardrobeButton.addTarget(self, action: #selector(tapSecond), for: .touchUpInside)
        
        wardrobeButton.addTarget(self, action: #selector(tapWardrobe), for: .touchUpInside)
        backWardrobeButton.addTarget(self, action: #selector(tapBackWardrobe), for: .touchUpInside)
        
        arViewButton.addTarget(self, action: #selector(tapArView), for: .touchUpInside)
        
        zoomInButton.addTarget(self, action: #selector(tapZoomIn), for: .touchUpInside)
        zoomOutButton.addTarget(self, action: #selector(tapZoomOut), for: .touchUpInside)
    }
    
    private func setupLayout() {
        sceneView.frame = view.frame
        
        changeMode()
        
        let weightSystemButton: CGFloat = view.frame.width / 5
        let weightZoomButton: CGFloat = weightSystemButton / 1.8
        
        firstModelWardrobeButton.frame = CGRect(x: weightSystemButton/2, y: view.frame.height - weightSystemButton - 20, width: weightSystemButton, height: weightSystemButton)
        firstModelWardrobeButton.layer.cornerRadius = firstModelWardrobeButton.bounds.size.width / 2.0
        
        secondModelWardrobeButton.frame = CGRect(x: weightSystemButton*2, y: view.frame.height - weightSystemButton - 20, width: weightSystemButton, height: weightSystemButton)
        secondModelWardrobeButton.layer.cornerRadius = secondModelWardrobeButton.bounds.size.width / 2.0
        
        backWardrobeButton.frame = CGRect(x: weightSystemButton*4 - weightSystemButton/2, y: view.frame.height - weightSystemButton - 20, width: weightSystemButton, height: weightSystemButton)
        backWardrobeButton.layer.cornerRadius = backWardrobeButton.bounds.size.width / 2.0
        
        wardrobeButton.frame = CGRect(x: weightSystemButton, y: view.frame.height - weightSystemButton - 20, width: weightSystemButton, height: weightSystemButton)
        wardrobeButton.layer.cornerRadius = wardrobeButton.bounds.size.width / 2.0
        
        arViewButton.frame = CGRect(x: weightSystemButton*3, y: view.frame.height - weightSystemButton - 20, width: weightSystemButton, height: weightSystemButton)
        arViewButton.layer.cornerRadius = arViewButton.bounds.size.width / 2.0
        
        zoomInButton.frame = CGRect(x: view.frame.width - weightZoomButton - 10, y: view.frame.height/3, width: weightZoomButton, height: weightZoomButton)
        zoomInButton.layer.cornerRadius = zoomInButton.bounds.size.width / 2.0
        
        zoomOutButton.frame = CGRect(x: view.frame.width - weightZoomButton - 10, y: view.frame.height/3 + weightZoomButton + 10, width: weightZoomButton, height: weightZoomButton)
        zoomOutButton.layer.cornerRadius = zoomOutButton.bounds.size.width / 2.0
        
    }
    
    @objc private func tapFirst() {
        if self.chooseModel != 0 {
            self.chooseModel = 0
            
            if self.nodeGirl != nil {
                self.sceneView.scene.anchors[0].children[1].removeFromParent(preservingWorldTransform: false)
                self.sceneView.scene.anchors[0].addChild(self.nodeGirl!)
            } else {
                self.uploadChooseSceneInBackground()
            }
        }
    }

    @objc private func tapSecond() {
        if self.chooseModel != 1 {
            self.chooseModel = 1
            
            if self.nodeAvatar != nil {
                self.sceneView.scene.anchors[0].children[1].removeFromParent(preservingWorldTransform: false)
                self.sceneView.scene.anchors[0].addChild(self.nodeAvatar!)
            } else {
                self.uploadChooseSceneInBackground()
            }
        }
    }
    
    func uploadChooseSceneInBackground() {
        
        var cancellable: AnyCancellable? = nil
        
        cancellable = ModelEntity.loadModelAsync(named: self.arrayNameScene[self.chooseModel])
          .sink(receiveCompletion: { error in
            print("Unexpected error: \(error)")
            cancellable?.cancel()
          }, receiveValue: { entity in

              print ("uploadChooseSceneInBackground")
              
              if self.chooseModel == 0 {
                  self.nodeGirl = entity
              } else {
                  self.nodeAvatar = entity
              }
              
              self.sceneView.scene.anchors[0].children[1].removeFromParent(preservingWorldTransform: false)
              self.sceneView.scene.anchors[0].addChild(entity)

              cancellable?.cancel()
          })
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
    
    @objc private func tapZoomIn() {
//        sceneView.pointOfView?.camera.transform
//        sceneView.scene?.rootNode.camera
//        sceneView.scene?.rootNode.scale = SCNVector3(1.2, 1.2, 1.2)
        
    }
    
    @objc private func tapZoomOut() {
//        sceneView.scene?.rootNode.scale = SCNVector3(1.2, 1.2, 1.2)
    }
    
    @objc private func rotateDragY(_ gesture: UIPanGestureRecognizer) {
        
//        let point = gesture.translation(in: view)
//        sceneView.scene?.rootNode.runAction(SCNAction.rotateBy(x: 0, y: point.x/10, z: 0, duration: 0))
        
//        let velocity = gesture.velocity(in: view)
//        sceneView.scene?.rootNode.childNodes[1].runAction(SCNAction.rotateBy(x: 0, y: 0, z: velocity.x/1000, duration: 0))
        
//        gesture.setTranslation(.zero, in: view)
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

