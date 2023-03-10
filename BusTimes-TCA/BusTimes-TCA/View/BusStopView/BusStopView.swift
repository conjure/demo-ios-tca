//
//  LocalBusStopView.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 05/02/2023.
//

import SwiftUI
import ComposableArchitecture

struct BusStopView: View {
    let store: StoreOf<Feature>
    @State private var didSelectBusStop = false
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                VStack {
                    Text("Arrival Times")
                        .font(.system(size: 36, weight: .black))
                        .padding(.top, 70)
                    List {
                        ForEach(0..<viewStore.listOfBusStops.count , id: \.self) { index in
                            let busStop = viewStore.listOfBusStops[index]
                            BusStopRow(busStop: busStop)
                                .onTapGesture {
                                    viewStore.send(.selectedBusStop(busStop))
                                    didSelectBusStop.toggle()
                                }
                        }
                    }
                    .padding(.top, 10)
                }.sheet(isPresented: $didSelectBusStop) {
                    ArrivalTimeView(store: self.store)
                }
            }.onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}
