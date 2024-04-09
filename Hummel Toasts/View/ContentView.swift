//
//  ContentView.swift
//  CustomToasts
//
//  Created by Balaji Venkatesh on 15/12/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Button("Present Toast") {
                Toast.shared.present(
                    title: "AirPods Pro",
                    symbol: "airpodspro",
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
        }
        .initializeToasts()
        .padding()
    }
}

#Preview {
    ContentView()
}
