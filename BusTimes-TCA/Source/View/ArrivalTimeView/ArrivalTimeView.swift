//
//  ArrivalTimeView.swift
//  BusTimes-TCA
//
//  Created by Ade Adegoke on 12/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct ArrivalTimeView: View {
    
    let store: StoreOf<ArrivalTimeFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                VStack {
                    if viewStore.isFetching {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }else {
                        if viewStore.state.arrivalTimes.isEmpty {
                            Text("There is no information currently\navailable for this stop!")
                                .font(.system(size: 18, weight: .medium))
                                .multilineTextAlignment(.center)
                        } else {
                            List {
                                ForEach(viewStore.arrivalTimes, id: \.id) { time in
                                    ArriveTimeRow(arrivalTime: time)
                                }
                            }
                            .listStyle(.plain)
                        }
                    }
                }
                .navigationTitle("Arrival Times")

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
