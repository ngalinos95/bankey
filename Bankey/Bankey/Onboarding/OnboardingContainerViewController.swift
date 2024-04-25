//
//  OnboardingContainerViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 25/4/24.
//

import Foundation
import UIKit

protocol OnboardingContainerProtocol: AnyObject {

}

class OnboardingContainerViewController: UIViewController {

    var pages = [UIViewController]()
    weak var currentVC: UIViewController? {
        didSet {
        }
    }

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

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
}

extension OnboardingContainerViewController {
    func setup() {
        view.backgroundColor = .systemPurple
        // Add child view controller to the parent view controller (Step 1)
        addChild(pageViewController)
        // Add child view controller to the parent view controller (Step 2)
        view.addSubview(pageViewController.view)
        // Add child view controller to the parent view controller (Step 3)
        pageViewController.didMove(toParent: self)

        let page1 = ViewController1()
        let page2 = ViewController2()
        let page3 = ViewController3()

        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        currentVC = pages.first
    }

    func layout() {


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

// MARK: - ViewControllers
class ViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemRed
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGreen
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
    }
}
