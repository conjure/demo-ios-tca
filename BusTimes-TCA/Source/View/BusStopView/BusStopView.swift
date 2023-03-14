//
//  LocalBusStopView.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct BusStopView: View {
    let store: StoreOf<BusStopFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    if viewStore.isFetching {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        List {
                            ForEach(viewStore.listOfBusStops, id: \.id) { stop in
                                Button {
                                    viewStore.send(.selectStop(stop: stop))
                                } label: {
                                    BusStopRow(busStop: stop)
                                }
                            }
                        }
                        .listStyle(.plain)
                    }
                }
                .sheet(
                    isPresented: viewStore.binding(
                        get: \.isSheetPresented,
                        send: BusStopFeature.Action.setSheet(isPresented:)
                    )
                ) {
                    ArrivalTimeView(store: Store(
                        initialState: ArrivalTimeFeature.State(),
                        reducer: ArrivalTimeFeature(selectedBusStop: viewStore.selectedStop!)
                    ))                }
                .navigationTitle("Bus stops")
                .alert(
                    self.store.scope(state: \.alert),
                    dismiss: .alertDismissed
                )
                .onAppear {
                    viewStore.send(.onAppear)
                }
            }
        }
    }
}
