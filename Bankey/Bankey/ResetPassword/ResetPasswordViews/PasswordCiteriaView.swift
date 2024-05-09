//
//  PasswordCiteriaView.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit

class PasswordCiteriaView: UIView {
    let criteriaText: String
    // The defaults images of this view
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
    // Keep the status on the view
    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                statusImage.image = checkmarkImage
            } else {
                statusImage.image = xmarkImage
            }
        }
    }

    func reset() {
        isCriteriaMet = false
        statusImage.image = circleImage
    }

    init(criteriaText: String) {
        self.criteriaText = criteriaText
        super.init(frame: .zero)
        setup()
        layout()
        reset()
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 40)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: Views
    // Label
    lazy var criteriaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = criteriaText
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    // Image
    lazy var statusImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = circleImage
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
}

extension PasswordCiteriaView{
    func setup() {
        self.backgroundColor = .clear
    }

    func layout() {
        // Status Image
        self.addSubview(statusImage)
        NSLayoutConstraint.activate([
            statusImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            statusImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            statusImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
            statusImage.widthAnchor.constraint(equalTo: statusImage.heightAnchor)
        ])
        // Label
        self.addSubview(criteriaLabel)
        NSLayoutConstraint.activate([
            criteriaLabel.leadingAnchor.constraint(equalTo: statusImage.trailingAnchor, constant: 8),
            criteriaLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
            criteriaLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            criteriaLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8)
        ])

        func reset() {
            statusImage.image = circleImage
        }
    }
}
