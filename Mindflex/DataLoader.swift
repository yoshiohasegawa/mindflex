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
        data: [Question(_id: "", question: "", answer: true)])
    
    init() {
        // Get all question data upon initialization
        load()
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
                }
            // Catch print error & set questionList to sample data stored locally
            } catch {
                print("\nError parsing response data from Mindflex server")
                
                let resp = response as? HTTPURLResponse
                print("Status code: " + String(resp!.statusCode) + "\nError: ")
                print(error)
                
                // Mindflex/Resources/QuestionData.json
                if let fileLocation = Bundle.main.url(
                    forResource: "QuestionData",
                    withExtension: "json"
                ) {
                    // Try to decode data with QuestionList struct object
                    do {
                        // Get data from fileLocation
                        let data = try Data(contentsOf: fileLocation)
                        // Parse JSON
                        let decoder = JSONDecoder()
                        let parsedData = try decoder.decode(QuestionList.self, from: data)
                        self.questionList = parsedData
                    } catch {
                        print("\nError parsing data from local sample data storage\nError: ")
                        print(error)
                    }
                }
            }
        }

        // Make API Request
        dataTask.resume()
    }
    
    // Call the QuestionList append() mutating function
    func append(_ question: Question) {
        questionList.append(question)
    }
}
