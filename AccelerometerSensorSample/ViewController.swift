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
        
        
        //Accelerometer
        if manager.isAccelerometerAvailable {
            let accelerometerHandler :CMAccelerometerHandler = { (data: CMAccelerometerData?, error: Error?) in
                let center = self.view.center
                let centX = Double(center.x)
                let centY = Double(center.y)
                
                let accX = data!.acceleration.x
                let accY = data!.acceleration.y
                let accZ = data!.acceleration.z
                
                //let g = 8.80665
                //let d = Double(center.x) / g

                self.xLabel.text = String(format: "%06f", accX)
                self.yLabel.text = String(format: "%06f", accY)
                self.zLabel.text = String(format: "%06f", accZ)
                
                
                self.circle.transform = CGAffineTransform(translationX: CGFloat(centX + accX*100), y: CGFloat(centY + accY*100))
            
            }
            manager.accelerometerUpdateInterval = 0.1
            manager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler: accelerometerHandler)
            
        }
        
        //Gyroscope data
        if manager.isGyroAvailable {
            
            let gyroHandler = { (data: CMGyroData?, error: Error?) in
                
                let pitch = data!.rotationRate.x
                let roll = data!.rotationRate.y
                let yaw = data!.rotationRate.z
                
                self.xPitch.text = String(format: "%06f", pitch)
                self.yRoll.text = String(format: "%06f", roll)
                self.zYaw.text = String(format: "%06f", yaw)
                
                
            }
            
            
            manager.gyroUpdateInterval = 0.1
            manager.startGyroUpdates(
                to: OperationQueue.current!,
                withHandler: gyroHandler)
        }
        
        
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


