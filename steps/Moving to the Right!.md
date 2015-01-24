Creating an Update Loop
=============

So far we have only made the character move vertically. Now we want to make it
move to the right, so it can progress through the level. Unlike jumping, we want the
character to be constantly moving on the X axis.

For this sort of logic, games typically use an "update loop." What happens is that some
code is run really fast - up to 60 times per second! That code usually checks things like
player health, whether enemies have died, or whether something should move!

In order to create an update loop, you need to add a new method. Below the
closing bracket of your ```touchBegan``` method, but before the closing bracket of the GameplayScene class, add:

	override func update(delta: CCTime)
	{
		// this will be run every frame.
		// delta is the time that has elapsed since the last time it was run.	}

You need to add the ```override``` before the ```func``` keyword in this case, because we are overriding the superclass ```update``` function.

Making the Character Move
=============

Now that we have an update loop, making the character move is easy. We just need to
set the horizontal velocity to 80 and not change the vertical velocity.

To do that, in your new ```update``` method, add:

	character.physicsBody.velocity = CGPoint(x:80, y:character.physicsBody.velocity.y)

The x-velocity is now a constant 80, while the y-velocity will remain dependent on the player's taps on the screen.