//
//  ItemBottomBar.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct ItemBottomButton: View {
    let imageName: String
    let text: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(
            action: action,
            label: {
                HStack(spacing: 5) {
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 18, height: 18)
                    Text(text)
                        .font(.system(size: 16))
                }.foregroundColor(color)
            })
            .buttonStyle(BorderlessButtonStyle())
    }
}

struct ItemBottomBar_Previews: PreviewProvider {
    static var previews: some View {
        ItemBottomButton(imageName: "heart", text: "点赞", color: .red) {
            print("click 点赞按钮")
        }
    }
}
