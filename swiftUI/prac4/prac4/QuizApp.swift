//
//  QuizApp.swift
//  prac4
//
//  Created by b016 DIT UPM on 15/11/22.
//

import SwiftUI

@main
struct QuizApp: App {
    
    
    @StateObject var quizzesModel: QuizzesModel = QuizzesModel()
    @StateObject var scoresModel: ScoresModel = ScoresModel()
    var body: some Scene {
        WindowGroup {
            QuizView()
                .environmentObject(quizzesModel)//QuizzesListView y sus hijas tendrán siempre el dato QuizzesModel para usarse
                .environmentObject(scoresModel)
        }
    }
}
