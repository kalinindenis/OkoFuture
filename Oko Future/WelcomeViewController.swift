//
//  WelcomeViewController.swift
//  Oko Future
//
//  Created by Denis on 26.03.2023.
//

import UIKit
import SceneKit

final class WelcomeViewController: UIViewController {
    
    private let welcomeImage: UIImageView = {
        let img = UIImage(named: "Welcome")
        let imgV = UIImageView(image: img)
        imgV.contentMode = .scaleAspectFill
        return imgV
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(welcomeImage)
        welcomeImage.frame = view.frame
        
        uploadScene()
    }
    
    private func uploadScene() {
            
        let generalVC = GeneralViewController()
        
        guard let sceneAvatar = SCNScene(named: generalVC.arrayNameScene[1]), let sceneGirl = SCNScene(named: generalVC.arrayNameScene[0])else {
                return
            }
        
        let sceneArray = [sceneGirl, sceneAvatar]
        
        generalVC.sceneView.prepare(sceneArray, completionHandler: { (Bool) in
            
            print ("uploadScene")
            generalVC.sceneAvatar = sceneArray[1]
            generalVC.sceneGirl = sceneArray[0]
            
            generalVC.sceneView.scene = sceneArray[generalVC.chooseModel]
            
            self.navigationController?.pushViewController(generalVC,
                animated: true)
        })
    }
    
}
