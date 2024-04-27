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
        presenter.fetchAccountSummaryModels()
        setup()
    }
// MARK: - Views
    lazy var tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
}

extension AccountSummaryViewController {

    private func setup() {
        setupTableView()
        setupHeaderView()
        setupFooterView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
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
        let headerView = AccountSummaryHeaderView(frame: .zero)

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
}

extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AccountSummaryCell.reuseID,
                                                       for: indexPath) as? AccountSummaryCell else {
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
    func getAccounts(accounts: [AccountSummaryModel]) {
        self.accounts = accounts
        self.tableView.reloadData()
    }
}

