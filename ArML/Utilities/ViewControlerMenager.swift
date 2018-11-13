//
//  ViewControlerMenager.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 13.11.2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import UIKit
import ARKit

enum ViewControllerType {
    
    case mainArScene
    
}

class ViewControllerManager {
    
    public static let shered = ViewControllerManager()
    
    func getVC(_ type: ViewControllerType) -> UIViewController {
        switch type {
        case .mainArScene:
            return self.buildMainArScene()
        }
    }
    
}

fileprivate extension ViewControllerManager {
    
    func buildMainArScene() -> MainArSceneViewController {
        let viewModel = MLTrackerViewModel()
        let arView = ARSCNView()
        let mainScene = MainArScene()
        return MainArSceneViewController(viewModel: viewModel, arView: arView, scene: mainScene)
    }
}
