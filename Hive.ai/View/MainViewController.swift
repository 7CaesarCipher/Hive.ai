//
//  MainViewController.swift
//  Hive.ai
//
//  Created by shashank Mishra on 02/01/24.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           
           // Configure the cell
           cell.textLabel?.text = "Row \(indexPath.row + 1)"
           
           return cell
    }
    
    // Other properties and methods
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up the table view
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // Add the table view to the view hierarchy
        view.addSubview(tableView)
        
        // Layout the table view using constraints (you may need to adjust the constraints based on your layout requirements)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Add a header view to the table view
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        headerView.backgroundColor = .lightGray
        
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = "Results"
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        tableView.tableHeaderView = headerView
    }
    
    // Implement UITableViewDataSource and UITableViewDelegate methods as needed
}
