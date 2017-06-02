//
//  DrawingViewConvertor.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

extension DrawingView {
    func convertToImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: true)
        
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
}
