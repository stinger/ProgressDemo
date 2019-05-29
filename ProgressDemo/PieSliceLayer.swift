//
//  PieSliceLayer.swift
//  EnumsTest
//
//  Created by Ilian Konchev on 2/6/15.
//  Copyright (c) 2015 Sparkle Development. All rights reserved.
//

import UIKit

class PieSliceLayer: CALayer {

    var startAngle = CGFloat(-0.5 * Double.pi)
    @NSManaged var endAngle: CGFloat
    var maxAngle = CGFloat(1.5 * Double.pi)

    var center: CGPoint {
        return CGPoint(x: self.bounds.size.width/2, y: self.bounds.size.height/2)
    }
    var radius: CGFloat {
        return min(center.x - circleOffset, center.y - circleOffset)
    }

    var startPoint: CGPoint {
        let startPointX = Float(center.x) + Float(radius) * cosf(Float(startAngle))
        let startPointY = Float(center.y) + Float(radius) * sinf(Float(startAngle))
        return CGPoint(x: CGFloat(startPointX), y: CGFloat(startPointY))
    }

    var cw:Bool  {
        return (startAngle > endAngle) ? true : false
    }


    fileprivate var circleOffset:CGFloat = 30.0

    func makeAnimationForKey(_ key: String!) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: key)
        anim.fromValue = self.presentation()?.value(forKey: key)
        anim.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        anim.duration = 0.5
        return anim
    }

    override func action(forKey event: String) -> CAAction? {
        if event == "endAngle" {
            return makeAnimationForKey(event)
        }
        return super.action(forKey: event)
    }

    override init(layer: Any) {
        super.init(layer: layer)

        if ((layer as AnyObject).isKind(of: PieSliceLayer.self)) {
            if let other = layer as? PieSliceLayer {
                startAngle = other.startAngle
                endAngle = other.endAngle
            }
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override class func needsDisplay(forKey key: String) -> Bool {
        if (key == "endAngle") {
            return true
        }
        return super.needsDisplay(forKey: key)
    }

    override func draw(in ctx: CGContext) {
        if (self.endAngle < maxAngle)
        {
            let backgroundRect = CGRect(x: 0,y: 0,width: bounds.size.width,height: bounds.size.height)
            ctx.setBlendMode(CGBlendMode.destinationOver)
            ctx.addRect(backgroundRect)
            ctx.setFillColor(UIColor(white: 0.0, alpha: 0.4).cgColor)
            ctx.fillPath()

            ctx.beginPath()
            ctx.move(to: CGPoint(x: center.x, y: center.y))
            ctx.addLine(to: CGPoint(x: startPoint.x, y: startPoint.y))
            //CGContextAddArc(ctx, center.x, center.y, radius, startAngle, endAngle, cw)
            let arcCenter = CGPoint(x: center.x, y: center.y)
            ctx.addArc(center: arcCenter, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: cw)
            
            ctx.closePath()

            ctx.setFillColor(UIColor(white: 1.0, alpha: 1).cgColor)
            ctx.setLineCap(CGLineCap.round)

            ctx.setBlendMode(CGBlendMode.destinationOut)
            ctx.drawPath(using: CGPathDrawingMode.fill)

        } else {
            self.removeFromSuperlayer()
        }

    }

}
