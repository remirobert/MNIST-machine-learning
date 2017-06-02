//
//  PredictionService.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

let baseUrl = ""

protocol Prediction {
    func predict(pixels: [UInt8], completion: @escaping (Int?) -> Void)
}

class PredictionService: Prediction {
    
    private func bodyData(pixels: [UInt8]) -> Data? {
        let json: [String: Any] = ["image" : pixels, "label": 0]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        return jsonData
    }

    func predict(pixels: [UInt8], completion: @escaping (Int?) -> Void) {
        guard let url = URL(string: baseUrl) else { return }
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = self.bodyData(pixels: pixels)
        
        URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
            guard let data = data, let element = data.first else {
          	      completion(nil)
                return
            }
            let prediction = Int(element - 48)
            completion(prediction)
        }.resume()
    }
}
