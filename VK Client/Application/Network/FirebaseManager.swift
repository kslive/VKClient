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
    
    private var ref = Database.database().reference()
    private var handle: AuthStateDidChangeListenerHandle!
    
    func configureAuthorization() {
        
        Auth.auth().signInAnonymously { result, error in
            
            guard let user = result?.user else {
                
                print(error!.localizedDescription)
                return
            }
            let isAnonymous = user.isAnonymous
            
            if isAnonymous {
                
                print(user.uid)
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
    
    func saveUser(userID: String) {
        
        let referenceChild = ref.child("Users")
        let value = userID
        
        referenceChild.setValue(value)
        
    }
    
    func saveUserGroups(userID: Int ,group: Group) {
        
        let referenceChild = ref.child("Users")
        
        var values = [[String : Any]]()
        
        let groupID = group.id
        guard let groupName = group.name else { return }
        
        let value: [String : Any] = [
            "id" : "\(groupID)",
            "groupName" : "\(groupName)",
        ]
        
        values.append(value)
        
        referenceChild.child("\(userID)").child("Group").setValue(values)
    }
}
