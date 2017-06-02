//
//  UIImageResize.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

extension UIImage {
    func resize(to newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
