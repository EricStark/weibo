//
//  WeiboItem.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct WeiboItem: View {
    // 微博数据类
    let content: ContentModel
    
    @EnvironmentObject var userData: UserData
    
    var bindContent: ContentModel {
        userData.weiboItem(forId: content.id)!
    }
    
    var body: some View {
        var content = bindContent
        
        return VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 5) {
                // 头像
                showImage(content.avatar)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50)
                    .clipShape(Circle())
                    .overlay(
                        VIPWidget(isVip: content.vip)
                            .offset(x: 16, y: 16)
                    )
                // 昵称和日期
                VStack(alignment: .leading, spacing: 5) {
                    Text(content.name)
                        .font(.system(size: 16))
                        .foregroundColor(Color(red: 242/255, green: 99/255, blue: 4/255))
                        .lineLimit(1)
                    Text(content.date)
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                }.padding(.leading, 10)
                
                // 没有关注，则显示关注按钮
                if !content.isFollowed {
                    Spacer()
                    
                    Button(
                        action: {
                            content.isFollowed = true
                            self.userData.update(content)
                        },
                        label: {
                        Text("关注")
                            .font(.system(size: 14))
                            .foregroundColor(.orange)
                            .frame(width: 50, height: 26)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.orange,lineWidth: 1)
                            )
                    })
                        .buttonStyle(BorderlessButtonStyle())
                }
            }
            // 显示微博文字内容
            Text(content.text)
                .font(.system(size: 17))
            
            // 显示微博图片[一张图] -> [多张图]
            if !content.images.isEmpty {
                WeiboMultiImageView(images: content.images, width: UIScreen.main.bounds.width - 30)
            }
            
            Divider()
            
            // 底部的评论和点赞按钮
            HStack(spacing: 0) {
                Spacer()
                ItemBottomButton(imageName: "message", text: content.commentCountText, color: .black) {
                    print("点击了评论按钮")
                }
                Spacer()
                ItemBottomButton(imageName: content.isLiked ? "heart.fill" : "heart",
                                 text: content.likeCountText,
                                 color: content.isLiked ? .red : .black) {
                    if content.isLiked {
                        content.isLiked = false
                        content.likeCount -= 1
                    } else {
                        content.isLiked = true
                        content.likeCount += 1
                    }
                    self.userData.update(content)
                }
                Spacer()
            }
            
            Rectangle()
                .padding(.horizontal, -15)
                .frame(height: 10)
                .foregroundColor(Color(red: 238 / 255, green: 238 / 255, blue: 238 / 255))
        }
        .padding(.horizontal, 15) // 整个条目添加padding
        .padding(.top, 15)
    }
}

struct WeiboItem_Previews: PreviewProvider {
    static var previews: some View {
        return WeiboItem(content: UserData().weiboRecommendList.list[0]).environmentObject(UserData())
    }
}
