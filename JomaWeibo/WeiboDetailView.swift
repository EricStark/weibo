//
//  WeiboDetailView.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct WeiboDetailView: View {
    let wContent: ContentModel
    
    var body: some View {
        List {
            WeiboItem(content: wContent)
            ForEach(1...10,id: \.self) { index in
                Text("评论\(index)")
            }
        }
        .navigationBarTitle("详情", displayMode: .inline)
    }
}

struct WeiboDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let userData: UserData = UserData()
        return WeiboDetailView(wContent: userData.weiboRecommendList.list[0]).environmentObject(userData)
    }
}
