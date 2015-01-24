Function Syntax
=============

To declare a function in Swift, follow the following format:

	func functionName(firstParameter: parameterType, secondParameter: parameterType) -> returnType 
	{
		//Body of function	}

The labels are optional, but are useful for adding clarity. 

For example, to declare a method that does not return anything and does not accept any parameters:

	func printHelloWorld()
	{
		println("Hello World!")	}

Or, to declare a method that returns an int and accepts a string:

	func doSomethingWithAString(myString: String)
	{
		//returns the number of characters in the string times 10
		return countElements(myString) * 10	}

Or, to declare a method that returns an array and accepts multiple strings:

	func makeAnArrayOfStrings(firstString: String, secondString: String, thirdString: String) -> [String]
	{
		return [firstString, secondString, thirdString]	}

Adding a jump!
=======================

For your game to respond to input, we have to write a new function to be run whenever
the player touches the screen. Add the following after the closing bracket of the initialize function
but before the closing bracket of the GameplayScene class:

	func touchBegan()
	{
		// this will get called every time the player
		// touches the screen.	}

Now that we have code that is run every time the player touches the screen, we want to make
the character jump. To do that, we need to add a physics impulse. Inside your ```touchBegan```
function, add the following code:

	var impulse = 200 - 2 * character.physicsBody.velocity.y
	character.physicsBody.applyImpulse(CGPoint(x:0, y:impulse))

Here the impulse is a vector pointing straight up, because it is zero in the x-direction. You can modify how far up the character
goes by modifying the ```200```.

Now run the game again. This time, try to click on the screen to see the fly jump up!
