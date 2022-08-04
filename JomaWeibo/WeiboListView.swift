//
//  WeiboListView.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct WeiboListView: View {
    let category: WeiboCategory
    
    @EnvironmentObject var userData: UserData
    
//    var contentList: ContentList {
//        switch category {
//        case .recommend:
//            return loadWeiboListData("PostListData_recommend_1.json")
//        case .hot:
//            return loadWeiboListData("PostListData_hot_1.json")
//        }
//    }
    
    var body: some View {
        List {
            ForEach(userData.weiboList(for: category).list) { item in
                NavigationLink(destination: WeiboDetailView(wContent: item)) {
                    WeiboItem(content: item)
                }
                .listRowInsets(EdgeInsets())
            }
        }
    }
}

struct WeiboListView_Previews: PreviewProvider {
    static var previews: some View {
        // 页面的跳转
        NavigationView {
            WeiboListView(category: .recommend)
                .navigationTitle("Title")
                .navigationBarHidden(true)
        }
    }
}
