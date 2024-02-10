//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Aasem Hany on 08/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria",
                            "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0..<3)
    
    @State private var showScoreDialog = false
    
    @State private var scoreMsg = ""
    
    @State private var alertMsg = ""
    
    @State private var alertButtonTitle = "Continue"
    
    @State private var userScore = 0
    
    @State private var answeredQuestion = 0
    
    var body: some View {
        ZStack{
            
            RadialGradient(
                stops: [.init(color: .red, location: 0.3), .init(color: .blue, location: 0.3)],
                center: .top,
                startRadius: 230,
                endRadius: 500).ignoresSafeArea()
            
            VStack{
                
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.heavy))
                    .foregroundStyle(.white)
                
                Spacer()
                
                VStack(spacing: 10){
                    
                    VStack{
                        
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text("\(countries[correctAnswer])")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundStyle(.white)
                        
                    }
                    
                    VStack(spacing: 15){
                        
                        ForEach(0..<3) { number in
                            
                            Button{
                                flagTapped(number)
                            }label: {
                                Image(countries[number])
                                    .clipShape(.capsule)
                                    .shadow(radius: 5)
                            }
                            
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .padding()
                
                Spacer()
                
                Spacer()
                
                
                Text("Score: \(userScore)")
                    .font(.title.bold())
                    .foregroundStyle(.white)
                
            }
            
        }
        .alert(scoreMsg, isPresented: $showScoreDialog){
            Button(alertButtonTitle, action: askQuestion)
        }message: {
            Text("\(alertMsg)")
        }
        
    }
    
    private func handleAnsweredQuestionCounter(){
        if answeredQuestion < 8 { answeredQuestion += 1 }
        if answeredQuestion == 8 {
            alertMsg += "\n Game Finished"
            alertButtonTitle = "Restart"
        }
        showScoreDialog = true

    }
    
    private func resetGame() {
        answeredQuestion = 0
        userScore = 0
    }
    
    private func handleCorrectAnswer() {
        scoreMsg = "Correct"
        userScore += 1
        alertMsg = "Your score is: \(userScore) out of 8"
    }
    
    private func handleWrongAnswer(of number: Int) {
        scoreMsg = "Wrong"
        userScore -= 1
        alertMsg = "This is the flag of \(countries[number]) \nYour score is: \(userScore) out of 8"
    }
    
    private func flagTapped(_ number: Int) {
        if number == correctAnswer { handleCorrectAnswer() }
        else { handleWrongAnswer(of: number) }
        handleAnsweredQuestionCounter()
    }
    
    private func askQuestion(){
        if answeredQuestion == 8 { resetGame() }
        countries.shuffle()
        correctAnswer = Int.random(in: 0..<3)
        
    }
}

#Preview {
    ContentView()
}
