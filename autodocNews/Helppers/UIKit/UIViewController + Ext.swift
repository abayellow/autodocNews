//
//  UIViewController + Ext.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import UIKit

extension UIViewController {
    func configureNavigation(title: String) {
        self.title = title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        view.backgroundColor = .systemBackground
    }
    
    func openWeb(_ url: URL) {
        let webVC = WebViewController(url: url)
        if UIDevice.current.userInterfaceIdiom == .pad {
            let nav = UINavigationController(rootViewController: webVC)
            nav.modalPresentationStyle = .pageSheet
            present(nav, animated: true)
        } else {
            navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
