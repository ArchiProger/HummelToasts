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
            Button("Present Default Toast") {
                Toast.shared.present(
                    title: "AirPods Pro",
                    symbol: "airpodspro",
                    isUserInteractionEnabled: true,
                    timing: .long
                )
            }
            
            Button("Present Custom Toast") {
                Toast.shared.present {
                    let uuid = UUID()
                    
                    HStack {
                        Image(systemName: "checkmark.seal.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25)
                            .foregroundStyle(.green)
                        
                        Text("Success")
                    }
                    .onAppear {
                        print("Delivered: \(uuid)")
                    }
                }
            }
        }
        .initializeToasts()
        .padding()
    }
}

#Preview {
    ContentView()
}
