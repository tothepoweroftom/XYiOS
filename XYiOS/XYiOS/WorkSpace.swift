//
//  WorkSpace.swift
//  XYiOS
//
//  Created by Tom Power on 22/06/2017.
//  Copyright © 2017 MOBGEN:Lab. All rights reserved.
//

import UIKit

class WorkSpace: CanvasController {
    

    var xy : XYModel!
    var timer: Timer!
    
    override func setup() {
        xy = XYModel(cellsize: 20.0, gridnumber: 32, canvas: canvas)
        xy.randomInit()
        xy.draw()
        canvas.backgroundColor = black;
        //Work your magic here.
        
        setupTimer()
   
    }
    
    func draw(){
        let rect = Rectangle(frame: Rect(view.frame))
        rect.fillColor = black
        canvas.add(rect)
        xy.draw()
    }
    

    func setupTimer() {
        //create a timer to run at 60fps
        timer = Timer(interval: 1.0/60.0) {
            self.draw()
        }
        timer?.start()
    }
}

