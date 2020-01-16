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
    @State var showAlert = false
    
    @ObservedObject var timer = TimeCounter()
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        VStack {
                            Color(red: rTarget, green: gTarget, blue: bTarget)
                            self.showAlert ? Text("R: \(readableDouble(double: rGuess))  G: \(readableDouble(double: gGuess))  B: \(readableDouble(double: bGuess))") : Text("Match this colour")
                        }
                        // Guess colour view
                        VStack {
                            ZStack {
                                Color(red: rGuess, green: gGuess, blue: bGuess)
                                Text(String(timer.counter))
                                    .padding(.all, 5)
                                    .background(Color.white)
                                    .mask(Circle())
                                    .foregroundColor(.black)
                            }
                            Text("R: \(readableDouble(double: rGuess))  G: \(readableDouble(double: gGuess))  B: \(readableDouble(double: bGuess))")
                        }
                    }
                    Button(action: {
                        self.showAlert = true
                        self.timer.killTimer()
                    }) {
                        Text("Hit me!")
                    }.alert(isPresented: $showAlert) {
                        Alert(title: Text("Your score"), message: Text(String(computeScore())))
                    }.padding()
                }
                VStack {
                    ColorSlider(value: $rGuess, textColor: .red)
                    ColorSlider(value: $gGuess, textColor: .green)
                    ColorSlider(value: $bGuess, textColor: .blue)
                }.padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
            .previewLayout(.fixed(width: 368, height: 568))
//            .environment(\.colorScheme, .dark)
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
                    .background(textColor)
                    .cornerRadius(10)
                Text("255").foregroundColor(textColor)
            }
        }
    }
    
    func computeScore() -> Int {
        let rDiff = rGuess - rTarget
        let gDiff = gGuess - gTarget
        let bDiff = bGuess - bTarget
        let diff = sqrt(rDiff * rDiff + gDiff * gDiff + bDiff * bDiff)
        return Int((1.0 - diff) * 100.0 + 0.5)
    }
    
    // Convenience method
    func readableDouble(double: Double) -> String {
        return String(Int(double * 255.0))
    }
}
