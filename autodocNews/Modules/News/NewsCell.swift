//
//  NewsCell.swift
//  autodocNews
//
//  Created by Alexander Abanshin on 27.10.2025.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let blurView = UIVisualEffectView()
    private let shimmerView = ShimmerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContentView()
        setupImageView()
        setupBlurView()
        setupTitleLabel()
        setupConstraints()
        shimmerView.startAnimating()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    func configure(item: News) {
        if let url = item.titleImageUrl {
            
            imageView.setImage(from: url) { [weak self] image in
                guard let self else { return }
                
                UIView.transition(with: self.contentView, duration: 0.3, options: .transitionCrossDissolve) {
                    self.shimmerView.stopAnimating()
                    self.shimmerView.isHidden = true
                    self.titleLabel.text = item.title
                }
            }
        } else {
            imageView.image = UIImage(named: "autodoc")
            shimmerView.stopAnimating()
            shimmerView.isHidden = true
            titleLabel.text = item.title
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.cancelImageLoad()
        shimmerView.isHidden = false
        shimmerView.startAnimating()
    }
}

private extension NewsCell {
    func setupContentView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 0.1
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 8
        
    }
    
    func setupImageView() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
    }
    
    func setupBlurView() {
        blurView.effect = UIBlurEffect(style: .systemMaterialDark)
        blurView.alpha = 0.7
    }
    
    func setupTitleLabel() {
        titleLabel.font =  UIFont.preferredFont(forTextStyle: .headline)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.adjustsFontForContentSizeCategory = true
    }
    
    func setupConstraints() {
        [imageView, blurView, shimmerView, titleLabel, shimmerView].forEach { contentView.addView($0) }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            shimmerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            shimmerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            shimmerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            shimmerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            blurView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            
            titleLabel.centerXAnchor.constraint(equalTo: blurView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: blurView.centerYAnchor, constant: 2),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -14)
        ])
    }
}
