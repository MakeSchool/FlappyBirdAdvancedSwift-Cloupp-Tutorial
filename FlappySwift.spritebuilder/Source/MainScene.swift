//
//  MainScene.swift
//  FlappySwift
//
//  Created by Benjamin Reynolds on 9/20/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

@objc
class MainScene: GameplayScene {
    
    var _ground1: CCNode!
    var _ground2: CCNode!
    var _grounds: [CCNode] = []
    
    var _sinceTouch: NSTimeInterval = 0
    var _obstacles: [Obstacle] = []
    var powerups: [CCNode] = []
    
    var _restartButton: CCButton!
    
    var _gameOver:Bool = false
    var _scoreLabel: CCLabelTTF!
    var _nameLabel: CCLabelTTF!
  
    var g1Pos: CGPoint!
    var g2Pos: CGPoint!
    
    override init() {}
  
    // is called when CCB file has completed loading
    func didLoadFromCCB() {
        
        userInteractionEnabled = true
        
        _grounds = [_ground1, _ground2]
        
        for ground in _grounds {
            // set collision type
            ground.physicsBody.collisionType = "level"
            ground.zOrder = DrawingOrder.Ground.rawValue
        }
        
        gamePhysicsNode.collisionDelegate = self
        
        _obstacles = []
        powerups = []
        points = 0
        
        trail = CCBReader.load("Trail") as! CCParticleSystem
        if let c_trail = trail {
            c_trail.particlePositionType = CCParticleSystemPositionType.Relative
            gamePhysicsNode.addChild(trail)
            c_trail.visible = false
        }
      
        g1Pos = _ground1.position
        g2Pos = _ground2.position

        super.initialize()
    }
    
//    override func addToScene(node: CCNode?) {
//        if let cNode = node {
//            gamePhysicsNode.addChild(node)
//        }
//    }
  
    override func showScore() {
        _scoreLabel.visible = true
    }
    
    override func updateScore() {
        _scoreLabel.string = "\(points)"
    }
    
    func handleTouch() {
        if !_gameOver {
            self.touchBegan()
            if let cCharacter = character {
                if cCharacter.physicsBody.velocity.y > 0
                {
                    cCharacter.physicsBody.applyAngularImpulse(10000.0)
                }
            }
            _sinceTouch = 0.0
        } else {
          restart()
      }
    }
    
    #if os(iOS)
    override func touchBegan(touch: CCTouch, withEvent event: CCTouchEvent) {
        handleTouch()
    }
    #elseif os(OSX)
    override func mouseDown(event: NSEvent) {
        handleTouch()
    }
    #endif

    override func gameOver() {
        if !_gameOver {
            _gameOver = true
//            timeSinceObstacle = 0
            if let cRestartButton = _restartButton {
                cRestartButton.visible = true
            }
            
            if let cCharacter = character {
                cCharacter.physicsBody.velocity = CGPoint(x:0.0, y:character!.physicsBody.velocity.y)
                cCharacter.rotation = 90.0
                cCharacter.physicsBody.allowsRotation = false
                cCharacter.stopAllActions()
            }
            
            let moveBy:CCActionMoveBy = CCActionMoveBy(duration: 0.2, position:CGPoint(x:-2.0,y:2.0))
            let reverseMovement:CCActionInterval = moveBy.reverse()
            let shakeSequence:CCActionSequence = CCActionSequence(one: moveBy, two: reverseMovement)
            let bounce:CCActionEaseBounce = CCActionEaseBounce(action: shakeSequence)
            
            self.runAction(bounce)
        }
    }

    override func restart() {
        print("RESTART");
        _restartButton.visible = false
        self.resetLevel()
    }

