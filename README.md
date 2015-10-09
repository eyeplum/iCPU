# iCPU
The Swift implementation of [CPU-Identifier](https://github.com/hirakujira/CPU-Identifier) by [@hirakujira](https://twitter.com/hirakujira).

## Why a Swift version?

I "translated" [CPU-Identifier](https://github.com/hirakujira/CPU-Identifier) to a pure Swift version because I'd like to write some code involving C function pointers in Swift 2.0.

It was a huge pain to work with C function pointers in Swift 1.x, with the improvements comes with Swift 2.0, you may already find out that it is much easier to work with C function pointers in places like callbacks (e.g. `CVDisplayLinkSetOutputCallback`, `FSEventStreamCreate`, etc). 

But I'm still curious about what would it be like to work with something more dynamic. 

In this project, we have to use `dlsym` to get the function pointer of a private function hidden in `libMobileGestalt.dylib`, after that, we call the function with a `CFStringRef` as parameter and expect a return value of a `CFStringRef`.

As `dlsym` returns `UnsafeMutablePointer<Void>` (or `void *` in C), it would be painful to find a way to call the actual function in Swift 1.x. But in Swift 2.0, a simple `unsafeBitcast` will do the trick.

```Swift
typealias MGCopyAnswer = (@convention(c) (CFStringRef) -> CFStringRef)

let copyAnswerSymbol = dlsym(gestalt, "MGCopyAnswer".UTF8CString)
let copyAnswerFunction = unsafeBitCast(copyAnswerSymbol, MGCopyAnswer.self)

let result = copyAnswerFunction("HardwarePlatform") as String
```

Though I have scratched my head for a few hours until I've found the `@convention(c)` keyword in the [Documents](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/BuildingCocoaApps/InteractingWithCAPIs.html), the example shows that it is very clean and easy to use C function pointers in Swift 2.0.

## Build

- Xcode 7.0 and above
- Swift 2.0 and above

## Acknowledgement

This is a Swift implementation of [CPU-Identifier](https://github.com/hirakujira/CPU-Identifier) by [@hirakujira](https://twitter.com/hirakujira). 

The method to retrieve `HardwarePlatform` and the map between `HardwarePlatform` and CPU-Type are borrowed from [CPU-Identifier](https://github.com/hirakujira/CPU-Identifier).
