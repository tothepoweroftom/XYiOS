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
    var cells: [XYCell]
    
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
        self.cells = [XYCell]()
    }
    
    func randomInit(){
        let cs = Int(self.cellsize)
        for i in 0..<self.phases.columns {
            for j in 0..<self.phases.rows {
                self.phases[i,j] = random01()*2*pi
                self.cells.append(XYCell(Point(i*cs, j*cs), self.phases[i,j], self.cellsize))
            }
        }

    }
    
    
    func draw(){

        
        var newphases = self.phases.copy()
        
        for i in 0..<self.ni {
            for j in 0..<self.nj {
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

                
            }
        }
        
        let tempphases = self.phases.copy()
        self.phases = newphases
        newphases = tempphases
        

                
            }
        }
    }
    
    
}
