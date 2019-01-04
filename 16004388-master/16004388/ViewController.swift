//
//  ViewController.swift
//  Myles_Test
//
//  Created by mm16aft on 08/12/2018.
//  Copyright © 2018 mm16aft. All rights reserved.
//

import UIKit
protocol subViewDelegate {
    func ChangeBoundaries()
}


class ViewController: UIViewController, subViewDelegate {

    var dynamicAnimator: UIDynamicAnimator!
    var dynamicItemBehavior: UIDynamicItemBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    let W = UIScreen.main.bounds.width
    let H = UIScreen.main.bounds.height
    
    @IBOutlet weak var roadImage: UIImageView!
    @IBOutlet weak var shipImage: DraggedImageView!
    
    func ChangeBoundaries()
    {
        collisionBehavior.removeAllBoundaries()
        collisionBehavior.addBoundary(withIdentifier: "yeahman" as NSCopying, for: UIBezierPath(rect: shipImage.frame))
    }
    
    var timeArray = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
    var birds: UIImageView!
    var ship: UIImageView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior(items: [])
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        collisionBehavior = UICollisionBehavior(items: [])
        dynamicAnimator.addBehavior(collisionBehavior)
        //collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        shipImage.myDelegate = self
        
        var roadArray: [UIImage]!
        var shipArray: [UIImage]!
        
        roadArray = [  UIImage(named: "road1.png")!,
                        UIImage(named: "road2.png")!,
                        UIImage(named: "road3.png")!,
                        UIImage(named: "road3.png")!,
                        UIImage(named: "road4.png")!,
                        UIImage(named: "road5.png")!,
                        UIImage(named: "road6.png")!,
                        UIImage(named: "road7.png")!,
                        UIImage(named: "road8.png")!,
                        UIImage(named: "road9.png")!,
                        UIImage(named: "road10.png")!,
                        UIImage(named: "road11.png")!,
                        UIImage(named: "road12.png")!,
                        UIImage(named: "road13.png")!,
                        UIImage(named: "road14.png")!,
                        UIImage(named: "road15.png")!,
                        UIImage(named: "road16.png")!,
                        UIImage(named: "road17.png")!,
                        UIImage(named: "road18.png")!,
                        UIImage(named: "road19.png")!]
        
        shipArray =   [ UIImage(named: "ship1.png")!,
                        UIImage(named: "ship2.png")!,
                        UIImage(named: "ship3.png")!,
                        UIImage(named: "ship4.png")!]
        
        roadImage.image = UIImage.animatedImage(with: roadArray, duration: 0.5)
        shipImage.image = UIImage.animatedImage(with: shipArray, duration: 0.3)
        
        for index in 0...9{
            let delay = Double(self.timeArray[index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                let birds = UIImageView(image: nil)
                var birdArray: [UIImage]
                
                birdArray = [ UIImage(named: "bird1.png")!,
                              UIImage(named: "bird2.png")!,
                              UIImage(named: "bird3.png")!,
                              UIImage(named: "bird4.png")!,
                              UIImage(named: "bird5.png")!,
                              UIImage(named: "bird6.png")!,
                              UIImage(named: "bird7.png")!,
                              UIImage(named: "bird8.png")!,
                              UIImage(named: "bird9.png")!,
                              UIImage(named: "bird10.png")!]
                
                birds.image = UIImage.animatedImage(with: birdArray, duration: 0.5)
                birds.frame = CGRect(x:500, y: CGFloat (arc4random_uniform(UInt32(self.H)-50)), width: 90, height: 90)
                
                self.view.addSubview(birds)
                self.view.bringSubview(toFront: birds)
                
                self.dynamicItemBehavior.addItem(birds)
                self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -125, y: 0), for: birds)
                self.collisionBehavior.addItem(birds)
                self.dynamicItemBehavior.allowsRotation = false
                self.dynamicItemBehavior.elasticity = 1
                
            }

        }
        
        for index in 0...9{
            let delay = Double(self.timeArray[index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                let coin = UIImageView(image: nil)
                var coinArray: [UIImage]
                
                coinArray = [UIImage(named: "coin.png")!]
                
                coin.image = UIImage.animatedImage(with: coinArray, duration: 0.5)
                coin.frame = CGRect(x: self.W , y: CGFloat (arc4random_uniform(UInt32(self.H)-50)), width: self.W*(0.1), height: self.H*(0.1))
                
                self.view.addSubview(coin)
                self.view.bringSubview(toFront: coin)
                
                self.dynamicItemBehavior.addItem(coin)
                self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -100, y: 0), for: coin)
                self.collisionBehavior.addItem(coin)
                
                self.collisionBehavior.action = {
                    if(coin.frame.intersects(self.shipImage.frame)) {
                        //remove/hide view
                        self.view.sendSubview(toBack: coin)
                        //add points
                    }
                }
            }
            
        }
        
        //let timer = DispatchTime.now() + 3
        //DispatchQueue.main.asyncAfter(deadline: timer){
        //    self.gameover.alpha = 1
        //}
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

