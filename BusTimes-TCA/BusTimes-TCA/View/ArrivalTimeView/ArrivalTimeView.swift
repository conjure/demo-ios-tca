//
//  ArrivalTimeView.swift
//  BusTimes-MVVM
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
                        Text("Arrival Times")
                            .font(.system(size: 36, weight: .black))
                            .padding(.top, 100)
                        List {
                            ForEach(viewStore.arrivalTimes, id: \.id) { time in
                                ArriveTimeRow(arrivalTime: time)
                            }
                        }
                        .listStyle(.plain)
                    }
                }
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
