//
//  Feature.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 07/03/2023.
//

import Foundation
import ComposableArchitecture

struct Feature: ReducerProtocol {

    private let locationService = LocationService()
    
    struct State: Equatable {
        var listOfBusStops: [BusStop] = []
        var selectedBusStop: BusStop?
        var arrivalTimes: [ArrivalTime] = []
    }
    
    enum Action {
        case onAppear
        case fetchBusStops(Result<EffectPublisher<TravelInformation, Never>.Output, Never>)
        case fetchArrivalTimes(Result<EffectPublisher<[ArrivalTime], Never>.Output, Never>)
        case selectedBusStop(BusStop)
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            let decoder = JSONDecoder()
            return Effects.busStopEffect(endpoint: .findLocalStops(using: locationService.userCurrentCoordinate), decoder: decoder)
                     .receive(on: DispatchQueue.main)
                    .catchToEffect()
                    .map(Action.fetchBusStops)
    
        case .fetchBusStops(let result):
          switch result {
          case .success(let busStops):
              state.listOfBusStops = busStops.stopPoints
          case .failure(let error):
            print(error)
          }
            return .none
        case .selectedBusStop(let busStop):
            let decoder = JSONDecoder()
            return Effects.arrivalTimeEffect(using: busStop.naptanId, decoder: decoder)
                .receive(on: DispatchQueue.main)
               .catchToEffect()
               .map(Action.fetchArrivalTimes)
        case .fetchArrivalTimes(let result):
            switch result {
            case .success(let arrivalTime):
                state.arrivalTimes = arrivalTime
            case .failure(let error):
              print(error)
            }
            return .none
        }
    }
}

extension Feature.Action: Equatable {
    static func == (lhs: Feature.Action, rhs: Feature.Action) -> Bool {
        switch (lhs, rhs) {
        case (.onAppear, .onAppear):
            return true
        case (.fetchBusStops(let lhsValue), .fetchBusStops(let rhsValue)):
            return lhsValue == rhsValue
        case (.selectedBusStop(let lhsValue), .selectedBusStop(let rhsValue)):
            return lhsValue == rhsValue
        default:
            return false
        }
    }
}
