//
//  MainArSceneViewModel.swift
//  ArML
//
//  Created by Gilbert Gwizdała on 13.11.2018.
//  Copyright © 2018 Gilbert Gwizdała. All rights reserved.
//

import RxSwift
import Vision

protocol MainArSceneViewModel {
    
    var newNodeLabel: BehaviorSubject<String?> { get }
    
    func captureImage(_ image: CVPixelBuffer)
    
}

class MLTrackerViewModel: MainArSceneViewModel {
    
    var newNodeLabel = BehaviorSubject<String?>(value: nil)
    
    private let queue = DispatchQueue(label: "MLTracker", qos: .userInitiated, attributes: .concurrent)
    private var classificationRequest: VNCoreMLRequest? = nil
    
    init() {
        guard let model = try? VNCoreMLModel(for: MobileNet().model) else { return }
        
        self.classificationRequest = VNCoreMLRequest(model: model, completionHandler: { [weak self] (request, error) in
            
            guard error == nil else {
                print(error.debugDescription)
                return
            }
            
            guard let results = request.results else {
                print("Empty result list")
                return
            }
            
            self?.analisisResults(results: results as? [VNClassificationObservation] ?? [])
            
        })
    }
    
    fileprivate func analisisResults(results: [VNClassificationObservation]) {
        guard let result = results.first else { return }
        guard let substring = result.identifier.split(separator: " ").last else { return }
        
        self.newNodeLabel.onNext("\(substring)")
    }
    
    func captureImage(_ image: CVPixelBuffer) {
        
        queue.sync {
            guard let classificationRequest = self.classificationRequest else { return }
            let handler = VNImageRequestHandler(cvPixelBuffer: image)
            do {
                try handler.perform([classificationRequest])
            } catch {
                print(error.localizedDescription)
            }
            
        }
        
    }
    
    
}
