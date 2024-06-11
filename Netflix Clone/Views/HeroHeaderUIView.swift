//
//  HeroHeaderUIView.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-10.
//

import UIKit

class HeroHeaderUIView: UIView {
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let playbutton: UIButton = {
        
        let button = UIButton()
        
        button.setTitle("Play", for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        
        return button
    }()
    
    private let heroImageView: UIImageView =  {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "InsideOut")
        
        return imageView
    }()
    
    
    private func addGradient() {
        //to make the fade out
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            // add a transparent layer
            UIColor.clear.cgColor,
            //then add the dark mode color layer
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        addGradient()
        addSubview(playbutton)
        addSubview(downloadButton)
        applyConstraints()
    }
    
    private func applyConstraints() {
        let playButtonConstraints = [
            playbutton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            playbutton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playbutton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let downloadConstraints = [
            downloadButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
            downloadButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            downloadButton.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        NSLayoutConstraint.activate(playButtonConstraints)
        NSLayoutConstraint.activate(downloadConstraints)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
