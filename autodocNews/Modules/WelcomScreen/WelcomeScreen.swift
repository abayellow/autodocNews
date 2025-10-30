//
//  WelcomeScreen.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 29.10.2025.
//

import UIKit

final class WelcomeViewController: UIViewController {
    private let logoImageView =  UIImageView()
    private let titleLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setuplogoImageView()
        setupTitleLabel()
        setupViews()
        animateLogo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.goToMainScreen()
        }
    }
}

private extension WelcomeViewController {
    func setupViews() {
        view.addView(logoImageView)
        view.addView(titleLabel)
        
        NSLayoutConstraint.activate([
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            logoImageView.widthAnchor.constraint(equalToConstant: 120),
            logoImageView.heightAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    func setuplogoImageView() {
        logoImageView.image = UIImage(named: "StartIcon")
        logoImageView.contentMode = .scaleAspectFit
    }
    
    func setupTitleLabel() {
        titleLabel.text = "Autodoc"
        titleLabel.font = .systemFont(ofSize: 36, weight: .bold)
        titleLabel.textColor = .systemBlue
        titleLabel.textAlignment = .center
        titleLabel.alpha = 0
    }
    
    func animateLogo() {
        logoImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.curveEaseOut], animations: {
            self.logoImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
            self.titleLabel.alpha = 1.0
        })
    }
    
    func goToMainScreen() {
        let mainVC = NewsViewController()
        mainVC.modalTransitionStyle = .crossDissolve
        mainVC.modalPresentationStyle = .fullScreen
        navigationController?.setViewControllers([mainVC], animated: false)
    }
}
