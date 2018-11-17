//
//  MainArSceneViewController.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 13.11.2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import UIKit
import ARKit
import RxSwift

class MainArSceneViewController: UIViewController {
    
    private let viewModel: MainArSceneViewModel
    private let arView: ARSCNView
    private let scene: MainArScene
    
    private var lastMLTest: TimeInterval = 0.0
    
    private let disposeBag = DisposeBag()
    
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
        self.setupObservers()
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
           self.captureImageAndAnalysis()
        }
    }
    
    private func captureImageAndAnalysis() {
        guard let captureImage = self.arView.session.currentFrame?.capturedImage else { return }
        self.viewModel.captureImage(captureImage)
    }
    
}

extension MainArSceneViewController {
    
    func setupObservers() {
        self.setupNodeObserver()
    }
    
    private func setupNodeObserver() {
        self.viewModel
            .newNodeLabel
            .asObservable()
            .observeOn(MainScheduler.instance)
            .filter{ $0 != nil}
            .map{ $0! }
            .subscribe(onNext: { [weak self] (newLabel) in
                if let worldPosition = self?.findPositionForCenter() {
                    self?.scene.addNode(with: newLabel, position: worldPosition)
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    private func findPositionForCenter() -> SCNVector3? {
        let results = self.arView.hitTest(self.view.center, types: .featurePoint)
        
        return  results.first?.worldTransform.translation.sceneVector3
    }
    
}
