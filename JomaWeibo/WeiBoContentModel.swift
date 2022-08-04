//
//  WeiBoContentModel.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct ContentList: Codable {
    var list: [ContentModel]
}

struct ContentModel: Codable, Identifiable {
    let id: Int
    let avatar: String
    let vip: Bool
    let name: String
    let date: String
    let text: String
    let images: [String]
    
    var isFollowed: Bool
    var commentCount: Int
    var likeCount: Int
    var isLiked: Bool
}

extension ContentModel {
    var commentCountText: String {
        if commentCount <= 0 { return "评论" }
        if commentCount < 1000 { return "\(commentCount)" }
        return String(format: "%.1fk", Double(commentCount) / 1000)
    }
    
    var likeCountText: String {
        if likeCount <= 0 { return "点赞" }
        if likeCount < 1000 { return "\(likeCount)" }
        return String(format: "%.1fk", Double(likeCount) / 1000)
    }
}

//let contentList = loadWeiboListData("PostListData_recommend_1.json")

func loadWeiboListData(_ fileName: String) -> ContentList {
    // 将文件名转化成URL
    guard let url = Bundle.main.url(forResource: fileName, withExtension: nil) else {
        fatalError("connot find \(fileName) in main bundle")
    }
    // 将URL转化成Data
    guard let data = try? Data(contentsOf: url) else {
        fatalError("connot tansfer \(url) to data")
    }
    // 通过Json解析器，解析Data数据成ContentList
    guard let list = try? JSONDecoder().decode(ContentList.self, from: data) else {
        fatalError("connot decode \(data) to list")
    }
    return list
}

func showImage(_ name: String) -> Image {
    return Image(uiImage: UIImage(named: name)!)
}
