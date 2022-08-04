//
//  UserData.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/31.
//

import Combine

class UserData: ObservableObject {
    @Published var weiboRecommendList: ContentList = loadWeiboListData("PostListData_recommend_1.json")
    @Published var weiboHotList: ContentList = loadWeiboListData("PostListData_hot_1.json")
    
    private var recommendDic: [Int: Int] = [:]
    private var hotDic: [Int: Int] = [:]
    
    init() {
        for i in 0..<weiboRecommendList.list.count {
            let post = weiboRecommendList.list[i]
            recommendDic[post.id] = i
        }
        for i in 0..<weiboHotList.list.count {
            let post = weiboHotList.list[i]
            hotDic[post.id] = i
        }
    }
}

extension UserData {
    // 获取微博数据列表
    func weiboList(for category: WeiboCategory) ->ContentList {
        switch category {
        case .recommend:
            return weiboRecommendList
        case .hot:
            return weiboHotList
        }
    }
    
    // 获取微博单条数据
    func weiboItem(forId id: Int) -> ContentModel? {
        if let index = recommendDic[id] {
            return weiboRecommendList.list[index]
        }
        if let index = hotDic[id] {
            return weiboHotList.list[index]
        }
        return nil
    }
    
    // 更新微博数据
    func update(_ contentModel: ContentModel) {
        if let index = recommendDic[contentModel.id] {
            weiboRecommendList.list[index] = contentModel
        }
        if let index = hotDic[contentModel.id] {
            weiboHotList.list[index] = contentModel
        }
    }
}

enum WeiboCategory {
    case recommend
    case hot
}
