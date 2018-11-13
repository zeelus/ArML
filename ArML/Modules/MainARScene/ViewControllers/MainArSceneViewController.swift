//
//  MainArSceneViewController.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 13.11.2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import UIKit
import ARKit

class MainArSceneViewController: UIViewController {
    
    private let viewModel: MainArSceneViewModel
    private let arView: ARSCNView
    private let scene: MainArScene
    
    private var lastMLTest: TimeInterval = 0.0
    
    private static let timeBetweenTests = 0.3
    
    init(viewModel: MainArSceneViewModel, arView: ARSCNView, scene: MainArScene) {
        self.viewModel = viewModel
        self.arView = arView
        self.scene = scene
        self.arView.scene = scene
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = arView
    }
    
    override func viewDidLoad() {
        self.arView.delegate = self
        let configuration = ARWorldTrackingConfiguration()
        self.arView.session.run(configuration)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension MainArSceneViewController: ARSCNViewDelegate {
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        if (time - self.lastMLTest) >= MainArSceneViewController.timeBetweenTests {
            self.lastMLTest = time
            
        }
    }
    
}
