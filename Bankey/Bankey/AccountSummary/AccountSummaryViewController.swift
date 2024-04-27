//
//  AccountSummaryViewController.swift
//  Bankey
//
//  Created by Nikos Galinos on 27/4/24.
//

import Foundation
import UIKit

class AccountSummaryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupHeaderView()
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
        setupFooterView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        // Register the cell
        tableView.register(AccountSummaryCell.self,
                           forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight


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

    // we want the footer to be empty and not shown
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
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

    }
}
