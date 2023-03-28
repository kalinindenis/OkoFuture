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
        
        DispatchQueue.global(qos: .default).async {
            
            generalVC.sceneView.scene = SCNScene()
            
            let sceneAvatar = SCNScene(named: generalVC.arrayNameScene[1])
            let sceneGirl = SCNScene(named: generalVC.arrayNameScene[0])
            
            let box = SCNBox(width: 1, height: 0.2, length: 1, chamferRadius: 0)
            box.firstMaterial?.diffuse.contents = UIColor.red
            box.firstMaterial?.isDoubleSided = true
            
            let nodeGirl = sceneGirl!.rootNode.childNode(withName: "iddle_skale", recursively: true)!
            let nodeAvatar = sceneAvatar!.rootNode.childNode(withName: "Avatar", recursively: true)!
            
            let boxNode = SCNNode(geometry: box)
            boxNode.position = SCNVector3(0, -0.2, 0)
            let nodeArray = [boxNode , nodeGirl , nodeAvatar]
            
            generalVC.sceneView.prepare(nodeArray, completionHandler: { (Bool) in
                
                print ("uploadScene")
                generalVC.nodeAvatar = nodeArray[2]
                generalVC.nodeGirl = nodeArray[1]
                
                generalVC.sceneView.scene?.rootNode.addChildNode(nodeArray[0])
                generalVC.sceneView.scene?.rootNode.addChildNode(nodeArray[1])
                
                self.navigationController?.pushViewController(generalVC,
                    animated: true)
            })
        }
        
    }
    
}
