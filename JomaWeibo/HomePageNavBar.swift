//
//  HomePageNavBar.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/31.
//

import SwiftUI

private let kLabelWidth: CGFloat = 60
private let kLabelHeight: CGFloat = 24
private let kBarWidth: CGFloat = UIScreen.main.bounds.width * 0.5

struct HomePageNavBar: View {
    // 0下划线在左边，1下划线在右边 [状态改变，整个ui就会刷新]
    @Binding var leftPercent: CGFloat
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // 相机的按钮
            Button(action: {print("点击了相机")}) {
                Image(systemName: "camera")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kLabelHeight, height: kLabelHeight)
                    .foregroundColor(.black)
                    .padding(.top, 5)
                    .padding(.horizontal, 15)
            }
            Spacer()
            VStack(spacing: 3) {
                // 推荐和热门
                HStack(spacing: 0) {
                    Text("推荐")
                        .bold()
                        .frame(width: kLabelWidth, height: kLabelHeight)
                        .padding(.top, 5)
                        .opacity(Double(1 - leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 0
                            }
                        }
                    Spacer()
                    Text("热门")
                        .bold()
                        .frame(width: kLabelWidth, height: kLabelHeight)
                        .padding(.top, 5)
                        .opacity(Double(0.5 + leftPercent * 0.5))
                        .onTapGesture {
                            withAnimation {
                                self.leftPercent = 1
                            }
                        }
                }
                .font(.system(size: 20))
                
                // 下划线
                RoundedRectangle(cornerRadius: 2)
                    .foregroundColor(.orange)
                    .frame(width: 30, height: 4)
                    .offset(x: kBarWidth * (self.leftPercent - 0.5) + kLabelWidth * (0.5 - self.leftPercent))
            }
            .frame(width: kBarWidth)
            
            Spacer()
            // 相机的按钮
            Button(action: {print("点击了+")}) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: kLabelHeight, height: kLabelHeight)
                    .foregroundColor(.orange)
                    .padding(.top, 5)
                    .padding(.horizontal, 15)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
    }
}

struct HomePageNavBar_Previews: PreviewProvider {
    static var previews: some View {
        HomePageNavBar(leftPercent: .constant(0))
    }
}
