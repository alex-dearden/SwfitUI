//
//  ContentView.swift
//  UITest
//
//  Created by Alex Dearden on 16/01/2020.
//  Copyright © 2020 Alex Dearden. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    let rTarget = Double.random(in: 0..<1)
    let gTarget = Double.random(in: 0..<1)
    let bTarget = Double.random(in: 0..<1)
    
    // State vars
    @State var rGuess: Double
    @State var gGuess: Double
    @State var bGuess: Double
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        Color(red: rTarget, green: gTarget, blue: bTarget)
                        Text("Match this colour")
                    }
                    VStack {
                        Color(red: rGuess, green: gGuess, blue: bGuess)
                        Text("R: \(readableDouble(double: rGuess))  G: \(readableDouble(double: gGuess))  B: \(readableDouble(double: bGuess))")
                    }
                }
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Hit me!")
                }
            }
            ColorSlider(value: $rGuess, textColor: .red)
            ColorSlider(value: $gGuess, textColor: .green)
            ColorSlider(value: $bGuess, textColor: .blue)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.2, gGuess: 0.3, bGuess: 0.7)
    }
}

extension ContentView {
    
    // Reusable view
    struct ColorSlider: View {
        // We use @Binding instead of @State because the struct where it will be used does not own its data
        //... it receives an initial value from its parent view and mutates it
        @Binding var value: Double
        var textColor: Color
        
        var body: some View {
            HStack {
                Text("0").foregroundColor(textColor)
                Slider(value: $value)
                Text("255").foregroundColor(textColor)
            }.padding(.horizontal)
        }
    }
    
    // Convenience method
    func readableDouble(double: Double) -> String {
        return String(Int(double * 255.0))
    }
}
