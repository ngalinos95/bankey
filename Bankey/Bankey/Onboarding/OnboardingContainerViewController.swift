//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 25/4/24.
//

import Foundation
import UIKit


protocol OnboardingRootProtocol: AnyObject {
    func didSkipOnboarding()
    func didCloseOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    weak var rootDelegate: OnboardingRootProtocol?
    var pages = [UIViewController]()
    weak var currentVC: UIViewController?

     init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll,
                                                      navigationOrientation: .horizontal)
        return pageViewController
    }()

    lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Close", for: [])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self,
                              action: #selector(closeTapped),
                              for: .primaryActionTriggered)
        return button

    }()

    lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Skip", for: [])
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self,
                              action: #selector(skipTapped),
                              for: .primaryActionTriggered)
        return button

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setup()
        layout()
    }
}

extension OnboardingContainerViewController {
    private func setup() {
        view.backgroundColor = .systemBlue
        // Add child view controller to the parent view controller (Step 1)
        addChild(pageViewController)
        // Add child view controller to the parent view controller (Step 2)
        view.addSubview(pageViewController.view)
        // Add child view controller to the parent view controller (Step 3)
        pageViewController.didMove(toParent: self)
        let label = "This screen simulates an onboarding screen"
        let labe2 = "With a close button to return on the Login Page"
        let labe3 = "And a Skip button to continue on the main app journey"
        let page1 = OnboardingViewController(imageName: "delorean", textLabel: label)
        let page2 = OnboardingViewController(imageName: "thumbs", textLabel: labe2)
        let page3 = OnboardingViewController(imageName: "world", textLabel: labe3)
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentVC = pages.first
    }

    private func layout() {

        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: pageViewController.view.topAnchor),
            view.leadingAnchor.constraint(equalTo: pageViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: pageViewController.view.trailingAnchor),
            view.bottomAnchor.constraint(equalTo: pageViewController.view.bottomAnchor),
        ])
        guard let firstPage = pages.first else { return }
        pageViewController.setViewControllers([firstPage],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        currentVC = pages.first
        // Add Close Button
        view.keyboardLayoutGuide.usesBottomSafeArea = false
        view.addSubview(closeButton)
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            closeButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 8)
        ])
        // Add Skip Button
        view.addSubview(skipButton)
        NSLayoutConstraint.activate([
            skipButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -28),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -8)
        ])
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return getPreviousViewController(from: viewController)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return getNextViewController(from: viewController)
    }

    private func getPreviousViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index - 1 >= 0 else { return nil }
        currentVC = pages[index - 1]
        return pages[index - 1]
    }

    private func getNextViewController(from viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController), index + 1 < pages.count else { return nil }
        currentVC = pages[index + 1]
        return pages[index + 1]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let currentVC = self.currentVC else { return 0 }
        return pages.firstIndex(of: currentVC ) ?? 0
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
    @objc func closeTapped(_ sender: UIButton) {
        self.rootDelegate?.didCloseOnboarding()
    }

    @objc func skipTapped(_ sender: UIButton) {
        self.rootDelegate?.didSkipOnboarding()
    }
}
