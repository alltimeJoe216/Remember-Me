//
//  User.swift
//  RememberMe
//
//  Created by Joe Veverka on 7/13/20.
//  Copyright © 2020 Joe Veverka. All rights reserved.
//

import Foundation
import Firebase

struct User {
  
  let uid: String
  let email: String
  
  init(authData: Firebase.User) {
    uid = authData.uid
    email = authData.email!
  }
  
  init(uid: String, email: String) {
    self.uid = uid
    self.email = email
  }
}
