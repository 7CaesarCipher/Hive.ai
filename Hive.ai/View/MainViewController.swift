//
//  MainViewController.swift
//  Hive.ai
//
//  Created by shashank Mishra on 02/01/24.
//

import UIKit

class MainViewController: UIViewController,UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate{
    
    
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var productSearch: UISearchBar!
    var wikipediaResponse :WikipediaResponse?
    override func viewDidLoad() {
        super.viewDidLoad()
        searchScreenIntialization()
        
        serviceRequestForGetSpecificCurrencyDetail()
        
        // Add a header view to the table view
        
        
    }
    fileprivate func searchScreenIntialization() {
        self.productTable.register(UINib(nibName: "wikipediaTableViewCell", bundle: nil), forCellReuseIdentifier: "wikipediaTableViewCell")
        productTable.delegate = self
        productTable.dataSource = self
        //        searchBar.backgroundColor = UIColor(named: "HedgexSearchBarColor")
        productSearch.delegate = self
        productTable.reloadData()
        productSearch.resignFirstResponder()
        
        
    }
    
    fileprivate func serviceRequestForGetSpecificCurrencyDetail() {
        getWikipediatDetail { [weak self] (response) in
            if let response = response {
                self?.wikipediaResponse = response
                DispatchQueue.main.async {
                    
                    self?.productTable.reloadData()
                }
            } else {
                // Handle error or nil response
                print("Error: Unable to fetch Wikipedia response")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return wikipediaResponse?.query.pages.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wikipediaTableViewCell", for: indexPath) as! wikipediaTableViewCell
        
        if let pages = wikipediaResponse?.query.pages {
            // Get the keys (page IDs) sorted by their values (titles)
            let sortedKeys = pages.keys.sorted(by: { (key1, key2) -> Bool in
                return pages[key1]?.title ?? "" < pages[key2]?.title ?? ""
            })
            
            // Use the sorted keys to access the pages in the correct order
            let pageID = sortedKeys[indexPath.row]
            if let page = pages[pageID] {
                cell.productTitle.text = page.title
                cell.productSubtitle.text = page.extract
                cell.productImage.loadImageUsingUrlString(urlString: page.thumbnail?.source ?? "")
            }
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.backgroundColor = .darkGray
        
        let headerLabel = UILabel(frame: headerView.bounds)
        headerLabel.text = "Results"
        headerLabel.textAlignment = .center
        headerLabel.textColor = .white // Optionally set text color
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            let titleLabelHeight: CGFloat = 20
            let subtitleLabelHeight: CGFloat = 40
            let verticalSpacing: CGFloat = 16
            
            let contentHeight = titleLabelHeight + subtitleLabelHeight + verticalSpacing * 2
            
            return contentHeight + 16
        }
        
    }
    
    
    
    
    
    
    
}
