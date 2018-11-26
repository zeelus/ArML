//
//  MainArScene.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 13.11.2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import SceneKit


class MainArScene: SCNScene {
    
    private var markerNodes: [MarkerNode] = []
    
    func addNode(with label: String, position: SCNVector3) {
        let nearNodes = self.findNearNodes(position: position)
        
        if nearNodes.count == 0 {
            let node = MarkerNode(markerLabel: label)
            self.markerNodes.append(node)
            node.position = position
            self.rootNode.addChildNode(node)
        }
        
    }
    
    private func findNearNodes(position: SCNVector3) -> [MarkerNode] {
        return self.markerNodes.filter({ (node) -> Bool in
            let length = (node.position - position).length
            return length <= 0.5
        })
    }
    
}
