//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#if DEBUG
#import <cocos2d.h>
#import <cocos2d-ui.h>
#else

// Make swiftc think we have cocos2d.h

@protocol CCPhysicsCollisionDelegate
@end

@interface CCNode : NSObject
@end

@interface CCScene : CCNode
@end

@interface CCPhysicsNode : CCNode
@end

@interface CCSprite : CCNode
@end

@interface CCLabelTTF : CCNode
@end

typedef double CCTime;

#endif