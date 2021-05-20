//
//  ContentView.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/17.
//

import SwiftUI

struct GameView: View {
    
    // Properties
    
    // DataLoader() is an object with property questionList.
    // questionList is of type QuestionList() with property data.
    // data is of type [Question]
    // Question contains: [question: String, answer: Bool]
    @State var data: DataLoader
    // Indexer increases with every user response
    @State var idx = 0
    // Keeps track of the user score
    @State var score = 0
    // Bool to highlight the score when increased
    @State var scoreHighlight = Color("SecondaryColor")
    // Helper properties for appending new Question object
    // when data array runs out of questions
    @State var answer = true
    @State var question = ""
    // Bool to identify if game has started
    @State var start = false
    // Timer reference to start & restart
    @State var timer: Timer? = nil
    // ProgressView value
    @State var progressValue = 0.0
    // Bool to identify if game has ended
    @State var gameOver = false
    
    // Methods
    func resetData() {
        idx = 0
        // Randomize game data so the user cannot anticipate questions
        data.randomizeData()
    }
    
    func startTimer() {
        // 3 second timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true){
            (timer) in progressValue += 0.1
            // If time runs out
            if progressValue > 0.9 {
                timer.invalidate()
                // Reset Question data
                resetData()
                // Game over!
                gameOver = true
            }
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    
    var body: some View {
        NavigationView {

            ZStack {
                // Background
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .edgesIgnoringSafeArea(.all)
                RoundedRectangle(cornerRadius: 40, style: .continuous)
                    .foregroundColor(Color("BackgroundColor"))
                    .edgesIgnoringSafeArea(.all)
                    .padding(.horizontal, 5.0)
                
                // Main Container
                VStack() {
                    // Logo & user score tracker
                    VStack() {
                        Image("Logo")
                            .padding()
                        HStack(alignment: .center) {
                            Text("Score: ")
                                .font(.title3)
                                .foregroundColor(.white)
                                
                            Text(String(score))
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                        .padding(.horizontal, 12.0)
                        .background(scoreHighlight.blur(radius: 20))
                        
                        // ProgressView timer for each question
                        if start {
                            ProgressView(value: progressValue)
                                .accentColor(Color("SecondaryColor"))
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
                    .padding()
                
                    Spacer()
                    
                    // Question asked to user
                    if start && gameOver == false {
                        Text(data.questionList.data[idx].question)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                    } else
                    if gameOver {
                        Text("Thanks for playing!")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        Text("Get ready for your first question...")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                    
                    Spacer()
                    
                    // True & False buttons
                    if start && gameOver == false {
                        HStack() {
                            // True Button
                            Button(action: {
                                // Stop previous timer
                                stopTimer()
                                
                                // Update score if correct
                                if data.questionList.data[idx].answer == true {
                                    scoreHighlight = Color.green
                                    score += 1
                                    
                                    // Increment data indexer
                                    idx += 1
                                    
                                    // Update question/answer if data array ran out of questions
                                    if idx >= Int(data.questionList.data.count) {
                                        // Generate 2 random numbers
                                        let randNum1 = Int.random(in: 0...100)
                                        let randNum2 = Int.random(in: 0...100)
                                        // Even index => append new "less than" Question to data array
                                        if idx % 2 == 0 {
                                            answer = randNum1 < randNum2
                                            question = String(randNum1) + " < " + String(randNum2)
                                            data.append(Question(_id: "rand", question: question, answer: answer))
                                        // Odd index => append new "greater than" Question to data array
                                        } else {
                                            answer = randNum1 > randNum2
                                            question = String(randNum1) + " > " + String(randNum2)
                                            data.append(Question(_id: "rand", question: question, answer: answer))
                                        }
                                    }
                                    // Start new timer
                                    progressValue = 0.0
                                    startTimer()
                                // Game over
                                } else {
                                    scoreHighlight = Color("SecondaryColor")
                                    // Reset Question data
                                    resetData()
                                    // Game over!
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
                                if data.questionList.data[idx].answer == false {
                                    scoreHighlight = Color.green
                                    score += 1
                                    // Increment data indexer
                                    idx += 1

                                    // Update question/answer if data array ran out of questions
                                    if idx >= Int(data.questionList.data.count) {
                                        // Generate 2 random numbers
                                        let randNum1 = Int.random(in: 0...100)
                                        let randNum2 = Int.random(in: 0...100)
                                        // Even index => append new "less than" Question to data array
                                        if idx % 2 == 0 {
                                            answer = randNum1 < randNum2
                                            question = String(randNum1) + " < " + String(randNum2)
                                            data.append(Question(_id: "rand", question: question, answer: answer))
                                        // Odd index => append new "greater than" Question to data array
                                        } else {
                                            answer = randNum1 > randNum2
                                            question = String(randNum1) + " > " + String(randNum2)
                                            data.append(Question(_id: "rand", question: question, answer: answer))
                                        }
                                    }
                                    // Start new timer
                                    progressValue = 0.0
                                    startTimer()
                                // Game over
                                } else {
                                    scoreHighlight = Color("SecondaryColor")
                                    // Reset Question data
                                    resetData()
                                    // Game over!
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
                        VStack {
                            // Start Button
                            Button(action: {
                                // Stop previous timer
                                stopTimer()
                                // set start to true
                                // to start a NEW game
                                gameOver = false
                                score = 0
                                start = true
                                // Start new timer
                                progressValue = 0.0
                                startTimer()
                                
                            }, label: {
                                VStack {
                                    Spacer()
                                    
                                    Text("Start New Game")
                                        .padding()
                                        .foregroundColor(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color.white, lineWidth: 1))
                                }
                            })
                            
                            // Home Button
                            NavigationLink(
                                destination: HomeView()
                                    .navigationBarHidden(true),
                                label: {
                                    Text("Home")
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .padding()
                                        .foregroundColor(Color("SecondaryColor"))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 15)
                                                .stroke(Color("SecondaryColor"), lineWidth: 1))
                                })
                                .padding(.top, 15)
                        }
                        
                        
                    } else {
                        // Start Button
                        Button(action: {
                            // set start to true
                            // to start the game
                            start = true
                            // Start timer
                            startTimer()
                            
                        }, label: {
                            Text("Start")
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
}

struct ContentView_Previews: PreviewProvider {
    
    // Properties
    static var previews: some View {
        GameView(data: DataLoader())
            
    }
}
