//
//  ViewController.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 08/06/21.
//

import UIKit

class StatementsViewController: UIViewController {
    //MARK: - Outlets, Variables & Init
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var balanceValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let tableCellName = "TableViewCell"
    let tableCellIdentifier = "opCell"
    
    var presenter : StatementsPresenter
    
    init(presenter: StatementsPresenter){
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setClientInfoLabels()
        presenter.requestStatements()
        setUpTableView()
    }
    //MARK: - UIActions
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        presenter.requestStatements()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        presenter.logOut()
    }
    //MARK: - Methods
    
    func setClientInfoLabels() {
        let viewData = presenter.clientInfoViewData
        
        nameLabel.text = viewData.name
        accountNumberLabel.text = viewData.accNumber
        balanceValueLabel.text = viewData.balanceValue
    }
    
    func setUpTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: tableCellName, bundle: nil),
            forCellReuseIdentifier: tableCellIdentifier)
    }
}
//MARK: - TableViewDataSource

extension StatementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let statementsViewData = presenter.statementsViewData
        return statementsViewData.package.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCell
        let statementsViewData = presenter.statementsViewData
        let content = statementsViewData.package[indexPath.row]
        
        cell.operationTypeLabel.text = content.type
        cell.operationLabel.text = content.detail
        cell.valueDateLabel.text = content.date
        cell.valueLabel.text = content.value
        return cell
    }
}

extension StatementsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
}

extension StatementsViewController: StatementsPresenterOutput {
    func displayconnectionError(e: String) {
        let alert = UIAlertController(title: "Error:", message: e, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
}
