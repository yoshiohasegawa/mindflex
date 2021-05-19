//
//  QuestionList.swift
//  Mindflex
//
//  Created by Yoshio Hasegawa on 2021/05/19.
//

import Foundation

struct QuestionList: Codable {
    var data: [Question]
    
    // Append new Question object to data [Question] list
    mutating func append(_ question: Question) {
        self.data.append(question)
    }

}
