//
//  GameScene.swift
//  FlappyBirdRemake
//
//  Created by Mahdi Sharif on 6/10/16.
//  Copyright (c) 2016 Mahdi Sharif. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Bird : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let pipePair : UInt32 = 0x1 << 3
    static let score : UInt32 = 0x1 << 4

}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var world = SKNode()
    var cam = SKCameraNode()
    var Bird = SKSpriteNode()
    var pipePair = SKNode()
    var Ground = SKSpriteNode()
    var Background = SKSpriteNode()
    var topPipe = SKSpriteNode()
    var btmPipe = SKSpriteNode()

    var moveAndRemove = SKAction()
    
    var Birdbw = SKTexture(imageNamed: "Birdbw.png")
    var TextureAltas = SKTextureAtlas()
    var TextureArray = [SKTexture]()
    
    

    var score = Int()
    var highScore = Int()
    
    var highScoreDefault = NSUserDefaults.standardUserDefaults()
    
    var gameStarted = Bool()
    var died = Bool()
    var pause = Bool()
    
    let scoreLbl = SKLabelNode()
    var restartBTN = SKLabelNode()
    var startBTN = SKLabelNode()
    var pauseBTN = SKLabelNode()
    var playBTN = SKLabelNode()
    var gameLbl = SKLabelNode()
    var gameLbl2 = SKLabelNode()
    var highScoreLbl = SKLabelNode()
    
    let one = SKLabelNode()
    let two = SKLabelNode()
    let three = SKLabelNode()
    
    
    var spawn = SKAction()
    var delay = SKAction()

    var spawnDelay = SKAction()
    var spawnDelayForever = SKAction()
    
    var movePipes = SKAction()
    var removePipes = SKAction()

    
    
    
    
    
    func pauseScene() {
        if pause == false {
            pause = true
            pauseBTN.hidden = true
            playBTN.hidden = false
            Bird.name = "Bird"
            Ground.name = "Ground"
            Background.name = "Background"
            
            
            /*self.removeActionForKey("spawnDelayForever")
            self.removeActionForKey("moveAndRemove")
            
            pipePair.paused = true
            
            enumerateChildNodesWithName("Bird", usingBlock: ({
                (node, error) in
                
                node.speed = 0
                node.physicsBody?.velocity = CGVectorMake(0, 0)
                node.physicsBody?.affectedByGravity = false
            

            
            }))
            
            stopAnimateBG(animateBG())*/


            
            let waitTime = SKAction.waitForDuration(0.1)
            runAction(waitTime)
            
            let pauseAction = SKAction.runBlock({
                () in
                
                self.scene!.view?.paused = true

            })
            
            
            let pauseDelay = SKAction.sequence([waitTime, pauseAction])
            self.runAction(pauseDelay)

        }
        
    
    }
    
    
    
    func playScene() {
        if pause == true {
            pause = false
            playBTN.hidden = true
            pauseBTN.hidden = false
            scene!.view?.paused = false
            Bird.physicsBody?.affectedByGravity = true
            
            /*self.runAction(spawnDelayForever)
            self.runAction(moveAndRemove)
            pipePair.paused = false
            
            enumerateChildNodesWithName("pipePair", usingBlock: ({
                (node, error) in
                
                node.paused = false
                node.speed = 1
                
                
            }))*/
            
            
            
            let waitTime = SKAction.waitForDuration(0.3)
            
            let hoverBird = SKAction.runBlock({
                () in
                
                self.view?.scene?.speed = 0.4
                self.Bird.physicsBody?.applyImpulse(CGVectorMake(0, 0.4))
            })
            
            let normalSpeed = SKAction.runBlock({
                () in
                
                self.view?.scene?.speed = 1.0
                
            })
            
            let sequence = SKAction.sequence([hoverBird, waitTime, normalSpeed])
            self.runAction(sequence)

            
            
            
            /*let threeAction = SKAction.runBlock({
                () in
                
                self.three.fontName = "04b_19"
                self.three.fontSize = 60
                self.three.text = "3"
                self.three.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.three.zPosition = 6
                self.three.hidden = false
            
                self.addChild(self.three)
                
                self.three.setScale(0)
                self.runAction(SKAction.scaleTo(1.0, duration: 0.3))
            
            })
            
            
            let twoAction = SKAction.runBlock({
                () in
                
                self.two.fontName = "04b_19"
                self.two.fontSize = 60
                self.two.text = "2"
                self.two.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.two.zPosition = 6
                self.two.hidden = false
                
                self.addChild(self.two)
                self.runAction(SKAction.scaleTo(1.0, duration: 0.3))

            
            })
            
                        
            let oneAction = SKAction.runBlock({
                () in
                
                
                self.one.fontName = "04b_19"
                self.one.fontSize = 60
                self.one.text = "1"
                self.one.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
                self.one.zPosition = 6
                self.one.hidden = false
                
                self.addChild(self.one)
                self.runAction(SKAction.scaleTo(1.0, duration: 0.3))

            
            })
            
            
            let countdown = SKAction.sequence([waitTime, threeAction, waitTime, twoAction, waitTime, oneAction])
            self.runAction(countdown)*/
            
            
            
        
        }
    
    }

    
    func restartScene(){
        
        self.removeAllChildren()
        self.removeAllActions()
        died = false
        gameStarted = false
        score = 0
        startBTN.hidden = false
        gameLbl.hidden = false
        gameLbl2.hidden = false
        highScoreLbl.hidden = false
        self.view?.scene?.speed = 1.0


        createScene()
    }
    
    func createScene(){
        
        //self.camera = cam
        
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 1.5 + 100)
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "04b_19"
        scoreLbl.fontSize = 60
        scoreLbl.zPosition = 4
        scoreLbl.hidden = true
        
        self.addChild(scoreLbl)
        
        startBTN.fontName = "04b_19"
        startBTN.fontSize = 60
        startBTN.text = "PLAY"
        startBTN.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 2) - 25)
        startBTN.zPosition = 6
        
        self.addChild(startBTN)
        
        gameLbl.fontName = "04b_19"
        gameLbl.fontSize = 50
        gameLbl.text = "FLAPPY BIRD"
        gameLbl.position = CGPoint(x: self.frame.width / 2, y: (self.frame.height / 1.5) + 100)
        gameLbl.zPosition = 6
        
        self.addChild(gameLbl)
        
        gameLbl2.fontName = "04b_19"
        gameLbl2.fontSize = 50
        gameLbl2.text = "FLAPPY BIRD"
        gameLbl2.position = CGPoint(x: self.frame.width / 2 + 5, y: (self.frame.height / 1.5) + 92)
        gameLbl2.zPosition = 5
        gameLbl2.fontColor = UIColor.blueColor()

        self.addChild(gameLbl2)
        
        highScoreLbl.fontName = "04b_19"
        highScoreLbl.fontSize = 23
        highScoreLbl.text = "High Score: \(highScore)"
        highScoreLbl.position = CGPoint(x: 290, y: 630)
        highScoreLbl.zPosition = 6
        
        self.addChild(highScoreLbl)
        
        pauseBTN.fontName = "04b_19"
        pauseBTN.fontSize = 35
        pauseBTN.text = "II"
        pauseBTN.position = CGPoint(x: 345, y: 625)
        pauseBTN.zPosition = 6
        pauseBTN.hidden = true
        
        self.addChild(pauseBTN)
        
        playBTN.fontName = "04b_19"
        playBTN.fontSize = 35
        playBTN.text = "▶︎"
        playBTN.position = CGPoint(x: 345, y: 625)
        playBTN.zPosition = 6
        playBTN.hidden = true
        
        self.addChild(playBTN)





        
        
        self.physicsWorld.contactDelegate = self
    
        
        
        for i in 0..<2 {
            Background = SKSpriteNode(imageNamed: "Background.png")
            Background.anchorPoint = CGPointZero
            Background.position = CGPointMake(CGFloat(i) * self.frame.width, 0)
            Background.name = "Background"
            Background.size = CGSize(width: (self.view?.bounds.width)! + 4, height: (self.view?.bounds.height)!)
            
            self.addChild(Background)
            
            Ground = SKSpriteNode(imageNamed: "Ground")
            Ground.anchorPoint = CGPoint(x: 0, y: 0.4)
            Ground.position = CGPointMake(CGFloat(i) * self.frame.width, 20)
            Ground.name = "Ground"
            Ground.size = CGSize(width: 440, height: 100)
            //Ground.position = CGPoint(x: self.frame.width / 2, y: 0 + Ground.frame.height / 2)
            
            Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
            Ground.physicsBody?.categoryBitMask = PhysicsCatagory.Ground
            Ground.physicsBody?.collisionBitMask = PhysicsCatagory.Bird
            Ground.physicsBody?.contactTestBitMask = PhysicsCatagory.Bird
            Ground.physicsBody?.affectedByGravity = false
            Ground.physicsBody?.dynamic = false
            
            Ground.zPosition = 2
            

            
            self.addChild(Ground)

    
        }
        
        
        TextureAltas = SKTextureAtlas(named: "Bird")
        
        for i in 1...TextureAltas.textureNames.count{
            
            let Name = "Flap\(i).png"
            TextureArray.append(SKTexture(imageNamed: Name))
        }
        
        Bird = SKSpriteNode(imageNamed: "Flap1.png")
        Bird.size = CGSize(width: 40, height: 30)
        Bird.position = CGPoint(x: self.size.width / 2 - 100, y: self.size.height / 2)
        Bird.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(TextureArray, timePerFrame: 0.1)))
        
        Bird.physicsBody = SKPhysicsBody(circleOfRadius: Bird.frame.height / 2)
        Bird.physicsBody?.categoryBitMask = PhysicsCatagory.Bird
        Bird.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.pipePair
        Bird.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.pipePair | PhysicsCatagory.score
        Bird.physicsBody?.affectedByGravity = false
        Bird.physicsBody?.dynamic
        
        Bird.zPosition = 3
        
        
        self.addChild(Bird)
        

    }
    
    
    
   
    
    
    override func didMoveToView(view: SKView) {
        
        if (highScoreDefault.valueForKey("highScore") != nil) {
            highScore = highScoreDefault.valueForKey("highScore") as! NSInteger
            highScoreLbl.text = ("High Score: \(highScore)")
        }
        
        createScene()
    }
    
    func createBTN() {
        restartBTN.fontName = "04b_19"
        restartBTN.fontSize = 60
        restartBTN.text = "RESTART"
        restartBTN.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
        restartBTN.zPosition = 5
        self.addChild(restartBTN)
        restartBTN.setScale(0)
        restartBTN.runAction(SKAction.scaleTo(1.0, duration: 0.3))

    }
    
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == PhysicsCatagory.score && secondBody.categoryBitMask == PhysicsCatagory.Bird || firstBody.categoryBitMask == PhysicsCatagory.Bird && secondBody.categoryBitMask == PhysicsCatagory.score {
            
            score += 1
            scoreLbl.text = "\(score)"
            runAction(SKAction.playSoundFileNamed("PointSE.mp3", waitForCompletion: false))
            
        }
        
        if /* bird & pipes */firstBody.categoryBitMask == PhysicsCatagory.Bird && secondBody.categoryBitMask == PhysicsCatagory.pipePair || firstBody.categoryBitMask == PhysicsCatagory.pipePair && secondBody.categoryBitMask == PhysicsCatagory.Bird ||/* bird & ground */ firstBody.categoryBitMask == PhysicsCatagory.Bird && secondBody.categoryBitMask == PhysicsCatagory.Ground || firstBody.categoryBitMask == PhysicsCatagory.Ground && secondBody.categoryBitMask == PhysicsCatagory.Bird {
            
        
            
            enumerateChildNodesWithName("pipePair", usingBlock: ({
                (node, error) in
                
                node.speed = 0
                self.removeAllActions()
            
                
            }))
            
            
            if died == false {
                died = true
                SKAction(runAction(SKAction.playSoundFileNamed("DiedSE.mp3", waitForCompletion: false)))
                Bird.removeAllActions()
                Bird.texture = SKTexture(imageNamed: "Birdbw.png")
                
                if highScore < score {
                    highScore = score
                    highScoreDefault.setValue(highScore, forKey: "highScore")
                    highScoreDefault.synchronize()
                }
                
                createBTN()
                
            }
        }
        
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        spawn = SKAction.runBlock({
                        () in
                        
                        self.createPipes()
                    })

        delay = SKAction.waitForDuration(2)
        spawnDelay = SKAction.sequence([spawn, delay])
        spawnDelayForever = SKAction.repeatActionForever(spawnDelay)

        
        if gameStarted == false {
            
            
            for touch in touches {
                let location = touch.locationInNode(self)
                if startBTN.containsPoint(location) {
                    
                    startBTN.hidden = true
                    gameLbl.hidden = true
                    gameLbl2.hidden = true
                    highScoreLbl.hidden = true
                    scoreLbl.hidden = false
                    pauseBTN.hidden = false
                    gameStarted = true
                    pause = false
                    Bird.physicsBody?.affectedByGravity = true
                    pipePair.name = "pipePair"
                    
                    
                    self.runAction(spawnDelayForever, withKey: "spawnDelayForever")
                
                    
                    
                    let distance = CGFloat(self.frame.width + pipePair.frame.width)
                    movePipes = SKAction.moveByX(-distance - 50, y: 0, duration: NSTimeInterval(0.008 * distance))
                    removePipes = SKAction.removeFromParent()
                    moveAndRemove = SKAction.sequence([movePipes, removePipes])
                    
                    Bird.physicsBody?.velocity = CGVectorMake(0, 0)
                    Bird.physicsBody?.applyImpulse(CGVectorMake(0, 11))
                    runAction(SKAction.playSoundFileNamed("FlapSE.mp3", waitForCompletion: false))
                    

                
                }
                
            }
            
            
            
            

        }else{
            
            if died == true || pause == true {
                
            
            }else{
            
                Bird.physicsBody?.velocity = CGVectorMake(0, 0)
                Bird.physicsBody?.applyImpulse(CGVectorMake(0, 11))
                runAction(SKAction.playSoundFileNamed("FlapSE.mp3", waitForCompletion: false))
                
            }
            
        }
        
        if died == false {
            for touch in touches{
                    let location = touch.locationInNode(self)
                    if (pause == false) {
                        if pauseBTN.containsPoint(location) {
                            pauseScene()
                        }
                    } else if (pause == true) {
                        if playBTN.containsPoint(location) {
                            playScene()
                            
                        }
                        
                        
                    }
                }

        }
        
        
        for touch in touches{
            let location = touch.locationInNode(self)
            if died == true{
                if restartBTN.containsPoint(location){
                    restartScene()
                }
            }
        }
        
        
        
    }
    
    
    
    
    
    func createPipes() {
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: 200)
        scoreNode.position = CGPoint(x: self.frame.width, y: self.frame.height / 2)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.dynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.Bird
  
        
        pipePair = SKNode()
        pipePair.name = "pipePair"
        
        topPipe = SKSpriteNode(imageNamed: "Pipedown.png")
        btmPipe = SKSpriteNode(imageNamed: "Pipeup.png")
        
        topPipe.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 308)
        btmPipe.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 308)
        
        topPipe.size = CGSize(width: 70, height: 500)
        btmPipe.size = CGSize(width: 70, height: 500)
        
        topPipe.physicsBody = SKPhysicsBody(rectangleOfSize: topPipe.size)
        topPipe.physicsBody?.categoryBitMask = PhysicsCatagory.pipePair
        topPipe.physicsBody?.collisionBitMask = PhysicsCatagory.Bird
        topPipe.physicsBody?.contactTestBitMask = PhysicsCatagory.Bird
        topPipe.physicsBody?.affectedByGravity = false
        topPipe.physicsBody?.dynamic = false
        
        btmPipe.physicsBody = SKPhysicsBody(rectangleOfSize: btmPipe.size)
        btmPipe.physicsBody?.categoryBitMask = PhysicsCatagory.pipePair
        btmPipe.physicsBody?.collisionBitMask = PhysicsCatagory.Bird
        btmPipe.physicsBody?.contactTestBitMask = PhysicsCatagory.Bird
        btmPipe.physicsBody?.affectedByGravity = false
        btmPipe.physicsBody?.dynamic = false
        

        
        
        pipePair.addChild(topPipe)
        pipePair.addChild(btmPipe)
        
        let randomPos = CGFloat.random(min: -200, max: 200)
        pipePair.position.y = pipePair.position.y + randomPos
        pipePair.addChild(scoreNode)
        
        pipePair.zPosition = 1
        
        pipePair.runAction(moveAndRemove, withKey: "moveAndRemove")
        self.addChild(pipePair)

        
    }
    
    func clamp(min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
            if (value > max) {
                return max
            } else if (value < min) {
                return min
            } else {
                return value
            }
                
    }
    
    
    func animateBG() -> SKAction {
        let animateBG = SKAction.runBlock({
            () in
            
            self.enumerateChildNodesWithName("Background", usingBlock: ({
                (node, error) in
                
                let bg = node as! SKSpriteNode
                bg.position = CGPoint(x: bg.position.x - 4, y: bg.position.y)
                
                if bg.position.x <= -bg.size.width {
                    bg.position = CGPointMake(bg.position.x + 375/*bg.size.width*/ * 2, bg.position.y)
                }
                
                
                
            }))
            
            self.enumerateChildNodesWithName("Ground", usingBlock: ({
                (node, error) in
                
                let gd = node as! SKSpriteNode
                gd.position = CGPoint(x: gd.position.x - 5, y: gd.position.y)
                
                if gd.position.x <= -gd.size.width {
                    gd.position = CGPointMake(gd.position.x + 400 * 2, gd.position.y)
                    
                }
                
            }))
            
            
            
        })
        
        return animateBG

        
    
    }
    
    func runAnimateBG(action: SKAction) {
        self.runAction(action)
    }
    
    
    func stopAnimateBG(action: SKAction) {
        action.speed = 0.0
    }
    
    
    

   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        
        if gameStarted == true {
            if died == false && pause == false {
                //cam.setScale(1)
                //cam.position = CGPoint(x: Bird.position.x + 70, y: 330)
                Bird.zRotation = clamp(-1, max: 0.3, value: (Bird.physicsBody?.velocity.dy)! + 250)
                
                runAnimateBG(animateBG())
                
                
                
            }
        }
    }

}