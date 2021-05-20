//
//  HomeView.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/18.
//

import SwiftUI

struct HomeView: View {
    
    // Properties
    
    // DataLoader() is an object with property questionList.
    // questionList is of type QuestionList() with property data.
    // data is of type [Question]
    // Question contains: [question: String, answer: Bool]
    // ---
    // Load the data on HomeView and pass it to GameView
    // ---
    // TODO: Handle when DataLoader() fails to fetch data via API...
    // Loading page? Or, simply proceed with a default data variable?
    @State var data: DataLoader = DataLoader()
    
    
    var body: some View {
        
        NavigationView {
            ZStack {
                //Background
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .frame(width: 600, height: 3000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .rotationEffect(Angle(degrees: 35))
                    .frame(width: 550, height: 3000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 100)
                Rectangle()
                    .foregroundColor(Color("AlternateColor"))
                    .rotationEffect(Angle(degrees: 60))
                    .frame(width: 450, height: 3000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 100)
                Rectangle()
                    .foregroundColor(Color("BackgroundColor"))
                    .rotationEffect(Angle(degrees: 40))
                    .frame(width: 300, height: 3000)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .padding(.bottom, 100)
                
                // Main Container
                VStack() {
                    Image("Logo")
                    
                    // Title
                    Text("Welcome to\nMindflex")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    // Begin Button
                    NavigationLink(
                        destination: GameView(data: data)
                            .navigationBarHidden(true),
                        label: {
                            Text("Begin")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding()
                                .foregroundColor(Color("SecondaryColor"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("SecondaryColor"), lineWidth: 1))
                        }).simultaneousGesture(TapGesture().onEnded{
                            // When the user selects "Begin",
                            // randomize game data so the user cannot anticipate questions
                            data.randomizeData()
                        })
                }
                .padding(.bottom, 100)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                
        }
    }
}
