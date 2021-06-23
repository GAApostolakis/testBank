//
//  ViewController.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 08/06/21.
//

import UIKit

class StatementsViewController: UIViewController {
    //MARK: - Outlets & Variables
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var statementsPresenter = StatementsPresenter()
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        statementsPresenter.statementVC = self
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: statementsPresenter.tableCellName, bundle: nil),
            forCellReuseIdentifier: statementsPresenter.tableCellName)
        
        statementsPresenter.setClientLabels()
        statementsPresenter.requestOperations()
    }
    
    @IBAction func refreshPushed(_ sender: UIButton) {
        statementsPresenter.requestOperations()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        statementsPresenter.logOut()
    }
}

//MARK: - TableView Data Source

extension StatementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statementsPresenter.operations?.statement.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: statementsPresenter.tableCellName, for: indexPath) as! TableViewCell
        let content = statementsPresenter.operations?.statement[indexPath.row]
        cell.operationTypeLabel.text = content?.type
        cell.operationLabel.text = content?.detail
        cell.valueDateLabel.text = content?.date
        cell.valueLabel.text = String(format: "R$ %.2f", content?.value ?? 0)
        return cell
    }
}

extension StatementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
}
