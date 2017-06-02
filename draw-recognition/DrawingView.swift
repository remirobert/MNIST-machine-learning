//
//  DrawingView.swift
//  draw-recognition
//
//  Created by Rémi Robert on 02/06/2017.
//  Copyright © 2017 Rémi Robert. All rights reserved.
//

import UIKit

protocol DrawingViewDelegate: class {
    func didStartToDraw()
}

class DrawingView: UIView {

    weak var delegate: DrawingViewDelegate?

    private let path = UIBezierPath()
    private var previousPoint = CGPoint.zero
    private var lineWidth: CGFloat = 12
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(self.pan(panGestureRecognizer:)))
        panGestureRecognizer.maximumNumberOfTouches = 1
        self.addGestureRecognizer(panGestureRecognizer)
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        UIColor.black.setStroke()
        path.stroke()
        path.lineWidth=lineWidth
    }
    
    func clear() {
        path.removeAllPoints()
        setNeedsDisplay()
    }
    
    @objc func pan(panGestureRecognizer:UIPanGestureRecognizer) -> Void {
        let currentPoint=panGestureRecognizer.location(in: self)
        let midPoint=self.midPoint(p0: previousPoint, p1: currentPoint)
        
        if panGestureRecognizer.state == .began {
            delegate?.didStartToDraw()
            path.move(to: currentPoint)
        } else if panGestureRecognizer.state == .changed {
            path.addQuadCurve(to: midPoint,controlPoint: previousPoint)
        }
        
        previousPoint=currentPoint
        self.setNeedsDisplay()
    }

    func midPoint(p0: CGPoint, p1: CGPoint) -> CGPoint {
        let x = (p0.x + p1.x) / 2
        let y = (p0.y + p1.y) / 2
        return CGPoint(x: x, y: y)
    }
}
