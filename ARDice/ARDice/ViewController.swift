//
//  ViewController.swift
//  ARDice
//
//  Created by Noman Ashraf on 1/2/23.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    var diceArray = [SCNNode]()

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        
        
        sceneView.autoenablesDefaultLighting=true

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            let touchPosition = touch.location(in: sceneView)
            
            guard let query = sceneView.raycastQuery(from: touchPosition, allowing: .existingPlaneGeometry, alignment: .any) else { return }
            let results = sceneView.session.raycast(query)
            guard let hitTestResult = results.first else {
                print("no surface found")
                return
            }
            let diceScene = SCNScene(named: "art.scnassets/diceCollada.scn")!
            if let diceNode = diceScene.rootNode.childNode(withName: "Dice", recursively: true){
                diceNode.position = SCNVector3(
                    x: hitTestResult.worldTransform.columns.3.x,
                    y: hitTestResult.worldTransform.columns.3.y + diceNode.boundingSphere.radius,
                    z: hitTestResult.worldTransform.columns.3.z
                )
                diceArray.append(diceNode)
                sceneView.scene.rootNode.addChildNode(diceNode)
                roll(dice: diceNode)
                
            }
            
        }
    }
    func rollAll(){
        if !diceArray.isEmpty {
            for dice in diceArray{
                roll(dice:dice)
            }
        }
    }
    @IBAction func rollAgain(_ sender: Any) {
        rollAll()
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollAll()
    }
    @IBAction func removeAll(_ sender: Any) {
        if !diceArray.isEmpty{
            for dice in diceArray{
                dice.removeFromParentNode()
            }
        }
    }
    func roll(dice: SCNNode){
        let randomx = Float(arc4random_uniform(4)+1) * (Float.pi/2)
        let randomz = Float(arc4random_uniform(4)+1) * (Float.pi/2)
        dice.runAction(
            SCNAction.rotateBy(x: CGFloat(randomx * 7),
                               y: 0,
                               z: CGFloat(randomz * 7),
                               duration: 0.7
                              )
        )
    }
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        if anchor is ARPlaneAnchor{
            let planeAnchor = anchor as! ARPlaneAnchor
            let plane = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.z))
            let planeNode = SCNNode()
            planeNode.position = SCNVector3(x: planeAnchor.center.x, y: 0, z: planeAnchor.center.z)
            planeNode.transform = SCNMatrix4MakeRotation(-Float.pi/2, 1, 0, 0)
            let gridMaterial = SCNMaterial()
            gridMaterial.diffuse.contents = UIImage(named:"art.scnassets/grid.png")
            plane.materials = [gridMaterial]
            planeNode.geometry = plane
            node.addChildNode(planeNode)
            
            print("plane detected")
        }
        else{
            return
        }
    }
    
}
