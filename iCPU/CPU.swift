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
