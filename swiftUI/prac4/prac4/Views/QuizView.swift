//
//  QuizView.swift
//  prac4
//
//  Created by b016 DIT UPM on 16/11/22.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var quizzesModel: QuizzesModel
    @EnvironmentObject var scoresModel: ScoresModel
    var body: some View {
        NavigationStack {
            List{
                ForEach(quizzesModel.quizzes) { quizItem in
                    NavigationLink {
                        QuizPlayView(quizItem: quizItem)
                    } label: {
                        QuizRow(quizItem: quizItem)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle(Text("Quiz"))
            .onAppear {
                quizzesModel.load()
            }
        }
    }
}

struct QuizView_Previews: PreviewProvider {
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
    static var previews: some View{
        QuizView()
            .environmentObject(qm)
            .environmentObject(ScoresModel())
    }
}
