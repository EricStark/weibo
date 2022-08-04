//
//  WeiboMultiImageView.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

private let kImageSpace: CGFloat = 6

struct WeiboMultiImageView: View {
    let images: [String]
    let width: CGFloat

    var body: some View {
        Group {
            if images.count == 1 {
                showImage(images[0])
                    .resizable()
                    .scaledToFill()
                    .frame(width: width, height: width * 0.75)
                    .clipped()
            } else if images.count == 2 {
                RowImageView(images: images, width: width)
            } else if images.count == 3 {
                RowImageView(images: images, width: width)
            } else if images.count == 4 {
                VStack(spacing: kImageSpace) {
                    RowImageView(images: Array(images[0...1]), width: width)
                    RowImageView(images: Array(images[2...3]), width: width)
                }
            } else if images.count == 5 {
                VStack(spacing: kImageSpace) {
                    RowImageView(images: Array(images[0...1]), width: width)
                    RowImageView(images: Array(images[2...4]), width: width)
                }
            } else if images.count == 6 {
                VStack(spacing: kImageSpace) {
                    RowImageView(images: Array(images[0...2]), width: width)
                    RowImageView(images: Array(images[3...5]), width: width)
                }
            }
        }
    }
}

struct RowImageView: View {
    let images: [String]
    let width: CGFloat
    
    var body: some View {
        HStack(spacing: 6) {
            ForEach(images, id: \.self) { image in
                showImage(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: (self.width - kImageSpace * CGFloat(self.images.count - 1)) / CGFloat(self.images.count),
                           height: (self.width - kImageSpace * CGFloat(self.images.count - 1)) / CGFloat(self.images.count))
                    .clipped()
            }
        }
    }
}

struct WeiboMultiImageView_Previews: PreviewProvider {
    static var previews: some View {
        let userData: UserData = UserData()
        let images = userData.weiboRecommendList.list[0].images
        let width = UIScreen.main.bounds.width
        return Group {
            WeiboMultiImageView(images: Array(images[0...0]), width: width)
            WeiboMultiImageView(images: Array(images[0...1]), width: width)
            WeiboMultiImageView(images: Array(images[0...2]), width: width)
            WeiboMultiImageView(images: Array(images[0...3]), width: width)
            WeiboMultiImageView(images: Array(images[0...4]), width: width)
            WeiboMultiImageView(images: Array(images[0...5]), width: width).environmentObject(userData)
        }
    }
}
