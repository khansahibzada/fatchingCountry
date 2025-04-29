//
//  CountriesViewModel.swift
//  fatchingCountry
//
//  Created by sahibzada khan on 4/29/25.
//

import Foundation

class CountriesViewModel {

    private let service = CountryService()
    private var allCountries: [Country] = []

    var filteredCountries: [Country] = []
    var getUpdatedData: (() -> Void)?

    func fetchCountries() {
        service.fetchCountries { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let countries):
                    self?.allCountries = countries
                    self?.filteredCountries = countries
                    self?.getUpdatedData?()
                case .failure(let error):
                    print("Error fetching countries: \(error)")
                }
            }
        }
    }

    func filterCountries(with text: String) {
        if text.isEmpty {
            filteredCountries = allCountries
        } else {
            let search = text.lowercased()
            filteredCountries = allCountries.filter {
                $0.name.lowercased().contains(search) || $0.capital.lowercased().contains(search)
            }
        }
        getUpdatedData?()
    }
}
