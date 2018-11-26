//
//  MarkerNode.swift
//  ArML
//
//  Created by pi29056 on 15/11/2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import SceneKit

class MarkerNode: SCNNode {
    
    private(set) var markerLabel: String
    
    init(markerLabel: String) {
        self.markerLabel = markerLabel
        super.init()
        self.setupNode()
        self.name = "MarkerNode<\(markerLabel)>"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNode() {
        
        let geometry = SCNSphere(radius: 0.01)
        let spherNode = SCNNode(geometry: geometry)
        self.addChildNode(spherNode)
        
        let textGeometry = SCNText(string: self.markerLabel, extrusionDepth: 0.1)
        let textNode = SCNNode(geometry: textGeometry)
        textNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
        self.addChildNode(textNode)
        
        let bilbordConstraint = SCNBillboardConstraint()
        
        self.constraints = [bilbordConstraint]
    }
    
}
