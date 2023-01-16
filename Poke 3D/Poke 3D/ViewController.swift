//
//  ViewController.swift
//  Poke 3D
//
//  Created by Noman Ashraf on 1/14/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        if let cardToTrack = ARReferenceImage.referenceImages(inGroupNamed: "Cards", bundle: Bundle.main) {
            
            configuration.detectionImages = cardToTrack
            
            configuration.maximumNumberOfTrackedImages = 2
            
            print("Card Successfully Added")
            
            
        }
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        DispatchQueue.main.async {
            if let imageAnchor = anchor as? ARImageAnchor {
                
                let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
                //make plane see through
                plane.firstMaterial?.diffuse.contents = UIColor(white: 1.0, alpha: 0.6)
                
                let planeNode = SCNNode(geometry: plane)
                
                planeNode.eulerAngles.x = -.pi / 2
                
                node.addChildNode(planeNode)
                
                if imageAnchor.referenceImage.name == "card" {
                    if let pokeScene = SCNScene(named: "art.scnassets/Charizard.scn") {
                        print(pokeScene.rootNode.childNodes)
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            pokeNode.eulerAngles.x = .pi / 2
                            
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
                if imageAnchor.referenceImage.name == "snorl" {
                    if let pokeScene = SCNScene(named: "art.scnassets/Snorlax.scn") {
                        
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            
                            pokeNode.eulerAngles.x = .pi / 2
                            
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
                if imageAnchor.referenceImage.name == "meow" {
                    if let pokeScene = SCNScene(named: "art.scnassets/Meowth.scn") {
                        print(pokeScene.rootNode.childNodes)
                        if let pokeNode = pokeScene.rootNode.childNodes.first {
                            pokeNode.eulerAngles.x = .pi
                            planeNode.addChildNode(pokeNode)
                        }
                    }
                }
                
            }
        }
        return node
        
    }
    
}
