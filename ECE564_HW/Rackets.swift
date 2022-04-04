//
//  Rackets.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 2/28/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import UIKit

class Rackets: UIView {
    
    override func draw(_ rect: CGRect) {
        // racket 1 handle
        let color3:UIColor = UIColor.blue
        let linePath7: UIBezierPath = UIBezierPath()
        linePath7.move(to: CGPoint(x: 95, y: 60))
        linePath7.addLine(to: CGPoint(x: 140, y: 60))
        linePath7.lineWidth = 6
        color3.set()
        linePath7.stroke()
        
        // racket 1 head
        let p = UIBezierPath(ovalIn: CGRect(x: 60, y: 50, width: 40, height: 20))
        UIColor.black.setFill()
        p.fill()
        
        // racket 2 handle
        let linePath8: UIBezierPath = UIBezierPath()
        linePath8.move(to: CGPoint(x: 76, y: 420))
        linePath8.addLine(to: CGPoint(x: 121, y: 420))
        linePath8.lineWidth = 6
        color3.set()
        linePath8.stroke()
        
        // racket 2 head
        let p2 = UIBezierPath(ovalIn: CGRect(x: 116, y: 410, width: 40, height: 20))
        UIColor.black.setFill()
        p2.fill()
    }
}
