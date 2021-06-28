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
    
    var viewModel : StatementsViewModel
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.frame = UIScreen.main.bounds
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = UIColor.warmBlue
        
        return activityIndicator
    }()
    
    init(viewModel: StatementsViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupBindings()
        
        viewModel.fetchStatements()
    }
    //MARK: - UIActions
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        viewModel.fetchStatements()
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        viewModel.logOut()
    }
    //MARK: - Methods
    
    func setupUI() {
        let clientViewData = viewModel.clientInfoViewData

        nameLabel.text = clientViewData.name
        accountNumberLabel.text = clientViewData.accNumber
        balanceValueLabel.text = clientViewData.balanceValue
        
        view.addSubview(activityIndicator)
    }
    
    func setupTableView () {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(
            UINib(nibName: tableCellName, bundle: nil),
            forCellReuseIdentifier: tableCellIdentifier)
    }
    
    func setupBindings() {
        viewModel.didStartActivity = { [weak self] in
            self?.activityIndicator.startAnimating()
        }
        
        viewModel.didEndActivity = { [weak self] in
            self?.activityIndicator.stopAnimating()
        }
        
        viewModel.didLoadedStatements = { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
//MARK: - TableViewDataSource

extension StatementsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.statementsViewData.package.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCellIdentifier, for: indexPath) as! TableViewCell
        let statementsViewData = viewModel.statementsViewData
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
