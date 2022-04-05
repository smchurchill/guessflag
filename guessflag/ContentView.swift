//
//  ContentView.swift
//  guessflag
//
//  Created by sam on 2022-04-04.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
        .shuffled()
    @State private var correct = Int.random(in:0...2)
    
    @State private var showScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var correctScore = 0
    @State private var wrongScore = 0
    @State private var totalScore = 0
    
    func flagTapped(_ number: Int) {
        if number == correct {
            scoreTitle = "Right!"
            scoreMessage = ""
            correctScore += 1
        } else {
            scoreTitle = "Wrong!"
            scoreMessage = "That's the flag of \(countries[number])"
            wrongScore += 1
        }
        totalScore = max(correctScore - wrongScore, 0)
        showScore = true
    }
    
    func resetGame() {
        countries.shuffle()
        correct = Int.random(in: 0...2)
    }
    
    var body: some View {
        ZStack {
            //            LinearGradient(gradient: Gradient(colors: [Color(red: 0.1, green: 0.3, blue: 0.2), .black]), startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.2),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.8)
            ], center: .top, startRadius: 300, endRadius: 700
            ) .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("It's a flag game.")
                    .foregroundColor(.white)
                    .font(.largeTitle.weight(.bold))
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Pick a flag! Any flag! Specfically:")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correct])
//                            .foregroundColor(.secondary)
                            .font(.largeTitle.weight(.semibold))
                        
                        
                        ForEach(0..<3) { number in
                            Button {
                                flagTapped(number)
                            } label: {
                                Image(countries[number])
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                            }
                            .alert(scoreTitle, isPresented: $showScore) {
                                Button("Continue", action: resetGame)
                            } message: {
                                Text(scoreMessage)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                HStack(spacing: 40) {
                    VStack {
                        Text("Right:\nWrong:\nScore:").foregroundColor(.white).font(.title.bold())
                    }
                    VStack {
                        Text("\(correctScore)\n\(wrongScore)\n\(totalScore)").foregroundColor(.white).font(.title.bold())
                    }
                }
                
                Spacer()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
