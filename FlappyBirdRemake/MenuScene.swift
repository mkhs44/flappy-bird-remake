//
//  MenuScene.swift
//  FlappyBirdRemake
//
//  Created by Mahdi Sharif on 7/6/16.
//  Copyright © 2016 Mahdi Sharif. All rights reserved.
//


import Foundation
import SpriteKit

class MenuScene: GameScene {
    
    

    
    override func didMoveToView(view: SKView) {
        playBTN.fontName = "04b_19"
        playBTN.fontSize = 60
        playBTN.text = "PLAY"
        playBTN.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        playBTN.zPosition = 20
        playBTN.setScale(1)
        
        self.addChild(playBTN)
        
        
        Background = SKSpriteNode(imageNamed: "Background.png")
        Background.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        Background.name = "Background"
        Background.size = CGSize(width: (self.view?.bounds.width)! + 4, height: (self.view?.bounds.height)!)

        self.addChild(Background)
        
        }
            
            
        override func touchesBegan(touches: Set<UITouch>, withEvent: UIEvent?) {
            
            for touch in touches{
                let location = touch.locationInNode(self)
                if died == true{
                    if playBTN.containsPoint(location){
                        
                    }
                    
                        
                    
                    }
                }
                
            }

 
 
}

        

        
        
        
        
    
    
    
