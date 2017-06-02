//
//  UIImagePixels.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

extension UIImage {
    var pixelData: [UInt8] {
        let size = self.size
        let dataSize = size.width * size.height * 4
        var pixelData = [UInt8](repeating: 0, count: Int(dataSize))
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: &pixelData,
                                width: Int(size.width),
                                height: Int(size.height),
                                bitsPerComponent: 8,
                                bytesPerRow: 4 * Int(size.width),
                                space: colorSpace,
                                bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue)
        guard let cgImage = self.cgImage else { return [] }
        context?.draw(cgImage, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        
        var nextPixel = 0
        var greyPixels = [UInt8]()
        for pixel in pixelData {
            if nextPixel == 0 {
                greyPixels.append(pixel)
            }
            if nextPixel == 3 {
                nextPixel = 0
            } else {
                nextPixel += 1
            }
        }
        return greyPixels.map({ $0 == 255 ? 0 : 254 })
    }
}
