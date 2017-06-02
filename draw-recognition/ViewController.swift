//
//  ViewController.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak private var drawingView: DrawingView!
    @IBOutlet weak fileprivate var buttonPrecition: UIButton!
    
    private let prediction: Prediction = PredictionService()
    
    private func handleResponse(result: Int?) {
        drawingView.clear()
        buttonPrecition.isHidden = true
        
        let message = result == nil ? "Error request" : "\(result ?? -1)"
        let alertController = UIAlertController(title: "Result", message: message, preferredStyle: .alert)
        
        if result == nil {
            alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        } else {
            alertController.addAction(UIAlertAction(title: "False", style: .destructive, handler: { _ in
                
            }))
            alertController.addAction(UIAlertAction(title: "True", style: .default, handler: { _ in
                
            }))
        }
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func predictDrawing(_ sender: Any) {
        guard let image = drawingView.convertToImage(),
            let resizedImage = image.resize(to: CGSize(width: 28, height: 28)) else { return }
        self.imageViewPreview.image = resizedImage
        
        let pixels = resizedImage.pixelData
        print(pixels)
        print(pixels.count)
        print(resizedImage.size)
        
        prediction.predict(pixels: pixels) { [weak self] result in
            DispatchQueue.main.async {
                self?.handleResponse(result: result)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonPrecition.isHidden = true
        drawingView.delegate = self
    }
}

extension ViewController: DrawingViewDelegate {
    func didStartToDraw() {
        buttonPrecition.isHidden = false
    }
}
