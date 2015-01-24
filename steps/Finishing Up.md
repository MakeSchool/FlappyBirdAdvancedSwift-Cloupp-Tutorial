Ending the Game
==================

Now that we have obstacles, we need a game over. For that, we need to check for a collision
between the character and an obstacle (or the ground). Like touches, we need another function for that.

Add the following below the closing bracket of your ```update``` method,
but before the closing bracket of the GameplayScene class:

	func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character: CCNode, level: CCNode) -> ObjCBool
	{
		self.gameOver()
		return true
	}

Keeping Score
=============

The last thing that we need to do is keep score. To do that, we first need to show
the current score. At the end of your ```initialize``` function, add:

	self.showScore()

If you run the game now, you will see a 0 displayed, even after you go through the
obstacles. That's because we need to add the logic to increment the score! To do that,
we need to check for another collision, this time with with an invisible area between
the pipes.

Add the following below the closing bracket of your ```ccPhysicsCollisionBegin``` function,
but before the closing bracket of the GameplayScene class:

	func ccPhysicsCollisionBegin(pair: CCPhysicsCollisionPair, character: CCNode, goal: CCNode) -> ObjCBool
	{
		goal.removeFromParent() //vs self.increaseScore
		points++
		self.updateScore()
		return true
	}

Run the game again and you should see your finished Flappy Bird game! Congratulations - you've
built your first iPhone game!

Want to make your own iPhone game? Enroll in our
[Online Academy](https://www.makeschool.com/online-academy/)!
