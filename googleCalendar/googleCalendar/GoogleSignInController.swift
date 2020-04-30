//
//  GoogleSignInController.swift
//  googleCalendar
//
//  Created by 김희수 on 2020/04/07.
//  Copyright © 2020 taitty. All rights reserved.
//
import GoogleSignIn
import ReactiveSwift

class GoogleSignInController: NSObject, GIDSignInDelegate {
    
    private var disposible = CompositeDisposable()
    
    init(viewController: ViewController) {
        super.init()
        
        GIDSignIn.sharedInstance()?.clientID = "912444868039-q7at2vhpsh1od86j387g0psgmug5m51k.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = viewController
        GIDSignIn.sharedInstance()?.scopes = ["https://www.googleapis.com/auth/calendar"]
        
        print("GoogleSignInController init...")
    }
    
    func doSignIn() {
        GIDSignIn.sharedInstance()?.signIn()
        print("signed in...")
    }
    
    func doSignOut() {
        GIDSignIn.sharedInstance()?.signOut()
        print("signed out...")
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if let error = error {
            if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
                print("The user has not signed in before or they have since signed out.")
            } else {
                print("\(error.localizedDescription)")
            }
            return
        }
      
        let aToken = user.authentication.accessToken
      
        print("aToken : \(String(describing: aToken))")
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        print("error : \(String(describing: error))")
    }
}
