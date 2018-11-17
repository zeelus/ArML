//
//  SceneKitExtension.swift
//  ArML
//
//  Created by pi29056 on 14/11/2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import Foundation
import SceneKit

extension SCNVector3 {
    
    ///  Convert SCNVector3 to float3
    var vector3: float3 {
        return float3(self.x, self.y, self.z)
    }
    
}

extension float4x4 {
    
    /// Get float3 position from 4x4 transform matrix
    var translation: float3 {
        let translation = self.columns.3
        return float3(translation.x, translation.y, translation.z)
    }
    
}

extension float3 {
    
    /// Convert scene vector for simd float3 vector
    var sceneVector3: SCNVector3 {
        return SCNVector3Make(self.x, self.y, self.z)
    }
    
}
