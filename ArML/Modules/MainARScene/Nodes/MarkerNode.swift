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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupNode() {
        
        let geometry = SCNSphere(radius: 0.1)
        let spherNode = SCNNode(geometry: geometry)
        self.addChildNode(spherNode)
    }
    
}
