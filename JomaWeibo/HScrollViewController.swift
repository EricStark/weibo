//
//  HScrollViewController.swift
//  JomaWeibo
//
//  Created by Joma on 2022/7/31.
//

import SwiftUI

// a view that represents a UIKit view controller.
struct HScrollViewController<Content: View>: UIViewControllerRepresentable {
    let pageWidth: CGFloat
    let contentSize: CGSize
    let content: Content
    @Binding var leftPercent: CGFloat
    
    init(pageWidth: CGFloat, leftPercent: Binding<CGFloat>, contentSize: CGSize, @ViewBuilder content: () -> Content) {
        self.pageWidth = pageWidth
        self._leftPercent = leftPercent// _表示和哪一个属性绑定
        self.contentSize = contentSize
        self.content = content()
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = context.coordinator
        
        context.coordinator.scrollView = scrollView// set value
        
        let hostController = UIHostingController(rootView: content)
        
        context.coordinator.hostController = hostController// set value
        
        let viewController = UIViewController()
        viewController.view.addSubview(scrollView)
        viewController.addChild(hostController)
        scrollView.addSubview(hostController.view)
        hostController.didMove(toParent: viewController)// 告诉hostController已经被添加到viewController当中了
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        let scrollView = context.coordinator.scrollView!
        scrollView.frame = CGRect(x: 0, y: 0, width: pageWidth, height: contentSize.height)
        scrollView.contentSize = contentSize
        scrollView.setContentOffset(CGPoint(x: leftPercent * (contentSize.width - pageWidth), y: 0), animated: true)
        context.coordinator.hostController.view.frame = CGRect(origin: .zero, size: contentSize)
    }
    
    class Coordinator: NSObject, UIScrollViewDelegate {
        let parent: HScrollViewController
        var scrollView: UIScrollView!
        var hostController: UIHostingController<Content>!
        
        init(_ parent: HScrollViewController) {
            self.parent = parent
        }
        
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            withAnimation {
                parent.leftPercent = scrollView.contentOffset.x < parent.pageWidth * 0.5 ? 0 : 1
            }
        }
    }
}
