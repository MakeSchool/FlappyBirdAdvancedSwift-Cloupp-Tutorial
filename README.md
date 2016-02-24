## Steps taken so far...
1. Update Cocos2D, Swift syntax
2. Move `Loader` from `GottaCode`
3. Modify `Loader` for Flappy
4. Switched `AppDelegate` with Obj-C version, change launch to `Loader`
5. Fixed bridging header to match GottaCode
6. Enabled Build Settings > Packaging > Defines module: yes
7. Built project, opened build products, copied `FlappySwift.swiftmodule/x86_64.swiftmodule` to root of build products
8. Deleted `FlappySwift.swiftmodule`, renamed `x86_64.swiftmodule` to `FlappySwift.swiftmodule`
9. Added new `FlappySwift.swiftmodule` to Xcode project
10. Modified resource settings so it is relative to build products
11. Modified pbxproj to remove `../Debug-iphoneos` from path
12. Cleaned project. It's now tricked into using generated `FlappySwift.swiftmodule` and treating it as a module instead of a folder (dragging it in directly treated it as a folder, steps 5-12 were to try and match GottaCode as closely as possible)
13. Trying to compile student code from Loader fails with segmentation fault
14. Added more empty interfaces to bridging header to try and fix some issues, still failed with segmentation fault
15. Tried changing inheritance to be MainScene > GameplayScene (student code, used by MainScene.ccb) from previous TutorialScene > GameplayScene (student code) > MainScene (used by MainScene.ccb). Still has segmentation fault but now giving marginally less cryptic errors