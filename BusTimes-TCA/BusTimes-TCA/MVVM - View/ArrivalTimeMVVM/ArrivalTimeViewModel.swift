//
//  ArrivalTimeViewModel.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 12/02/2023.
//

import SwiftUI
import Combine

class ArrivalTimeViewModel: ObservableObject {
    
    @Published var arrivalTime: [ArrivalTime] = []
    
    private let networkManager = NetworkManager()
    private var anyCancellable = Set<AnyCancellable>()
    
    func getBussesArivalTimes(for stop: String)  {
        
        networkManager.fetchData(using: stop)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self] (arrivalTime: [ArrivalTime]) in
                guard let strong = self else { return }
                strong.arrivalTime = arrivalTime.sorted { $0.timeInMinutes > $1.timeInMinutes }
                
            }).store(in: &self.anyCancellable)
    }
}

