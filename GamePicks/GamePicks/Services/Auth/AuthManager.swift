//
//  AuthManager.swift
//  GamePicks
//
//  Created by Rodrigo Llaguno on 02/09/25.
//

import FirebaseAuth
import FirebaseCore
import Foundation

enum AuthState {
  case authenticated //Anonymously Authenticated
  case signedOut //Not anonymously authenticated
}

@Observable
class AuthManager {
  var authState: AuthState = .signedOut
  
  init() {
    ensureAnonymousAuth()
  }
  
  private func ensureAnonymousAuth() {
    if let user = Auth.auth().currentUser {
      print("Already signed in anonymously with UID: \(user.uid)")
      authState = .authenticated
    } else {
      Auth.auth().signInAnonymously() { [weak self] result, error in
        if let error = error {
          print("Error signing in anonymously: \(error.localizedDescription)")
          self?.authState = .signedOut
          return
        }
        
        if let user = result?.user {
          print("Signed in anonymously with UID: \(user.uid)")
          self?.authState = .authenticated
        }
      }
    }
  }
  
}
