//
//  PasswordStatusView.swift
//  Bankey
//
//  Created by Nikos Galinos on 8/5/24.
//

import Foundation
import UIKit

class PasswordStatusView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 200)
    }
// MARK: - Views
    // StackView
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    // Description Label
    lazy var descriptionLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Use at least 3 of these 4 criteria when setting your password"
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    //  Criterias
    let firstCriteriaLabel = PasswordCiteriaView(criteriaText: "8-32 characters (no spaces)")
    let secondCriteriaLabel = PasswordCiteriaView(criteriaText: "Uppercase letter (A-Z)")
    let thirdCriteriaLabel = PasswordCiteriaView(criteriaText: "Lowercase letter (a-z)")
    let forthCriteriaLabel = PasswordCiteriaView(criteriaText: "Digit (0-9)")
    let fifthCriteriaLabel = PasswordCiteriaView(criteriaText: "Special Character (e.g. !@#$%^)")
}
// MARK: - Setup
extension PasswordStatusView {

    func setup() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }

    func layout() {
        self.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8),
        ])

        stackView.addArrangedSubview(firstCriteriaLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(secondCriteriaLabel)
        stackView.addArrangedSubview(thirdCriteriaLabel)
        stackView.addArrangedSubview(forthCriteriaLabel)
        stackView.addArrangedSubview(fifthCriteriaLabel)
    }
    func reset() {
        firstCriteriaLabel.reset()
        secondCriteriaLabel.reset()
        thirdCriteriaLabel.reset()
        forthCriteriaLabel.reset()
        fifthCriteriaLabel.reset()
    }

}

