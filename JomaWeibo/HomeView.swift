//
//  HomeView.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/31.
//

import SwiftUI

struct HomeView: View {
    @State var leftPercent: CGFloat = 0
    
    // 隐藏list默认的细小分割线
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                HScrollViewController(
                    pageWidth: geometry.size.width,
                    leftPercent: self.$leftPercent,
                    contentSize: CGSize(width: geometry.size.width * 2, height: geometry.size.height)) {
                        HStack(spacing: 0) {
                            WeiboListView(category: .recommend)
                                .frame(width: UIScreen.main.bounds.width)
                            WeiboListView(category: .hot)
                                .frame(width: UIScreen.main.bounds.width)
                        }
                }
            }
//            ScrollView(.horizontal, showsIndicators: false) {}
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarItems(leading: HomePageNavBar(leftPercent: $leftPercent))
            .navigationBarTitle("首页", displayMode: .inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(UserData())
    }
}
