//
//  TutorialScene.swift
//  FlappySwift
//
//  Created by Gerald Monaco on 10/2/14.
//  Copyright (c) 2014 Apportable. All rights reserved.
//

import Foundation

public class TutorialScene: CCNode, CCPhysicsCollisionDelegate {
    public var timeSinceObstacle: CCTime = 0
    public var character: Character!
    public var gamePhysicsNode: CCPhysicsNode!
    public var points: Int = 0
    public var trail: CCParticleSystem!
    
    public func touchBegan() { }
      
    public func addObstacle() {}
    
    public func showScore() {}
    
    public func increaseScore() {}
    
    public func updateScore() {}
    
    public func gameOver() {}
    
    public func addPowerup() {}
    
    public func restart() {}
    
    public func collisionWithObstacle() {}
    
    public func passedObstacle() {}
    
    override public func update(delta: CCTime) {}
}