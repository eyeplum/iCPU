//
//  ViewController.swift
//  iCPU
//
//  Created by Yan Li on 10/9/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
  
  @IBOutlet var CPUIdentifierLabel: UILabel!
  
  override func viewDidLoad()
  {
    CPUIdentifierLabel.text = CPU.getIdentifier()
  }
  
}

