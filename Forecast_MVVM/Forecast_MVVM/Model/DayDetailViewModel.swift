//
//  DayDetailViewModel.swift
//  Forecast_MVVM
//
//  Created by Jacob Perez on 10/18/22.
//

import Foundation

protocol DayDetailViewModelDelegate: AnyObject {
    func updateViews()
}

class DayDetailViewModel {
    
    var forecastData: TopLevelDictionary?
    var days: [Day] {
        forecastData?.days ?? []
    }
    weak var delegate: DayDetailViewModelDelegate?
    
    private let networkingController: NetworkingController
    // Dependency Injection from view model to this view controller becasue this view should not exist without its view model. The act of injection the dependency into the INITILIZATION of this object.
    init(delegate: DayDetailViewModelDelegate, networkingController: NetworkingController = NetworkingController()) {
        self.delegate = delegate
        self.networkingController = networkingController
        fetchForecastData()
    }
    private func fetchForecastData() {
        networkingController.fetchDays { result in
            switch result {
            case .failure(let error):
                print(error.errorDescription)
            case .success(let tld):
                self.forecastData = tld
                self.delegate?.updateViews()
             
            }
        }
    }
}
