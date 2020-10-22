//
//  FirebaseManager.swift
//  VK Client
//
//  Created by Eugene Kiselev on 22.10.2020.
//  Copyright © 2020 Eugene Kiselev. All rights reserved.
//

import FirebaseAuth
import FirebaseDatabase

class FirebaseManager {
    
    private var ref: DatabaseReference?
    private var handle: AuthStateDidChangeListenerHandle!
    
    func removeStateDidChangeListener() {
        
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    func configureAuthorization() {
        
        Auth.auth().signInAnonymously { result, error in
            
            guard let user = result?.user else {
                
                print(error!.localizedDescription)
                return
            }
            let isAnonymous = user.isAnonymous
            let uid = user.uid
            
            if isAnonymous {
                print(uid)
            }
        }
    }
    
    func logOut(onCompleted: @escaping () -> ()) {
        
        do {
            try Auth.auth().signOut()
            
            onCompleted()
        } catch (let error) {
            print("Auth sign out failed: \(error)")
        }
    }
    
    func observeAuthUser(onCompleted: @escaping () -> ()) {
        
        handle = Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                
                onCompleted()
            }
        }
    }
}
