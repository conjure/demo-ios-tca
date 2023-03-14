//
//  ArrivalTimeFeature.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 13/03/2023.
//

import Foundation
import Combine
import ComposableArchitecture

struct ArrivalTimeFeature: ReducerProtocol {
    let selectedBusStop: BusStop
    let networkManager: NetworkManager
    
    struct State: Equatable {
        var isFetching = false
        var arrivalTimes: [ArrivalTime] = []
        var alert: AlertState<Action>?
    }

    enum Action: Equatable {
        case onAppear
        case arrivalTimeResponse(TaskResult<[ArrivalTime]>)
        case alertDismissed
    }

    func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            state.isFetching = true
            let endpoint = BusStopEndpoint.arrivals(busStopID: selectedBusStop.naptanId)
            let arrivalTimePublisher: AnyPublisher<[ArrivalTime], APIError> = networkManager.fetchData(endpoint: endpoint)

            return .task {
                await .arrivalTimeResponse(TaskResult { try await arrivalTimePublisher
                        .map({$0})
                        .eraseToAnyPublisher()
                    .async()})
            }
            
        case .arrivalTimeResponse(.success(let times)):
            state.isFetching = false
            state.arrivalTimes = times
            return .none
        case .arrivalTimeResponse(.failure(let error)):
            state.isFetching = false
            state.alert = AlertState(
                title: TextState("Error! Unable to retrieve bus arrival times."),
                message: TextState(error.localizedDescription),
                dismissButton: .default(TextState("OK"), action: .send(Action.alertDismissed))
            )
            return .none
        case .alertDismissed:
            state.alert = nil
            return .none
        }
    }
}

