//
//  ViewController.swift
//  iCPU
//
//  Created by Yan Li on 10/9/15.
//  Copyright © 2015 eyeplum. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController
{
  
  @IBOutlet var CPUImageView: UIImageView!
  @IBOutlet var CPUInfoLabel: UILabel!
  
  override func viewDidLoad()
  {
    let (type, manufacture) = CPU.getTypeDisplayName()
    let identifier = CPU.getIdentifier()
    
    if let type = type
    {
      CPUImageView.image = UIImage(named: type)
    }
    
    if let manufacture = manufacture
    {
      CPUInfoLabel.text = "\(identifier) by \(manufacture)"
    }
    else
    {
      CPUInfoLabel.text = identifier
    }
  }
  
}

extension ViewController
{
  
  @IBAction private func showStaticsTapped()
  {
    let URL = NSURL(string: "http://demo.hiraku.tw/CPUIdentifier/chart.php")!
    let safariViewController = SFSafariViewController(URL: URL)
    presentViewController(safariViewController, animated: true, completion: nil)
  }
  
}
