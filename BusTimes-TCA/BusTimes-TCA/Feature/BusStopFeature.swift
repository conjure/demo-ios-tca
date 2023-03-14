//
//  BusStopFeature.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 13/03/2023.
//

import Foundation
import Combine
import ComposableArchitecture
import ComposableCoreLocation

struct BusStopFeature: ReducerProtocol {
    let networkManager: NetworkManager
    let locationManager: LocationManager
   
    struct State: Equatable {
        var listOfBusStops: [BusStop] = []
        var isFetching = false
        var isSheetPresented = false
        var selectedStop: BusStop?
        var alert: AlertState<Action>?
        var coordinates: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    }

    enum Action: Equatable {
        case onAppear
        case busStopResponse(TaskResult<[BusStop]>)
        case selectStop(stop: BusStop)
        case setSheet(isPresented: Bool)
        case alertDismissed
        case locationManager(LocationManager.Action)
        case fetchData
        //case didChangeAuthorization
    }
    

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .locationManager(.didUpdateLocations(let locations)):
            guard let location = locations.last else { return .none }
            state.coordinates = location.coordinate
            return .task {
                return .fetchData
            }
        case .onAppear:
            return .merge(
                  locationManager
                    .delegate()
                    .map(Action.locationManager),

                  locationManager
                    .requestWhenInUseAuthorization()
                    .fireAndForget(),
                  
                  locationManager.requestLocation()
                    .fireAndForget()
                )
        case .fetchData:
                        state.isFetching = true
                        let lat = state.coordinates.latitude
                        let long = state.coordinates.longitude
                        let endpoint = BusStopEndpoint.stopPoint(coordinate: (lat, long))
                        let busStopPublisher: AnyPublisher<TravelInformation, APIError> = networkManager.fetchData(endpoint: endpoint)
            
                        return .task {
                            await .busStopResponse(TaskResult { try await busStopPublisher
                                    .map({$0.stopPoints})
                                    .eraseToAnyPublisher()
                                .async()})
                        }
        case .busStopResponse(.success(let stops)):
            state.isFetching = false
            state.listOfBusStops = stops
            return .none
        case .busStopResponse(.failure(let error)):
            state.isFetching = false
            state.alert = AlertState(
                title: TextState("Error! Unable to retrieve your local bus stop data."),
                message: TextState(error.localizedDescription),
                dismissButton: .default(TextState("OK"), action: .send(Action.alertDismissed))
            )
            return .none
        case .selectStop(let stop):
            state.selectedStop = stop
            return .task {
                return .setSheet(isPresented: true)
            }
        case .setSheet(isPresented: true):
            state.isSheetPresented = true
            return .none

        case .setSheet(isPresented: false):
            state.isSheetPresented = false
            state.selectedStop = nil
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        case .locationManager(.didChangeAuthorization(.authorizedAlways)),
             .locationManager(.didChangeAuthorization(.authorizedWhenInUse)):
          return locationManager
            .requestLocation()
            .fireAndForget()
        case .locationManager:
            print("Unimplemented Action - \(action)")
            return .none
        }
        
    }
}


