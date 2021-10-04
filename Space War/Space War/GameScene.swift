//
//  GameScene.swift
//  Space War
//
//  Created by Sophia Zhu on 10/1/21.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // MARK: -vars
    let player = SKSpriteNode(imageNamed: "playerShip")
    let bulletSound = SKAction.playSoundFileNamed("laser.mp3", waitForCompletion: false)
    
//    func random() -> CGFloat {
//        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
//
//    }
//
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
            //return random() * (max-min) + min
            
            return CGFloat(arc4random_uniform(UInt32(max - min)) + UInt32(min))
           
        }
    
//    func random(min: CGFloat, max: CGFloat) -> CGFloat {
//        return random() * (max - min) + min
//    }
    
    
    
    var gameArea: CGRect
    override init(size: CGSize) {
        
        let maxAspectRatio: CGFloat = 16.0/9.0
        let playableWidth = size.height / maxAspectRatio
        let margin = (size.width - playableWidth) / 2
        gameArea = CGRect(x: margin, y: 0, width: playableWidth, height: size.height)
        
        
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //if turn to true, the entire bullet sound will play the whole time
    
    //create background
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.size = self.size
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)
        
        startNewLevel()
        
        //playship
        player.setScale(1)
        player.position = CGPoint(x: self.size.width/2, y: self.size.height * 0.2)
        player.zPosition = 2
        self.addChild(player)
    }
    
    
    func startNewLevel() {
        
        let spawn = SKAction.run(spawnEnemy)
        let waitToSpawn = SKAction.wait(forDuration: 1)
        let spawnSequence = SKAction.sequence([spawn, waitToSpawn])
        let spawnForever = SKAction.repeatForever(spawnSequence)
        self.run(spawnForever)
    }
    
    //MARK: - fire bullet
    func fireBullet() {
        let bullet = SKSpriteNode(imageNamed: "bullet")
        bullet.setScale(1)
        bullet.position = player.position
        bullet.zPosition = 1
        self.addChild(bullet)
        
        //make bullet shoot out
        let moveBullet = SKAction.moveTo(y: self.size.height + bullet.size.height, duration:  1)
        let deleteBullet = SKAction.removeFromParent()
        
        //use sequence to make sure bullet does in an order
        let bulletSequence = SKAction.sequence([bulletSound, moveBullet, deleteBullet])
        bullet.run(bulletSequence)
    }
    
    //MARK: - enemy
    func spawnEnemy() {
        let randomXStart = random(min: gameArea.minX, max: gameArea.maxX)
        let randomXEnd = random(min: gameArea.minX, max: gameArea.maxX)

        let startPoint = CGPoint(x: randomXStart, y: self.size.height * 1.2)
        let endPoint = CGPoint(x: randomXEnd, y: -self.size.height * 0.2)
       
        
        let enemy = SKSpriteNode(imageNamed: "enemyShip")
        enemy.setScale(1)
        enemy.position = startPoint
        enemy.zPosition = 2
        self.addChild(enemy)
        
        let moveEnemy = SKAction.move(to: endPoint, duration: 1.5)
        let deleteEnemy = SKAction.removeFromParent()
        let enemySequence = SKAction.sequence([moveEnemy, deleteEnemy])
        enemy.run(enemySequence)
        
        let dx = endPoint.x - startPoint.x
        let dy = endPoint.y - startPoint.y
        //rotate
        let amountToRotate = atan2(dy, dx)
        enemy.zRotation = amountToRotate
    }
    
    
 
    //do something when touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        fireBullet()
        spawnEnemy()
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let previousPointOfTouch = touch.previousLocation(in: self)
            let amountDragged = pointOfTouch.x - previousPointOfTouch.x
            player.position.x  += amountDragged
            
//            if player.position.x > gameArea.maxX - player.size.width/2 {
            if player.position.x > gameArea.maxX  {

                player.position.x = gameArea.maxX
            }
            if player.position.x < gameArea.minX {
                player.position.x = gameArea.minX
            }
        }
    }
    
}


