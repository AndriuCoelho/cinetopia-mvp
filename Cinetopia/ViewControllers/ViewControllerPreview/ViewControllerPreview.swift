//
//  ViewControllerPreview.swift
//  Cinetopia
//
//  Created by Ândriu F Coelho on 12/11/23.
//

import SwiftUI

struct ViewControllerPreview: UIViewControllerRepresentable {
    
    // MARK: - Attributes
    
    let viewControllerBuilder: () -> UIViewController
    
    // MARK: - Initializer
    
    init(viewControllerBuilder: @escaping () -> UIViewController) {
        self.viewControllerBuilder = viewControllerBuilder
    }
    
    // MARK: - UIViewControllerRepresentableProtocol
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewControllerBuilder()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
