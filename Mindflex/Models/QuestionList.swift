//
//  QuestionList.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/19.
//

import Foundation

struct QuestionList: Codable {
    var data: [Question]
    
    // Append new Question object to data [Question] list.
    // This is used in case we run out of questions we allow
    // for new Question objects to be created and appended
    mutating func append(_ question: Question) {
        self.data.append(question)
    }
    
    // Randomize the list
    // This is used when the game starts/ends so that
    // the user cannot anticipate questions
    mutating func randomizeList() {
        data.shuffle()
        print("Question data shuffled...")
    }

}
