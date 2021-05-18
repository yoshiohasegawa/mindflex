//
//  ContentView.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/17.
//

import SwiftUI

struct ContentView: View {
    
    
    // Properties
    
    // DataLoader is an array containing objects of type Question
    // Qeuestion contains: [question: String, answer: Bool]
    @ObservedObject var data = DataLoader()
    // Indexer increases with every user response
    @State var idx = 0
    // Keeps track of the user score
    @State var score = 0
    // Bool to highlight the score when increased
    @State var scoreHighlight = Color("AccentColor")
    // Helper properties for appending new Question object
    // when data array runs out of questions
    @State var answer = true
    @State var question = ""
    // Bool to identify if game has started
    @State var begin = false
    // Timer
    @State var timer: Timer? = nil
    // ProgressView value
    @State var progressValue = 0.0
    // Bool to identify if game has ended
    @State var gameOver = false
    
    // Methods
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){
            (timer) in progressValue += 0.1
            print(progressValue)
            if progressValue > 0.9 {
                timer.invalidate()
                gameOver = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    var body: some View {
        ZStack {
            // Background
            Image("Background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .offset(x: -550.0, y: 0.0)
            
            // Main Container
            VStack() {
                // Logo & user score tracker
                VStack() {
                    Image("Logo")
                        .padding(.bottom, 12.0)
                    HStack(alignment: .center) {
                        Text("Score: ")
                            .font(.headline)
                            .foregroundColor(.white)
                            
                        Text(String(score))
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                    .padding(.horizontal, 12.0)
                    .background(scoreHighlight.blur(radius: 30))
                    
                    // ProgressView timer for each question
                    if begin {
                        ProgressView(value: progressValue)
                            .accentColor(Color("AccentColor"))
                            .padding(.vertical, 12.0)
                            .frame(width: 300.0)
                    }
                    
                    // Motivation notes!
                    if score == 10 {
                        Text("Nice, keep going!")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    } else
                    if score == 50 {
                        Text("Wow 50 points!!")
                            .font(.title)
                            .foregroundColor(.white)
                            .padding()
                    } else
                    if score == 100 {
                        Text("You're on 🔥🔥🔥")
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    } else
                    if score % 25 == 0 && score != 0 {
                        Text("Awesome work!")
                            .font(.title)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    else {
                        Text(" ")
                            .font(.title)
                            .padding()
                    }
                    
                }
            
                Spacer()
                
                // Question asked to user
                if begin && gameOver == false {
                    Text(data.questions[idx].question)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                } else
                if gameOver {
                    Text("Thanks for playing!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                } else {
                    ZStack {
                        Text(" ")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                        Text("Get ready for your first question...")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                
                    
                
                Spacer()
                
                // True & False buttons
                if begin && gameOver == false {
                    HStack() {
                        // True Button
                        Button(action: {
                            // Stop previous timer
                            stopTimer()
                            
                            // Update score if correct
                            if data.questions[idx].answer == true {
                                scoreHighlight = Color.green
                                score += 1
                                
                                // Increment data indexer
                                idx += 1
                                
                                // Update question/answer if data array ran out of questions
                                if idx >= Int(data.questions.count) {
                                    // Generate 2 random numbers
                                    let randNum1 = Int.random(in: 0...100)
                                    let randNum2 = Int.random(in: 0...100)
                                    // Even index => append new "less than" Question to data array
                                    if idx % 2 == 0 {
                                        answer = randNum1 < randNum2
                                        question = String(randNum1) + " < " + String(randNum2)
                                        data.append(Question(question: question, answer: answer))
                                    // Odd index => append new "greater than" Question to data array
                                    } else {
                                        answer = randNum1 > randNum2
                                        question = String(randNum1) + " > " + String(randNum2)
                                        data.append(Question(question: question, answer: answer))
                                    }
                                }
                                // Start new timer
                                progressValue = 0.0
                                startTimer()
                            } else {
                                scoreHighlight = Color("AccentColor")
                                gameOver = true
                                // Set progressValue to full
                                progressValue = 1.0
                            }
                        }, label: {
                            Text("True")
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 1))
                        })
                        
                        Spacer()
                            .frame(width: 20)
                        
                        // False Button
                        Button(action: {
                            // Stop previous timer
                            stopTimer()
                            // Update score if correct
                            if data.questions[idx].answer == false {
                                scoreHighlight = Color.green
                                score += 1
                                // Increment data indexer
                                idx += 1

                                // Update question/answer if data array ran out of questions
                                if idx >= Int(data.questions.count) {
                                    // Generate 2 random numbers
                                    let randNum1 = Int.random(in: 0...100)
                                    let randNum2 = Int.random(in: 0...100)
                                    // Even index => append new "less than" Question to data array
                                    if idx % 2 == 0 {
                                        answer = randNum1 < randNum2
                                        question = String(randNum1) + " < " + String(randNum2)
                                        data.append(Question(question: question, answer: answer))
                                    // Odd index => append new "greater than" Question to data array
                                    } else {
                                        answer = randNum1 > randNum2
                                        question = String(randNum1) + " > " + String(randNum2)
                                        data.append(Question(question: question, answer: answer))
                                    }
                                }
                                // Start new timer
                                progressValue = 0.0
                                startTimer()
                            } else {
                                scoreHighlight = Color("AccentColor")
                                gameOver = true
                                // Set progressValue to full
                                progressValue = 1.0
                            }
                        }, label: {
                            Text("False")
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.white, lineWidth: 1))
                        })
                    }
                } else
                if gameOver {
                    // Begin Button
                    Button(action: {
                        // Stop previous timer
                        stopTimer()
                        // set begin to true
                        // to start a NEW game
                        gameOver = false
                        begin = true
                        // Start new timer
                        progressValue = 0.0
                        startTimer()
                        
                    }, label: {
                        Text("Begin New Game")
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 1))
                    })
                } else {
                    // Begin Button
                    Button(action: {
                        // set begin to true
                        // to start the game
                        begin = true
                        // Start timer
                        startTimer()
                        
                    }, label: {
                        Text("Begin")
                            .padding()
                            .foregroundColor(.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.white, lineWidth: 1))
                    })
                }
                
                Spacer()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    // Properties
    static var previews: some View {
        ContentView()
            
    }
}
