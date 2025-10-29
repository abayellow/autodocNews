//
//  WebViewController.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    private let webView = WKWebView()
    private let url: URL
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        setupActivityIndicator()
        loadURL()
    }
}

private extension WebViewController {
    func setupWebView() {
        webView.navigationDelegate = self
        view.addView(webView)
        webView.pinToEdges(of: view)
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.pinToCenter(of: view)
    }
    
    func loadURL() {
        let request = URLRequest(url: url)
        webView.load(request)
        activityIndicator.startAnimating()
    }
    
    func showErrorAlert(error: Error) {
        let alert = UIAlertController(
            title: "Ошибка загрузки",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - WKNavigationDelegate
extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlert(error: error)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
        showErrorAlert(error: error)
    }
}
