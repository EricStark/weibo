//
//  VIPWidget.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/30.
//

import SwiftUI

struct VIPWidget: View {
    let isVip: Bool
    
    var body: some View {
        Group {
            if isVip {
                Text("V")
                    .bold()
                    .font(.system(size: 11))
                    .frame(width: 15, height: 15)
                    .foregroundColor(.yellow)
                    .background(Color.red)
                    .clipShape(Circle())
                    .overlay(
                        RoundedRectangle(cornerRadius: 7.5)
                            .stroke(Color.white,lineWidth: 1)
                    )
            }
        }
    }
}

struct VIPWidget_Previews: PreviewProvider {
    static var previews: some View {
        VIPWidget(isVip: true)
    }
}