    override func addObstacle() {
        let obstacle:Obstacle = CCBReader.load("Obstacle") as! Obstacle
        let screenPosition = self.convertToWorldSpace(CGPoint(x:380,y:0))
        if let cPhysicsNode = gamePhysicsNode {
            let worldPosition = cPhysicsNode.convertToNodeSpace(screenPosition)
            obstacle.position = worldPosition
        }
        obstacle.setupRandomPosition()
        
        obstacle.zOrder = DrawingOrder.Pipes.rawValue
        if let cPhysicsNode = gamePhysicsNode {
            cPhysicsNode.addChild(obstacle)
        }
        _obstacles.append(obstacle)
    }

  
  //Currently broken, Cocos2D needs to be updated for the spritebuilder file to work.
    override func addPowerup() {
        let powerup:CCSprite = CCBReader.load("Powerup") as! CCSprite
      if _obstacles.count > 1 {
        let first:Obstacle = _obstacles[0]
        let second:Obstacle = _obstacles[1]
        if let cLast:Obstacle = _obstacles.last {
          if let cCharacter = character {
            powerup.position = CGPoint(x:cLast.position.x + (second.position.x-first.position.x)/4.0 + cCharacter.contentSize.width, y:CGFloat(arc4random()%488)+100)
            powerup.physicsBody.sensor = true
            powerup.zOrder = DrawingOrder.Pipes.rawValue
            gamePhysicsNode.addChild(powerup)
            powerups.append(powerup)

          }
        }
      }
    }
  
//    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character nodeA: CCNode, level nodeB: CCNode) -> ObjCBool {
//        self.collisionWithObstacle()
//        return false
//    }
  
//    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character nodeA: CCNode, ground nodeB: CCNode) -> ObjCBool {
//        self.collisionWithObstacle()
//        return true
//    }
  
//    func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character nodeA: CCNode, goal nodeB: CCNode) -> ObjCBool {
//        self.passedObstacle()
//        return false
//    }
  
    override func increaseScore() {
        points++
        self.updateScore()
    }
  
    func resetLevel() {
        gamePhysicsNode.position = CGPoint(x:0, y:0)
        _ground1.position = g1Pos
        _ground2.position = g2Pos
        for obs in _obstacles {
            obs.removeFromParent()
        }

        points = 0
        self.updateScore()
        character.removeFromParent()
        _gameOver = false
      
        super.initialize()
    }

    override func update(delta: CCTime) {
        _sinceTouch += delta
        
        if let cCharacter = character {
            cCharacter.rotation = clampf(cCharacter.rotation, -30.0, 90.0)
            if let cTrail = trail {
                cTrail.position = cCharacter.position
            }
        }

        let r = arc4random() % 255
        let g = arc4random() % 255
        let b = arc4random() % 255
        
//        if let cTrail = trail {
//            cTrail.startColor = CCColor(red:r, green:g, blue:b)
//        }
//         set trail color to CCColor(ccColor3b: ccc3(arc4random() % 255, arc4random() % 255, arc4random() % 255))
        
        if let cCharacter = character {
            if cCharacter.physicsBody.allowsRotation {
                let angularVelocity = clampf(Float(cCharacter.physicsBody.angularVelocity), -2.0, 1.0)
                cCharacter.physicsBody.angularVelocity = CGFloat(angularVelocity)
            }
            
            if _sinceTouch > 0.5 {
                cCharacter.physicsBody.applyAngularImpulse(CGFloat(-40000.0 * delta))
            }
        }

        if let cCharacter = character {
            gamePhysicsNode.position = CGPoint(x:gamePhysicsNode.position.x - (cCharacter.physicsBody.velocity.x * CGFloat(delta)),y:gamePhysicsNode.position.y)
        }
        
        for ground in _grounds {
            let groundWorldPosition = gamePhysicsNode.convertToWorldSpace(ground.position)
            let groundScreenPosition = self.convertToNodeSpace(groundWorldPosition)
            
            if groundScreenPosition.x <= (-1 * ground.contentSize.width) {
                ground.position = CGPoint(x:ground.position.x + 2 * ground.contentSize.width, y:ground.position.y)
            }
        }
        
        var offScreenObstacles:[Obstacle] = []
        
        for obstacle in _obstacles {
            let obstacleWorldPosition = gamePhysicsNode!.convertToWorldSpace(obstacle.position)
            let obstacleScreenPosition = self.convertToNodeSpace(obstacleWorldPosition)
            
            if obstacleScreenPosition.x < -obstacle.contentSize.width {
                offScreenObstacles.append(obstacle)
            }
        }

        if !_gameOver {
            if let cCharacter = character {
                cCharacter.physicsBody.velocity = CGPoint(x:cCharacter.physicsBody.velocity.x, y: min(cCharacter.physicsBody.velocity.y, 200.0))
            }
            
            super.update(delta)
        }
    
    }
    
}
