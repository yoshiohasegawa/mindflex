//
//  DataLoader.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/17.
//

import Foundation

public class DataLoader: ObservableObject {
    
    // Initialize questionList so its self can be accessed in load()
    @Published var questionList: QuestionList = QuestionList(
        data: [Question(_id: "sample_1", question: "3 < 93", answer: true)])
    
    init() {
        // Get all question data upon initialization
        load()
        // Make load() an async/await function so that
        // we can randomize data after it is loaded everytime.
        // Like this...
        // questionList.randomizeList()
    }
    
    // Get all question data from backend server
    func load() {
        // Initializing /api/questions URL
        let mindflexApiUrl = URL(string:
            "https://mindflexapi.herokuapp.com/api/questions"
        )

        // Guarding URL creation
        guard mindflexApiUrl != nil else {
            print("\nError created URL object")
            return
        }

        // Initializing URL Request object
        var request = URLRequest(
            url: mindflexApiUrl!,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: 10
        )

        // Set Request headers to handle JSON
        let headers = ["content-type": "application/json"]
        request.allHTTPHeaderFields = headers
        // Set Request method to GET
        request.httpMethod = "GET"
        // Initialize URL Session
        let session = URLSession.shared

        // Initialize URL Session Task logic
        let dataTask = session.dataTask(with: request) {
            (data, response, error) in
            
            // Try to decode data with QuestionList struct object
            do {
                if error == nil && data != nil {
                    // Parse JSON
                    let decoder = JSONDecoder()
                    self.questionList = try decoder.decode(QuestionList.self, from: data!)
                    print("Data fetched from Mindflex server...")
                }
            // Catch print error & set questionList to sample data stored locally
            } catch {
                print("\nError parsing response data from Mindflex server")
                
                let resp = response as? HTTPURLResponse
                print("Status code: " + String(resp!.statusCode) + "\nError: ")
                print(error)
            }
        }

        // Make API Request
        dataTask.resume()
    }
    
    // Call the QuestionList append() mutating function
    func append(_ question: Question) {
        questionList.append(question)
    }
    
    // Call the QuestionList randomizeList() mutating function
    func randomizeData() {
        questionList.randomizeList()
    }
}
