//
//  CPU.swift
//  iCPU
//
//  Created by Yan Li on 10/9/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import UIKit

public class CPU
{
  
  // MARK: - Public
  
  public class func getIdentifier() -> String?
  {
    let copyAnswerSymbol = dlsym(sharedInstance.gestalt, Consts.copyAnswerSymbol)
    let copyAnswerFunction = unsafeBitCast(copyAnswerSymbol, MGCopyAnswer.self)
    return copyAnswerFunction(Consts.hardwarePlatform) as String
  }
  
  public class func getTypeDisplayName() -> (type: String?, manufacture: String?)
  {
    guard let identifier = getIdentifier()?.lowercaseString else
    {
      return (nil, nil)
    }
    
    switch identifier
    {
    case "s8000":
      return ("A9", "Samsung")
      
    case "s8003":
      return ("A9", "TSMC")
      
    default:
      break
    }
    
    if (identifier.hasPrefix("s5l8960") || identifier.hasPrefix("s5l8965"))
    {
      return ("A7", nil)
    }
    
    if (identifier.hasPrefix("t7000"))
    {
      return ("A8", nil)
    }
    
    if (identifier.hasPrefix("t7001"))
    {
      return ("A8X", nil)
    }
    
    if (identifier.hasPrefix("s5l8950"))
    {
      return ("A6", nil)
    }
    
    if (identifier.hasPrefix("s5L8955"))
    {
      return ("A6X", nil)
    }
    
    if (identifier.hasPrefix("s5l8940") || identifier.hasPrefix("s5l8942"))
    {
      return ("A5", nil)
    }
    
    if (identifier.hasPrefix("s5l8945"))
    {
      return ("A5X", nil)
    }
    
    if (identifier.hasPrefix("s5l8930"))
    {
      return ("A4", nil)
    }
    
    return (nil, nil)
  }
  
  // MARK: - Private

  private typealias MGCopyAnswer = (@convention(c) (CFStringRef) -> CFStringRef)
  
  private struct Consts
  {
    private static let libMobileGestaltPathCString = "/usr/lib/libMobileGestalt.dylib".UTF8CString
    private static let copyAnswerSymbol = "MGCopyAnswer".UTF8CString
    private static let hardwarePlatform = "HardwarePlatform"
  }
  
  private static let sharedInstance = CPU()
  
  private let gestalt: UnsafeMutablePointer<Void>
  
  private init()
  {
    gestalt = dlopen(Consts.libMobileGestaltPathCString, RTLD_GLOBAL | RTLD_LAZY)
  }
  
}

private extension String
{
  
  var UTF8CString: [CChar] {
    return cStringUsingEncoding(NSUTF8StringEncoding)!
  }
  
}
