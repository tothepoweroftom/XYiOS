//
//  XYModel.swift
//  MagneticMusic
//
//  Created by Tom Power on 22/06/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import Foundation

class XYModel {
    var ready: Bool
    var lastDrawTime: Int
    var fps: Int
    var t: Int
    var nj: Int
    var ni: Int
    var cellsize: Double
    var canvas: View
    var phases: matrix
    var T: Float
    var B: Float
    var J: Float
    var pause: Bool
    
    init(cellsize: Double, gridnumber: Int, canvas: View) {
        self.ready = false
        self.lastDrawTime = 0
        self.fps = 0
        self.t = 0
        self.ni = gridnumber
        self.nj = gridnumber
        self.cellsize = cellsize
        self.canvas = canvas
        
        self.phases = zeros((ni,nj))
        self.T = 0.1
        self.B = 0.0
        self.J = 1.0
        self.pause = false
        
    }
    
    func randomInit(){
        
        for i in 0..<self.phases.columns {
            for j in 0..<self.phases.rows {
                self.phases[i,j] = random01()*2*pi
            }
        }

    }
    
    
    func draw(){
        var drawi = [[Int]]()
        var drawj = [[Int]]()
        
        for _ in 0..<360 {
            drawi.append([Int]())
            drawj.append([Int]())
        }
        
        var newphases = self.phases.copy()
        
        for i in 0..<self.ni-1 {
            for j in 0..<self.nj-1 {
                var f = 0.0
                f += (i > 0 ? sin(self.phases[i,j] - self.phases[i - 1,j]) : 0);
                f += (i < self.ni - 1 ? sin(self.phases[i,j] - self.phases[i + 1,j]) : 0);
                f += (j > 0 ? sin(self.phases[i,j] - self.phases[i,j - 1]) : 0);
                f += (j < self.nj - 1 ? sin(self.phases[i,j] - self.phases[i,j + 1]) : 0);
                
                f = f * self.J
                f += self.T * (2*random01() - 1)
                f += self.B * sin(self.phases[i,j])
                newphases[i,j] = self.phases[i,j] - f
                
                var c = Int(rad2deg(newphases[i,j]))%360
                if(c < 0){
                    c += 360
                }
//                print("c \(c)")
//                print(" i \(i)  j  \(j) ")
                drawi[c].append(i)
                drawj[c].append(j)
                
            }
        }
        
        let tempphases = self.phases.copy()
        self.phases = newphases
        newphases = tempphases
        
        
        //Actual drawing
        for c in 0..<360 {
            for n in 0..<drawi[c].count {
                let rad = deg2rad(Double(c))
                let x = self.cellsize * sin(rad)
                let y = self.cellsize * cos(rad)
                let hue = map(Double(c), min: 0.0, max: 360.0, toMin: 0.0, toMax: 1.0)
                let col = Color(hue: hue, saturation: 1.0, brightness: 1.0, alpha: 1.0)
                
                let a = Point(drawi[c][n]*Int(self.cellsize), drawi[c][n]*Int(self.cellsize))
                let b = Point(drawi[c][n]*Int(self.cellsize) + x, drawi[c][n]*Int(self.cellsize + y))
                let line = Line((a,b))
                line.strokeColor = col
                
                self.canvas.add(line)
                
            }
        }
    }
    
    
}
