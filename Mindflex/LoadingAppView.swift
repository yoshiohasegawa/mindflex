//
//  LoadingAppView.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/20.
//

import SwiftUI

struct LoadingAppView: View {
    
    // Properties
    
    // DataLoader() is an object with property questionList.
    //  - questionList is of type QuestionList() with property data.
    //    - data is of type [Question]
    //     - Question contains: [question: String, answer: Bool]
    @State var data: DataLoader
    @State var loadingComplete = false
    @State var loadingFailed = false
    @State var timer: Timer? = nil
    @State var dotsString = ""
    @State var seconds = 0 {
        didSet {
            if dotsString == "...." {
                dotsString = ""
            } else {
                dotsString += "."
            }
        }
    }
    
    // Methods
    
    // Starting timer to allow for API call to complete
    func startTimer() {
        // 3 second timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            (timer) in seconds += 1
            // If time runs out
            if seconds > 3 {
                timer.invalidate()
                // Check if API call is complete
                if data.loadComplete {
                    // If so, move on to next View
                    loadingComplete = true
                // Else, if API call has not completed...
                } else {
                    // Reset timer
                    // resetTimer() <- Commenting out for offline usability
                    
                    // TODO: Handle when API call fails
                    loadingComplete = true
                }
            }
        }
    }
    
    // Reset timer and start again
    func resetTimer() {
        timer = nil
        seconds = 0
        startTimer()
    }
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //Background
                Rectangle()
                    .foregroundColor(Color("BackgroundColor"))
                    .frame(width: 1000, height: 3000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .rotationEffect(Angle(degrees: 25))
                    .frame(width: 30, height: 1000)
                    .edgesIgnoringSafeArea(.all)
                    .padding([.bottom, .trailing], 300.0)
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .rotationEffect(Angle(degrees: -80))
                    .frame(width: 30, height: 1000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 400)
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .rotationEffect(Angle(degrees: -45))
                    .frame(width: 30, height: 1000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 550)
                Rectangle()
                    .foregroundColor(Color("AlternateColor"))
                    .rotationEffect(Angle(degrees: -20))
                    .frame(width: 30, height: 1000)
                    .padding(.trailing, 240)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .rotationEffect(Angle(degrees: 50))
                    .frame(width: 30, height: 1000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.top, 400)
                Rectangle()
                    .foregroundColor(Color("AlternateColor"))
                    .rotationEffect(Angle(degrees:5))
                    .frame(width: 30, height: 1000)
                    .padding(.leading, 240)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                
                // Main Container
                VStack() {
                    Image("Logo")
                    
                    // Loading Container
                    HStack {
                        Text("loading" + dotsString)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.bottom)
                    }
                    
                    NavigationLink(
                        destination: HomeView(data: data)
                            .navigationBarHidden(true),
                        isActive: $loadingComplete ) {
                        EmptyView()
                    }
                }
                .onAppear() {
                    startTimer()
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct LoadingAppView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingAppView(data: DataLoader())
    }
}
