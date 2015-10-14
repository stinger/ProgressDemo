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

    private func calculateEndAngle(percentage: Double) -> CGFloat {
        let degrees = (percentage / 100) * 360.0
        let startAngle = (-0.5 * M_PI)
        let radians = startAngle + (degrees * (M_PI / 180))
        return CGFloat(radians)
    }

    private func getLayer(percentage: Double) -> PieSliceLayer
    {

        let startAngle = (-0.5 * M_PI)
        let psl = PieSliceLayer(layer: layer)
        psl.frame = CGRectMake(0,0,bounds.size.width,bounds.size.height)
        psl.startAngle = CGFloat(startAngle)
        return psl
    }

    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }

    private func draw(){
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
    override func drawRect(rect: CGRect) {
        // Drawing code
        draw()

    }

}
