//
//  ScoresModel.swift
//  prac4
//
//  Created by b016 DIT UPM on 17/11/22.
//

import Foundation

class ScoresModel: ObservableObject{
    
    @Published private(set) var acertadas: Set<Int> = []
    
    func add(answer: String, quiz: QuizItem){
        let r1 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let r2 = quiz.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        if r1 == r2, !acertadas.contains(quiz.id){
            acertadas.insert(quiz.id)
        }
    }
}
