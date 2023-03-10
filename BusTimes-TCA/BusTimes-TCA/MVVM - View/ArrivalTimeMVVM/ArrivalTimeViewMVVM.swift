//
//  ArrivalTimeViewMVVM.swift
//  BusTimes-MVVM
//
//  Created by Ade Adegoke on 12/02/2023.
//

import SwiftUI

struct ArrivalTimeViewMVVM: View {
    @StateObject private var viewModel = ArrivalTimeViewModel()
    var busTopID: String
    
    init(busTopID: String) {
        self.busTopID = busTopID
    }
    
    var body: some View {
        
        VStack {
            Text("Arrival Times")
                .font(.system(size: 36, weight: .black))
                .padding(.top, 100)
            ScrollView(.vertical) {
                LazyVStack(spacing: 0) {
                    ForEach(0..<viewModel.arrivalTime.count, id: \.self) { i in
                        let arrivalTime = viewModel.arrivalTime[i]
                        ArriveTimeRowMVVM(arrivalTime: arrivalTime)
                        
                    }
                }
            }
            .padding(.top, 10)
            .onAppear {
                viewModel.getBussesArivalTimes(for: busTopID)
            }
        }
    }
}
