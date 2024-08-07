//
//  ChoiceCollectionViewCell.swift
//  SelectionChoice
//
//  Created by Space Wizard on 8/6/24.
//

import Foundation
import UIKit

class ChoiceCollectionViewCell: UICollectionViewCell {
    
    enum Constants {
        static let titleLabelInset: CGFloat = 18
    }
    
    static var identifier: String {
        String(describing: ChoiceCollectionViewCell.self)
    }
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        view.layer.cornerRadius = 18
        return view
    }()
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Hello"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func onHandleSelectionChoice(didSelect: Bool) {
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.containerView.backgroundColor = didSelect ? .green : .red
        }
    }
}

extension ChoiceCollectionViewCell {
    
    func setup() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: Constants.titleLabelInset),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -Constants.titleLabelInset),
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: Constants.titleLabelInset),
            titleLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -Constants.titleLabelInset)
        ])
    }
}
