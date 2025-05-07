//
//  ViewController.swift
//  fatchingCountry
//
//  Created by sahibzada khan on 4/29/25.


import UIKit

class CountriesViewController: UITableViewController {
    
    private let viewModel = CountriesViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchController()
        bindViewModel()
        viewModel.fetchCountries()
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by name or capital"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func bindViewModel() {
        viewModel.getUpdatedData = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - TableView Data Source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCountries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = viewModel.filteredCountries[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell") {
            cell.textLabel?.text = "\(country.name) (\(country.code))"
            cell.detailTextLabel?.text = "Capital: \(country.capital) | Region: \(country.region)"
            cell.detailTextLabel?.numberOfLines = 2
            return cell
        } else {
            let newCell = UITableViewCell(style: .subtitle, reuseIdentifier: "CountryCell")
            newCell.textLabel?.text = "\(country.name) (\(country.code))"
            newCell.detailTextLabel?.text = "Capital: \(country.capital) | Region: \(country.region)"
            newCell.detailTextLabel?.numberOfLines = 2
            return newCell
        }
    }
    
    
}

// MARK: - UISearchResultsUpdating
extension CountriesViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterCountries(with: searchController.searchBar.text ?? "")
    }
}
