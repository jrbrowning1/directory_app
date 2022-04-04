//
//  TennisBall.swift
//  ECE564_HW
//
//  Created by Jonathan Browning on 2/28/22.
//  Copyright © 2022 ECE564. All rights reserved.
//

import UIKit

class TennisBall: UIView {
    
    override func draw(_ rect: CGRect) {
        // racket 1 head
        let p = UIBezierPath(ovalIn: CGRect(x: 80, y: 70, width: 10, height: 10))
        UIColor.yellow.setFill()
        p.fill()

    }
}
