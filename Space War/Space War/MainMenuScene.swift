//
//  MainMenuScene.swift
//  Space War
//
//  Created by Sophia Zhu on 10/4/21.
//

import Foundation
import SpriteKit

class MainMenuScene: SKScene {
    override func didMove(to view: SKView) {
        
        
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        background.zPosition = 0
        self.addChild(background)

        let gameBy = SKLabelNode(fontNamed: "The Bold Font")
        gameBy.text = "Sophia's"
        gameBy.fontSize = 50
        gameBy.fontColor = UIColor.white
        gameBy.position = CGPoint(x: self.size.width * 0.5, y: self.size.height*0.78)
        gameBy.zPosition = 1
        self.addChild(gameBy)

        let gameName1 = SKLabelNode(fontNamed: "The Bold Font")
        gameName1.text = "Space"
        gameName1.fontSize = 200
        gameName1.fontColor = UIColor.white
        gameName1.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.7)
        gameName1.zPosition = 1
        self.addChild(gameName1)

        let gameName2 = SKLabelNode(fontNamed: "The Bold Font")
        gameName2.text = "War"
        gameName2.fontSize = 200
        gameName2.fontColor = UIColor.white
        gameName2.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.625)
        gameName2.zPosition = 1
        self.addChild(gameName2)

        let startGame = SKLabelNode(fontNamed: "The Bold Font")
        startGame.text = "Start Game"
        startGame.fontSize = 150
        startGame.fontColor = UIColor.white
        startGame.position = CGPoint(x: self.size.width*0.5, y: self.size.height*0.4)
        startGame.zPosition = 1
        startGame.name = "StartButton"
        self.addChild(startGame)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch: AnyObject in touches {
            let pointOfTouch = touch.location(in: self)
            let nodeITapped = atPoint(pointOfTouch)
            if nodeITapped.name == "StartButton" {
                
                let sceneToMoveTo = GameScene(size: self.size)
                sceneToMoveTo.scaleMode = self.scaleMode
                let myTrasition = SKTransition.fade(withDuration: 0.5)
                self.view!.presentScene(sceneToMoveTo, transition: myTrasition)
            }
        }
    }
}
