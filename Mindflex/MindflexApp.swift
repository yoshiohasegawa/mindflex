//
//  MindflexApp.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/17.
//

import SwiftUI

@main
struct MindflexApp: App {
    
    // Properties
    
    // DataLoader() is an object with property questionList.
    //  - questionList is of type QuestionList() with property data.
    //    - data is of type [Question]
    //     - Question contains: [question: String, answer: Bool]
    // ---
    // TODO: Handle when DataLoader() fails to fetch data via API...
    // Make more API calls?
    var data: DataLoader = DataLoader()
    
    var body: some Scene {
        WindowGroup {
            LoadingAppView(data: data)
        }
    }
}
