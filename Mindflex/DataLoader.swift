//
//  DataLoader.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/17.
//

import Foundation

public class DataLoader: ObservableObject {
    
    @Published var questions = [Question]()
    
    init() {
        load()
    }
    
    func load() {
        // Mindflex/Resources/QuestionData.json
        if let fileLocation = Bundle.main.url(
            forResource: "QuestionData",
            withExtension: "json"
        ) {
            // do catch in case of error
            do {
                // Get data
                let data = try Data(contentsOf: fileLocation)
                // Parse JSON
                let jsonDecoder = JSONDecoder()
                // Decode at array of Question objects
                let parsedData = try jsonDecoder.decode(
                    [Question].self,
                    from: data
                )

                self.questions = parsedData
            } catch {
                print(error)
            }
        }
    }
    
    func append(_ question: Question) {
        questions.append(question)
    }
}
