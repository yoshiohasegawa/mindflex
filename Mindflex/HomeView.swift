//
//  HomeView.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                    .foregroundColor(Color("SecondaryColor"))
                    .frame(width: 600, height: 3000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("PrimaryColor"))
                    .rotationEffect(Angle(degrees: 35))
                    .frame(width: 550, height: 3000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("AlternateColor"))
                    .rotationEffect(Angle(degrees: 60))
                    .frame(width: 450, height: 3000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                Rectangle()
                    .foregroundColor(Color("BackgroundColor"))
                    .rotationEffect(Angle(degrees: 40))
                    .frame(width: 300, height: 3000, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                
                VStack {
                    Image("Logo")
                    
                    Text("Welcome to\nMindflex")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.bottom)
                    
                    NavigationLink(
                        destination: GameView()
                            .navigationBarHidden(true),
                        label: {
                            Text("Begin")
                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                .padding()
                                .foregroundColor(Color("SecondaryColor"))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color("SecondaryColor"), lineWidth: 1))
                        })
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
