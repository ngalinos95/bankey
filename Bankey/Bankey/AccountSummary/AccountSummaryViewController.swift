//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit

protocol AccountSummaryViewProtocol: AnyObject {
    func getAccounts(accounts: [AccountSummaryModel])
    func showLoader()
    func hideLoader()
}

class AccountSummaryViewController: UIViewController {
    var accounts: [AccountSummaryModel] = []
    let presenter: AccountSummaryPresenterProtocol

    init(presenter: AccountSummaryPresenterProtocol = AccountSummaryPresenter()){

        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attach(self)
        Task {
          await presenter.fetchAccountSummaryModels()
        }
        setup()
        layout()
    }
// MARK: - Views
    // Table View
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // Logout Button
    lazy var logoutButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Logout",
                                     style: .plain,
                                     target: self,
                                     action: #selector(logoutTapped))
        button.tintColor = .label
        return button
    }()
    // Loader
    lazy var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
}
// MARK: - Setup
extension AccountSummaryViewController {

    private func layout() {
        navigationItem.rightBarButtonItem = logoutButton
    }

    private func setup() {
        setupTableView()
        setupHeaderView()
        setupFooterView()
        setupLoader()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = appColor
        // Register the cell
        tableView.register(AccountSummaryCell.self,
                           forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight

        //Add the tableView to viewController
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    private func setupHeaderView() {
        let headerView = AccountSummaryHeaderView()

        var size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        headerView.frame.size = size

        tableView.tableHeaderView = headerView
    }

    // We want the footer to be empty and not shown
    private func setupFooterView() {
        tableView.tableFooterView = UIView()
        tableView.tableFooterView?.isHidden = true
    }

    private func setupLoader() {
        view.addSubview(loader)
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
// MARK: - Delegates Conformation

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountSummaryCell.reuseID,
            for: indexPath
        ) as? AccountSummaryCell else {
            return UITableViewCell()
        }
        cell.configure(uiModel: accounts[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}

extension AccountSummaryViewController: AccountSummaryViewProtocol {
    func showLoader() {
        loader.startAnimating()
    }
    
    func hideLoader() {
        loader.stopAnimating()
        loader.hidesWhenStopped = true
    }
    
    func getAccounts(accounts: [AccountSummaryModel]) {
        self.accounts = accounts
        self.tableView.reloadData()
    }
}

// MARK: - Actions
extension AccountSummaryViewController {
    @objc func logoutTapped() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

