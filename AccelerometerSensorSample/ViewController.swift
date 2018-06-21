//
//  ViewController.swift
//  AccelerometerSensorSample
//
//  Created by Marina Arai on 2018/06/20.
//  Copyright © 2018 Marina Arai. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    
    let manager = CMMotionManager()
    
    
    //accelerometer
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var yLabel: UILabel!
    @IBOutlet weak var zLabel: UILabel!
    //gyroscope
    @IBOutlet weak var xPitch: UILabel!
    @IBOutlet weak var yRoll: UILabel!
    @IBOutlet weak var zYaw: UILabel!
    
    
    @IBOutlet weak var circle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let center = self.view.center
        var ballX = Double(center.x)
        var ballY = Double(center.y)
        circle.center = center
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        
        
        //Accelerometer
        if manager.isAccelerometerAvailable {
            
            manager.accelerometerUpdateInterval = 0.1
            
            let accelerometerHandler :CMAccelerometerHandler = { (data: CMAccelerometerData?, error: Error?) in
                
                
                let accX = data!.acceleration.x //変化量たち
                let accY = data!.acceleration.y
                let accZ = data!.acceleration.z
                
                let tX = (accX*20 + ballX)
                let tY = (accZ*5 + ballY)
                
                //display accelerometer value
                self.xLabel.text = String(format: "%06f", accX )
                self.yLabel.text = String(format: "%06f", accY )
                self.zLabel.text = String(format: "%06f", accZ )
                
                self.circle.transform = CGAffineTransform(translationX: CGFloat(ballX), y: CGFloat(ballY))
                
                ballY = tY
                ballX = tX
//                if (0 < tX && tX < Double(myBoundSize.width)) { ballX = tX }
//                if (0 < tY && tY < Double(myBoundSize.height)) { ballY = tY }
            
            }
            
            manager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: accelerometerHandler)
            
        }
        
        //Gyroscope data
//        if manager.isGyroAvailable {
//
//            let gyroHandler = { (data: CMGyroData?, error: Error?) in
//
//                let pitch = data!.rotationRate.x
//                let roll = data!.rotationRate.y
//                let yaw = data!.rotationRate.z
//
//                self.xPitch.text = String(format: "%06f", pitch)
//                self.yRoll.text = String(format: "%06f", roll)
//                self.zYaw.text = String(format: "%06f", yaw)
//
//
//            }
//
//
//            manager.gyroUpdateInterval = 0.1
//            manager.startGyroUpdates(
//                to: OperationQueue.current!,
//                withHandler: gyroHandler)
//        }
        
        
    }
    
    func stopAccelerometer(){
        if(manager.isAccelerometerActive){
            manager.stopAccelerometerUpdates()
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
}


