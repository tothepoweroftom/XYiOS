//
//  XYCell.swift
//  XYiOS
//
//  Created by Tom Power on 22/06/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import Foundation

class XYCell {
    
    var a: Point
    var b: Point
    var color: Color
    var angle: Int
    var line: Line
    var canvas: View

    init(_ a: Point, _ angle: Double, _ radius: Double, _ canvas: View) {
        self.a = a

        self.b = Point(self.a.x + radius*cos(angle), self.a.y + radius*sin(angle))
        self.line = Line(begin: a, end: a)
        self.color = white
        self.angle = 0
        self.canvas = canvas
    }
    
    
    func render(_ radius: Int, _ angle: Double, _ color: Color ) -> Line {
        self.b = Point(self.a.x + Double(radius)*cos(angle), self.a.y + Double(radius)*sin(angle) )
        self.line = Line(begin: self.a, end: self.b)
        self.line.fillColor = color
        
        return self.line
        
        
        
    }
}
