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
    
    @IBAction func predictDrawing(_ sender: Any) {
        guard let image = drawingView.convertToImage(),
        let resizedImage = image.resize(to: CGSize(width: 28, height: 28)) else { return }
        self.imageViewPreview.image = resizedImage
        
        let pixels = resizedImage.pixelData
        print(pixels)
        print(pixels.count)
        print(resizedImage.size)
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
