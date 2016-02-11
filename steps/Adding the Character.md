Creating the Character
===================

We've created a Character class for you to use. Swift automatically imports classes that are part of the same target, so it is ready for you to use.

To create the character, add the following line to the ```initialize``` function where it says
```// put your initialization code below this line```:

    // initialize the character
    character = Character.createFlappy()

In order for the character to appear on screen, you'll have to add it to the scene. On a new line
under where you initialized your character, write:

    // add the character to the scene
    gamePhysicsNode.addChild(character)

Now hit the run button and take a look at what you have built! You should see your
character fall to the bottom. That's because we haven't given it any velocity yet!

Basic Syntax
============

Swift syntax for declaring and calling functions is similar to languages like C++ and Java.

* To call a method: ```ObjectName.methodName()```
* For example: ```character.jump()```

* To call a method and pass a parameter: ```ObjectName.methodName(parameter)```
* For example: ```self.addChild(character)```
