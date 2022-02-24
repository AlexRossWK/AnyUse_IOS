//
//  BannerView.swift
//  AlertManager
//
//  Created by Alexey Rossoshansky on 09.10.2020.
//

import UIKit

class BannerView: UIView {
    private struct Constants {
        static let horizontalLabelMargin: CGFloat = 16
        static let verticalLabelMargin: CGFloat = 12
    }
    
    typealias Action = () -> Void
    var action: Action?
    
    struct Model {
        let body: NSAttributedString
        let color: UIColor
    }
    
    let model: Model
    
    private let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textColor = UIColor.white
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    init(_ model: Model) {
        self.model = model
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        layer.cornerRadius = 13
        backgroundColor = model.color
        
        layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.25)
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 6
        layer.shadowOpacity = 1
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        addSubview(bodyLabel)
        NSLayoutConstraint.activate([
          bodyLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: Constants.horizontalLabelMargin),
          bodyLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -Constants.horizontalLabelMargin),
          bodyLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalLabelMargin),
          bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalLabelMargin)
        ])
        
        bodyLabel.attributedText = model.body
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
    }
    
    @objc func tapAction() {
        action?()
    }
}
