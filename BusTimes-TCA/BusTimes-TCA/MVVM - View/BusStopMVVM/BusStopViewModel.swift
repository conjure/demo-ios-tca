//
//  BusStopViewModel.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 08/02/2023.
//
import SwiftUI
import Combine

class BusStopViewModel: ObservableObject {
    
    @Published var locationService = LocationService()
    @Published var busStops: [BusStop] = []
    
    private let networkManager = NetworkManager()
    private var anyCancellable = Set<AnyCancellable>()
    
    var status: Status = .notDetermined
    var coordinates: Coordinate?
    
    init() {
        locationService.delegate = self
    }
    
    func getBusTopData(with coordinates: Coordinate)  {
        networkManager.fetchData(endpoint: BusStopEndpoint.stopPoint(coordinate: coordinates))
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { [weak self ] (busStops: TravelInformation) in
                guard let strong = self else { return }
                strong.busStops = busStops.stopPoints   
            }).store(in: &self.anyCancellable)
    }
}


extension BusStopViewModel: LocationServicesDelegate {
    func getUserAuthorizationStatus(_ status: Status) {
        self.status = status
    }
    
    func getUserCurrentLatLonCoordinates(_ coordinate: Coordinate) {
        getBusTopData(with: coordinate)
    }
}
