//
//  Loader.m
//  FlappySwift
//
//  Created by Gerald on 10/28/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

#import "Loader.h"
#import "MBProgressHUD.h"

#include <spawn.h>
#include <dlfcn.h>

void showError(NSString *message) {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Uh Oh!" message:message delegate:nil cancelButtonTitle:nil otherButtonTitles: nil];
    [alert show];
}

#define QUOTE(...) #__VA_ARGS__
NSString *testCode = @QUOTE(
    import Foundation;
    import FlappySwift;
    class GameplayScene: MainScene {
        
        public override func initialize() {
            // put your initialization code below this line
            character = Character.createFlappy();
            gamePhysicsNode.addChild(character);
            
            // put your initialization code above this line
        };
        
        // put new methods below this line
        
        
        
        // put new methods above this line
        
    };
);

void compile() {
    NSString *exePath = [[NSBundle mainBundle] resourcePath];
    NSString* code = testCode;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *dataDir = [documentsDirectory stringByAppendingPathComponent:@"data/"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    
    while ([fileManager fileExistsAtPath:dataDir]) {
        [fileManager removeItemAtPath:dataDir error:&error];
    }
    
    [fileManager createDirectoryAtPath:dataDir withIntermediateDirectories:NO attributes:nil error:&error];
    
    NSString *inputPath = [dataDir stringByAppendingPathComponent:@"code.swift"];
    NSString *outputPath = [dataDir stringByAppendingPathComponent:@"libCode.dylib"];

    [code writeToFile:inputPath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    NSString *cmd = [NSString stringWithFormat:@"cd \"%@\"; /Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/swiftc -v -target x86_64-apple-ios9.0 -sdk /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator.sdk -emit-library -emit-module \"%@\" -module-name Code -I \"%@\" -Xlinker -undefined -Xlinker dynamic_lookup", dataDir, inputPath, exePath];
    
    char* argV[] = { "/bin/bash", "-c", (char *)[cmd UTF8String], '\0' };
    
    chdir([documentsDirectory UTF8String]);
    pid_t processID;
    int status = 0;
    
    for (int i = 0; i < 10; ++i) {
        posix_spawn(&processID, "/bin/bash", NULL, NULL, argV, NULL);
        while (waitpid(processID, &status, 0) <= 0);
        
        if (WEXITSTATUS(status) == 0) {
            break;
        }
        
        sleep(i);
    }
    
    if (WEXITSTATUS(status) != 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            showError(@"It looks like there might be an error in your code! Better go investigate!");
        });
        return;
    }
    
    void *handle = dlopen([outputPath UTF8String], RTLD_NOW);
    if (!handle) {
        dispatch_async(dispatch_get_main_queue(), ^{
            showError(@"Something went wrong :-( Please try again or contact support@makeschool.com");
        });
        return;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CCDirector sharedDirector] replaceScene:[CCBReader loadAsScene:@"MainScene"]];
    });
}

@implementation Loader

- (id)init {
    if (self == [super init]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[[CCDirector sharedDirector] view] animated:YES];
        [hud setLabelText:@"Compiling..."];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            compile();
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [hud hide:YES afterDelay:1.2];
            });
        });
    }
    return self;
}

@end
