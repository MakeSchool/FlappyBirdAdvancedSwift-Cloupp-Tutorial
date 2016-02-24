//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

#if DEBUG
#import <cocos2d.h>
#import <cocos2d-ui.h>
#import "Loader.h"
#else

// Make swiftc think we have cocos2d.h
@interface CCNode : NSObject
@end

@interface CCScene : CCNode
@end

@interface CCLabelTTF : CCNode
@end

#endif