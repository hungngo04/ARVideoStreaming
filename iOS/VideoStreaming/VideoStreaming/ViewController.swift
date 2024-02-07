//
//  ViewController.swift
//  VideoStreaming
//
//  Created by Hung Ngo on 06/02/2024.
//

import UIKit
import SceneKit
import ARKit
import Foundation

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    var videoNode: SCNNode!
    var player: AVPlayer!
                
    func showLiveVideo() {
        // let fileURL = URL(fileURLWithPath: Bundle.main.path(forResource: "apple", ofType: "mp4")!)
        let videoURL = URL(string: "http://qthttp.apple.com.edgesuite.net/1010qwoeiuryfg/sl.m3u8")
        player = AVPlayer(url: videoURL!)

        let videoGeo = SCNPlane(width: 1.6, height: 0.9)
        videoGeo.firstMaterial?.diffuse.contents = player
        videoGeo.firstMaterial?.isDoubleSided = true
        
        let videoNode = SCNNode(geometry: videoGeo)
        self.videoNode = videoNode
        videoNode.position.z = -3
        
        sceneView.scene.rootNode.addChildNode(videoNode)
        player.play()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        // Setting up the scence
        sceneView.scene = SCNScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showLiveVideo();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
