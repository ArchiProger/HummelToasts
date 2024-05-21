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
                    title: "Существуют две основные трактовки понятия «текст»: имманентная (расширенная, философски нагруженная) и репрезентативная (более частная). Имманентный подход подразумевает отношение к тексту как к автономной реальности, нацеленность на выявление его внутренней структуры. Репрезентативный — рассмотрение текста как особой формы представления информации о внешней тексту действительности.",
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
                        
                        Text("Существуют две основные трактовки понятия «текст»: имманентная (расширенная, философски нагруженная) и репрезентативная (более частная). Имманентный подход подразумевает отношение к тексту как к автономной реальности, нацеленность на выявление его внутренней структуры. Репрезентативный — рассмотрение текста как особой формы представления информации о внешней тексту действительности.")
                    }
                    .onAppear {
                        print("Delivered: \(uuid)")
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
        .initializeToasts()
        .preferredColorScheme(.dark)
}
