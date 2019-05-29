//
//  MyFirstCustomView.swift
//  EnumsTest
//
//  Created by Ilian Konchev on 2/5/15.
//  Copyright (c) 2015 Sparkle Development. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressView: UIView {

    fileprivate func calculateEndAngle(_ percentage: Double) -> CGFloat {
        let degrees = (percentage / 100) * 360.0
        let startAngle = (-0.5 * Double.pi)
        let radians = startAngle + (degrees * (Double.pi / 180))
        return CGFloat(radians)
    }

    fileprivate func getLayer(_ percentage: Double) -> PieSliceLayer
    {

        let startAngle = (-0.5 * Double.pi)
        let psl = PieSliceLayer(layer: layer)
        psl.frame = CGRect(x: 0,y: 0,width: bounds.size.width,height: bounds.size.height)
        psl.startAngle = CGFloat(startAngle)
        return psl
    }

    func delay(_ delay:Double, closure:@escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
    }

    fileprivate func draw(){
        let psl = getLayer(0.0)
        layer.addSublayer(psl)
        psl.endAngle = self.calculateEndAngle(10.0)

        delay(0.8) {
            psl.endAngle = self.calculateEndAngle(30.0)
        }
        delay(1.8) {
            psl.endAngle = self.calculateEndAngle(50.0)
        }
        delay(2.6) {
            psl.endAngle = self.calculateEndAngle(70.0)
        }
        delay(3.2) {
            psl.endAngle = self.calculateEndAngle(100.0)
        }
    }


    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        draw()

    }

}
