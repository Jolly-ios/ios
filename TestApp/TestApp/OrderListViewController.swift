//
//  OrderListViewController.swift
//  TestApp
//
//  Created by Ahmad Rafiq on 21/09/2025.
//

import UIKit

class OrderListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalOrdersLabel: UILabel!
    
    private var orders: [Order] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        loadOrders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadOrders()
    }
    
    private func setupUI() {
        title = "Orders"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        // Add plus button to navigation bar
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOrderTapped))
        navigationItem.rightBarButtonItem = addButton
        
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "OrderCell", bundle: nil), forCellReuseIdentifier: "OrderCell")
    }
    
    private func loadOrders() {
        orders = OrderManager.shared.getAllOrders()
        updateTotalOrdersLabel()
        tableView.reloadData()
    }
    
    private func updateTotalOrdersLabel() {
        let totalCount = orders.count
        totalOrdersLabel.text = "Total Orders: \(totalCount)"
    }
    
    @objc private func addOrderTapped() {
        performSegue(withIdentifier: "showAddOrder", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAddOrder" {
            // The destination is a navigation controller, so we need to get the root view controller
            if let navController = segue.destination as? UINavigationController,
               let addOrderVC = navController.topViewController as? AddOrderViewController {
                addOrderVC.delegate = self
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension OrderListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        
        let order = orders[indexPath.row]
        cell.configureCell(model: order)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OrderListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // You can add order detail view here if needed
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            OrderManager.shared.deleteOrder(at: indexPath.row)
            loadOrders()
        }
    }
}

// MARK: - AddOrderDelegate
extension OrderListViewController: AddOrderDelegate {
    func didAddOrder(_ order: Order) {
        loadOrders()
    }
}
