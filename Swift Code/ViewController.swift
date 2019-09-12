//
//  ViewController.swift
//  16004388
//
//  Created by mm16aft on 08/11/2018.
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
    @IBOutlet weak var gameover: UIView!
    @IBOutlet weak var scoreboard: UILabel!
    
    @IBAction func replay(_ sender: UIButton) {
        clearScreen()
        self.viewDidLoad()
        self.gameover.alpha = 0
        score = 0
    }
    
    func ChangeBoundaries()
    {
        collisionBehavior.removeAllBoundaries()
        collisionBehavior.addBoundary(withIdentifier: "yeahman" as NSCopying, for: UIBezierPath(rect: shipImage.frame))
    }
    
    var timeArray = [0, 2, 4, 6, 8, 10, 12, 14, 16, 18]
    var birds: UIImageView!
    var ship: UIImageView!
    var coin: UIImageView!
    var score = 0
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        GameMusicPlayer.musicPlayer.playGameMusic()
    
        dynamicAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehavior = UIDynamicItemBehavior(items: [])
        dynamicAnimator.addBehavior(dynamicItemBehavior)
        collisionBehavior = UICollisionBehavior(items: [])
        dynamicAnimator.addBehavior(collisionBehavior)
        //collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        
        shipImage.myDelegate = self
        
        var roadArray: [UIImage]!
        var planeArray: [UIImage]!
        
        roadArray = [   UIImage(named: "City0.png")!,
                        UIImage(named: "City1.png")!,
                        UIImage(named: "City2.png")!,
                        UIImage(named: "City3.png")!,
                        UIImage(named: "City3.png")!,
                        UIImage(named: "City4.png")!,
                        UIImage(named: "City5.png")!,
                        UIImage(named: "City6.png")!,
                        UIImage(named: "City7.png")!,
                        UIImage(named: "City8.png")!,
                        UIImage(named: "City9.png")!,
                        UIImage(named: "City10.png")!,
                        UIImage(named: "City11.png")!,
                        UIImage(named: "City12.png")!,
                        UIImage(named: "City13.png")!,
                        UIImage(named: "City14.png")!,
                        UIImage(named: "City15.png")!,
                        UIImage(named: "City16.png")!,
                        UIImage(named: "City17.png")!,
                        UIImage(named: "City18.png")!,
                        UIImage(named: "City19.png")!,
                        UIImage(named: "City20.png")!,
                        UIImage(named: "City21.png")!,
                        UIImage(named: "City22.png")!]
        
        planeArray =   [ UIImage(named: "plane1.png")!,
                        UIImage(named: "plane2.png")!,
                        UIImage(named: "plane3.png")!,
                        UIImage(named: "plane4.png")!]
        
        //Set dimensions and the animations for the plane and the city.
        shipImage.frame = CGRect(x:0, y: H*(0.2), width: 145, height: 110)
        roadImage.frame = CGRect(x:0, y: 0, width: W*1 , height: H*1)
        roadImage.image = UIImage.animatedImage(with: roadArray, duration: 1.4)
        shipImage.image = UIImage.animatedImage(with: planeArray, duration: 0.7)
        
        //Timer for birds
        for index in 0...8{
            let delay = Double(self.timeArray[index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                let birds = UIImageView(image: nil)
                var birdArray: [UIImage]
                //Animation and programatic spawn for birds
                birdArray = [ UIImage(named: "bird1.png")!,
                              UIImage(named: "bird2.png")!,
                              UIImage(named: "bird3.png")!,
                              UIImage(named: "bird4.png")!]
                
                birds.image = UIImage.animatedImage(with: birdArray, duration: 0.5)
                birds.frame = CGRect(x:self.W, y: CGFloat (arc4random_uniform(UInt32(self.H)-50)), width: 65, height: 65)
                
                self.view.addSubview(birds)
                self.view.bringSubview(toFront: birds)
                
                //Collision behaviours for birds
                self.dynamicItemBehavior.addItem(birds)
                self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -250, y: 0), for: birds)
                self.collisionBehavior.addItem(birds)
                self.dynamicItemBehavior.elasticity = 1
                self.collisionBehavior.action = {
                    if(birds.frame.intersects(self.shipImage.frame)) {
                        self.score -= 50
                    }
                }
            }

        }
        
        //Timer for coins
        for index in 0...8{
            let delay = Double(self.timeArray[index])
            let release = DispatchTime.now() + delay
            DispatchQueue.main.asyncAfter(deadline: release){
                let coin = UIImageView(image: nil)
                var coinArray: [UIImage]
                //Animation and programatic spawn for coins
                coinArray = [   UIImage(named: "coin1.png")!,
                                UIImage(named: "coin2.png")!,
                                UIImage(named: "coin3.png")!,
                                UIImage(named: "coin4.png")!,
                                UIImage(named: "coin5.png")!,
                                UIImage(named: "coin6.png")!]
                
                coin.image = UIImage.animatedImage(with: coinArray, duration: 0.5)
                coin.frame = CGRect(x: self.W , y: CGFloat (arc4random_uniform(UInt32(self.H)-50)), width: self.W*(0.075), height: self.H*(0.1))
                
                self.view.addSubview(coin)
                self.view.bringSubview(toFront: coin)
                
                //Collision behaviours for birds
                self.dynamicItemBehavior.addItem(coin)
                self.dynamicItemBehavior.addLinearVelocity(CGPoint(x: -200, y: 0), for: coin)
                self.collisionBehavior.addItem(coin)
                self.collisionBehavior.action = {
                    if(coin.frame.intersects(self.shipImage.frame)) {
                        self.view.sendSubview(toBack: coin)
                        self.score += 100
                    }
                }
            }
        
        }
        
        //Timer for game over screen
        let timer = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: timer){
            self.view.bringSubview(toFront: self.gameover)
            self.gameover.alpha = 1
            self.gameover.frame = CGRect(x:0, y: 0, width:self.W*1 , height:self.H*1)
            self.scoreboard.text = ("SCORE: " + String(self.score))
        }
        
    }

    func clearScreen(){
        for (aSubview) in self.view.subviews {
            if ((self.shipImage != aSubview) && (aSubview != roadImage) && (aSubview != birds) && (aSubview != coin) && (aSubview != gameover)){
                aSubview.removeFromSuperview()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

