//
//  UserModel.swift
//  AlamofireSample
//
//

import Foundation

class UserModel {
  private(set) var profile:UserEntity?
  
  func fetchProfile(completion:(error:NSError?) -> Void) {
    
    APIRequest.sharedInstance.readUser() {
      (json, success, error) in
      println("APIRequest.sharedInstance.readUser")
      println("json:\(json)\nsuccess:\(success)\nerror:\(error)")
      let origin = json["origin"]
      println("\(origin)")
      if success {
        self.profile = json
      }
      completion(error: nil)
      
      
      
    }
  }
  
}