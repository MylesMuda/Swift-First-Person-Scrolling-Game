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
    
    
    @IBOutlet weak var roadImage: UIImageView!
   
    @IBOutlet weak var shipImage: DraggedImageView!
    
    @IBOutlet weak var birdImage: UIImageView!
    
    @IBOutlet weak var birdTopImage: UIImageView!
    
    @IBOutlet weak var birdBottomImage: UIImageView!
    
    func ChangeBoundaries()
    {
        collisionBehavior.removeAllBoundaries()
        collisionBehavior.addBoundary(withIdentifier: "yeahman" as NSCopying, for: UIBezierPath(rect: shipImage.frame))
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        shipImage.myDelegate = self
        
        var imageArray: [UIImage]!
        var imageArray2: [UIImage]!
        var imageArray3: [UIImage]!
        
        imageArray = [  UIImage(named: "road1.png")!,
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
        
        imageArray2 = [ UIImage(named: "ship1.png")!,
                        UIImage(named: "ship2.png")!,
                        UIImage(named: "ship3.png")!,
                        UIImage(named: "ship4.png")!]
        
        imageArray3 = [ UIImage(named: "bird1.png")!,
                        UIImage(named: "bird2.png")!,
                        UIImage(named: "bird3.png")!,
                        UIImage(named: "bird4.png")!,
                        UIImage(named: "bird5.png")!,
                        UIImage(named: "bird6.png")!,
                        UIImage(named: "bird7.png")!,
                        UIImage(named: "bird8.png")!,
                        UIImage(named: "bird9.png")!,
                        UIImage(named: "bird10.png")!]
        
        roadImage.image = UIImage.animatedImage(with: imageArray, duration: 0.5)
        
        shipImage.image = UIImage.animatedImage(with: imageArray2, duration: 0.3)
        
        birdImage.image = UIImage.animatedImage(with: imageArray3, duration: 0.5)
        
        birdTopImage.image = UIImage.animatedImage(with: imageArray3, duration: 0.5)
        
        birdBottomImage.image = UIImage.animatedImage(with: imageArray3, duration: 0.5)
        
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        
        dynamicItemBehavior = UIDynamicItemBehavior(items: [birdImage, birdTopImage, birdBottomImage])
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -100, y: 0), for: birdImage)
        //dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -150, y: 25), for: birdTopImage)
        //dynamicAnimator.addBehavior(dynamicItemBehavior)
        
        self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -200, y: -35), for: birdBottomImage)
        
        
        collisionBehavior = UICollisionBehavior(items: [birdImage, birdTopImage,birdBottomImage])
        //collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        dynamicAnimator.addBehavior(collisionBehavior)
        
        collisionBehavior.addBoundary(withIdentifier: "yeahman" as NSCopying, for: UIBezierPath(rect: shipImage.frame))
        dynamicItemBehavior.allowsRotation = false
        dynamicItemBehavior.elasticity = 1
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

