import Foundation

class GameplayScene: TutorialScene {
    
  var timeSinceObstacle: CCTime = 0
  
  func initialize()
  {
    character = Character.createFlappy()
    
    physicsNode.addChild(character) //vs. self.addToScene(character)
    self.addObstacle()
    self.showScore()
  }
  
  override func touchBegan() //vs tap()
  {
    var impulse = 200 - 2 * character.physicsBody.velocity.y //vs. character.flap()
    character.physicsBody.applyImpulse(CGPoint(x:0, y:impulse))
    
  }

  override func update(delta: CCTime) {

    character.physicsBody.velocity = CGPoint(x:80, y:character.physicsBody.velocity.y) //vs character.move()

    timeSinceObstacle += delta

    if timeSinceObstacle > 2
    {
      self.addObstacle()
      timeSinceObstacle = 0
    }
  }
//
//  
////  //vs being called "collisionWithObstacle()"
  func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, character nodeA: CCNode!, level nodeB: CCNode!) -> Bool
  {
    self.gameOver()
    return true
  }
//
////  //vs being called "passedObstacle()"
  func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, character nodeA: CCNode!, goal: CCNode!) -> Bool
  {
    goal.removeFromParent() //vs self.increaseScore
    points++
    self.updateScore()
    return true
  }
  
  func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair!, character nodeA: CCNode!, powerup: CCNode!) -> Bool
  {
    trail.visible = true
    return true
  }
}
