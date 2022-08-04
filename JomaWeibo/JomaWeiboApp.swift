//
//  JomaWeiboApp.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

@main
struct JomaWeiboApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView().environmentObject(UserData())
        }
    }
}
