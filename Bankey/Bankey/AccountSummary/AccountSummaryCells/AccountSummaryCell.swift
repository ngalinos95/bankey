//
//  AccountSummaryCell.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit

class AccountSummaryCell: UITableViewCell {
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 114

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
// MARK: - Views
    // Type Label
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Account Type"
        label.font = .preferredFont(forTextStyle: .caption1)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // Divider
    lazy var divider: UIView = {
        let divider = UIView()
        divider.backgroundColor = appColor
        divider.translatesAutoresizingMaskIntoConstraints = false
        return divider
    }()
    // Name Label
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Fee All-In Chequing"
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // Balance Container
    lazy var balanceContainer: UIView = {
        let balanceContainer = UIView()
        balanceContainer.translatesAutoresizingMaskIntoConstraints = false
        return balanceContainer
    }()
    // Stack View
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.spacing = 4
        return stackView
    }()
    // Balance label
    lazy var balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some Balance"
        label.font = .preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    // Balance Ammount
    lazy var balanceAmmount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.attributedText = makeFormattedBalance(dollars: "929,466", cents: "23")
//        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()
    // Chevron Image
    lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let chevronImage = UIImage(
            systemName: "chevron.right")!.withTintColor(appColor,
                                                        renderingMode: .alwaysOriginal
            )
        imageView.image = chevronImage
        return imageView
    }()
}

extension AccountSummaryCell {

    private func setup() {

    }

    private func layout() {
        // Type Label
        contentView.addSubview(typeLabel)
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            typeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        // Divider
        contentView.addSubview(divider)
        NSLayoutConstraint.activate([
            divider.heightAnchor.constraint(equalToConstant: 4),
            divider.widthAnchor.constraint(equalToConstant: 60),
            divider.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 8),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        // Name Label
        contentView.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: divider.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
        // Balance Container
        contentView.addSubview(balanceContainer)
        NSLayoutConstraint.activate([
            balanceContainer.topAnchor.constraint(equalTo: typeLabel.topAnchor),
            balanceContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        // Stack View
        balanceContainer.addSubview(stackView)
        NSLayoutConstraint.activate([
//            stackView.topAnchor.constraint(equalTo: balanceContainer.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: balanceContainer.leadingAnchor, constant: 4),
            stackView.trailingAnchor.constraint(equalTo: balanceContainer.trailingAnchor, constant: -32)

        ])
        // Chevron Image
        balanceContainer.addSubview(chevronImageView)
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(equalTo: balanceContainer.topAnchor, constant: 16),
            chevronImageView.trailingAnchor.constraint(equalTo: balanceContainer.trailingAnchor, constant: -8)

        ])
        // Balance label + Amount
        stackView.addArrangedSubview(balanceLabel)
        stackView.addArrangedSubview(balanceAmmount)
        NSLayoutConstraint.activate([
            balanceLabel.topAnchor.constraint(equalTo: stackView.topAnchor)
        ])
    }

}

extension AccountSummaryCell {
    private func makeFormattedBalance(dollars: String, cents: String) -> NSMutableAttributedString {
        let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 4]
        let dollarAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title2)]
        let centAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 4]

        let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
        let dollarString = NSAttributedString(string: dollars, attributes: dollarAttributes)
        let centString = NSAttributedString(string: cents, attributes: centAttributes)

        rootString.append(dollarString)
        rootString.append(centString)

        return rootString
    }
}
