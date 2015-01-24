The First Obstacle
==================

So far our character is moving and jumping, but it's not really fun yet. Let's add obstacles
for Flappy to avoid!

For that we have created a simple method for you: ```addObstacle``` To use it, in your ```initialize```
method, simply add:

	self.addObstacle()

Then run the game. You should see a random obstacle appear!

More Obstacles
==============

Now that we have one obstacle, let's add more! We've set up the variable ```timeSinceObstacle``` of type ```CCTime``` for you. In the ```initialize``` function, set it to ```0```:

	timeSinceObstacle = 0

What we want to do is add a new obstacle at some regular interval.
This time in your ```update``` function, try adding:

	// Increment the time since the last obstacle was added
	timeSinceObstacle += delta; // delta is approximately 1/60th of a second

	// Check to see if two seconds have passed
	if timeSinceObstacle > 2
	{
		// Add a new obstacle
		self.addObstacle()

		// Then reset the timer.
		timeSinceObstacle = 0
	}

Now run the game again. See if you can make it easier or harder by making
the ```2``` higher or lower!
