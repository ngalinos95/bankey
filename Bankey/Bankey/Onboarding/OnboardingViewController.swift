//
//  OnboardingViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 25/4/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    let imageName: String
    let textLabel: String

    init(imageName: String, textLabel: String) {
        self.imageName = imageName
        self.textLabel = textLabel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.text = textLabel
        return label
    }()

    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: imageName)
        return image
    }()
}

extension OnboardingViewController {

    func setup() {
        view.backgroundColor = .systemPurple
    }

    func layout() {
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.trailingAnchor.constraint(
                greaterThanOrEqualToSystemSpacingAfter: view.trailingAnchor, multiplier: 3
            ),
            stackView.leadingAnchor.constraint(
                greaterThanOrEqualToSystemSpacingAfter: view.leadingAnchor, multiplier: 3
            )
        ])
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(label)


    }
}
