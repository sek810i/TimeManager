//
//  Input.swift
//  TimeManager
//
//  Created by Богдан Олег on 10.05.17.
//  Copyright © 2017 Богдан Олег. All rights reserved.
//

import Foundation
import RealmSwift

class Input {
    let realm = try! Realm()
    
    func loadUser() -> [UserName] {
        let db = DbCon()
        db.loadUsersJSON()
        let listUsers = self.realm.objects(RealmUserName.self)
        var users = [UserName]()
        for ruser in listUsers {
            let user = UserName(login: ruser.email, password: ruser.password, id: ruser.id)
            users.append(user)
        }
        return users
    }
    
    func logout() {
        let realmUser = self.realm.objects(RealmUserName.self)
        try! self.realm.write {
            self.realm.delete(realmUser.last!)
        }
    }
    
    func checkLogin(user: UserName) -> Bool {
        let allUsers = loadUser()
        if allUsers.contains(where: { $0.login.lowercased() == user.login.lowercased() && $0.password == user.password }) {
            return true
        } else {
            return false
        }
    }
    
    func userLogIn(user: UserName) {
        if checkLogin(user: user) {
            let newUser = CurUser()
            let allUser = loadUser()
            newUser.id =  (allUser.first(where: { $0.login.lowercased() == user.login.lowercased() && $0.password == user.password } )?.id)!
            newUser.login = user.login
            newUser.password = user.password
            try! self.realm.write {
                self.realm.add(newUser, update: true)
            }
        }
    }
    func loadCurUser() -> Bool {
        let firstuser = CurUser()
        try! self.realm.write {
            self.realm.add(firstuser, update: true)
        }
        let user = self.realm.objects(CurUser.self)
        if user.last!.login != "" {
            return false
        } else {
            return true
        }
    }
}
