//
//  ViewController.swift
//  AlamofireSample
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    
    APIRequest.sharedInstance.readUser() {
      (json, success, error) in
      println("APIRequest.sharedInstance.readUser")
      println("json:\(json)\nsuccess:\(success)\nerror:\(error)")
      let origin = json["origin"]
      println("\(origin)")
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

