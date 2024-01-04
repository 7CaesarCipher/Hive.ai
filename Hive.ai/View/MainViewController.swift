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
    private var searchTask: DispatchWorkItem?
       
       
    override func viewDidLoad() {
        super.viewDidLoad()
        searchScreenIntialization()
        serviceRequestForGetSpecificCurrencyDetail()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let task = DispatchWorkItem { [weak self] in
            self?.searchWikipedia(query: searchText)
        }
        
        searchTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: task)
       
      }
      
    func searchWikipedia(query: String) {
        let urlString = "https://en.wikipedia.org/w/api.php?format=json&action=query&generator=search&gsrnamespace=0&gsrsearch=\(query)&gsrlimit=10&prop=pageimages|extracts&pilimit=max&exintro&explaintext&exsentences=1&exlimit=max"
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                return
            }
            guard let data = data else {
                print("No data received")
                return
            }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(WikipediaResponse.self, from: data)
                self?.wikipediaResponse = result
                DispatchQueue.main.async {
                    self?.productTable.reloadData()
                }
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
            }
        }.resume()
    }

  
    fileprivate func searchScreenIntialization() {
        self.productTable.register(UINib(nibName: "wikipediaTableViewCell", bundle: nil), forCellReuseIdentifier: "wikipediaTableViewCell")
        productTable.delegate = self
        productTable.dataSource = self
        productSearch.backgroundColor = UIColor.gray
        productSearch.delegate = self
        productTable.reloadData()
        productSearch.resignFirstResponder()
        productSearch.searchTextField.backgroundColor = UIColor.white
        productSearch.backgroundImage = UIImage()
        productSearch.layer.cornerRadius = 5
        productSearch.clipsToBounds = true

        
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
            let sortedKeys = pages.keys.sorted(by: { (key1, key2) -> Bool in
                return pages[key1]?.title ?? "" < pages[key2]?.title ?? ""
            })
            
            let pageID = sortedKeys[indexPath.row]
            if let page = pages[pageID] {
                cell.productTitle.text = page.title
                cell.productSubtitle.text = page.extract
                cell.productImage.loadImageUsingUrlString(urlString: page.thumbnail?.source ?? "")
            }
        }
                cell.selectionStyle = UITableViewCell.SelectionStyle.none

        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .darkGray
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: headerView.bounds.width - 50, height: headerView.bounds.height))
        headerLabel.text = "Results"
        headerLabel.textAlignment = .center
        headerLabel.textColor = .white
        headerView.addSubview(headerLabel)
        
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPathsForVisibleRows = productTable.indexPathsForVisibleRows,
           let firstIndexPath = indexPathsForVisibleRows.first,
           firstIndexPath.section > 0 {
            let sectionRect = productTable.rect(forSection: firstIndexPath.section)
            let offsetY = scrollView.contentOffset.y + productTable.contentInset.top
            if offsetY >= sectionRect.origin.y {
                productTable.contentOffset.y = sectionRect.origin.y - productTable.contentInset.top
            }
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let titleLabelHeight: CGFloat = 20
        let subtitleLabelHeight: CGFloat = 40
        let verticalSpacing: CGFloat = 16
        
        let contentHeight = titleLabelHeight + subtitleLabelHeight + verticalSpacing * 2
        
        return contentHeight + 16
    }

    }
    

