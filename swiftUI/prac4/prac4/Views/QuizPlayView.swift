//
//  QuizPlayView.swift
//  prac4
//
//  Created by b016 DIT UPM on 17/11/22.
//

import SwiftUI

struct QuizPlayView: View {
    var quizItem : QuizItem

    @State var answer: String = ""
    @State var showAlert = false
    @Environment(\.horizontalSizeClass) var hsc
    @EnvironmentObject var scoresModel: ScoresModel
    
    var body: some View {
        VStack {
            if hsc == .compact {
                VStack {
                    title
                    solution
                    attachment
                    footer
                }
            } else {
                HStack {
                    title
                    solution
                    attachment
                    footer
                }
            }
        }
        .navigationBarTitle("Jugando")
    }
    
    private var title: some View {
        Text(quizItem.question)
            .fontWeight(.heavy)
            .font(.largeTitle)
    }
    
    private var solution: some View{
        VStack{
            TextField("Respuesta", text: $answer)
                .onSubmit {
                    let r1 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    let r2 = quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if r1 == r2 {
                        scoresModel.add(answer: answer, quiz: quizItem)
                        print("ok")
                    }
                    showAlert = true
                }
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal)
            
            Button("Comprobar") {
                let r1 = answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                let r2 = quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                if r1 == r2 {
                    scoresModel.add(answer: answer, quiz: quizItem)
                    print("ok")
                }
                showAlert = true
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Resultado"),
                  message: Text(answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == quizItem.answer.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) ? "Bien" : "Mal"),
                  dismissButton: .default(Text("ok"))
            )
        }
    }
    
    private var attachment: some View {
        GeometryReader { g in
            MyAsyncImage(url: quizItem.attachment?.url)
                .scaledToFill()
                .frame(width: g.size.width, height: g.size.height, alignment: .center)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .contentShape(RoundedRectangle(cornerRadius: 10)) //importante para los giros de pantalla
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2))
                .saturation(self.showAlert ? 0.1 : 1)
                .animation(.easeInOut, value: self.showAlert)
        }
        .padding()
    }
    
    private var footer: some View {
        HStack {
            Text("Puntos = \(scoresModel.acertadas.count)")
                .foregroundColor(.green)
            Text(quizItem.author?.username ?? "Anónimo")
                .font(.callout)
            MyAsyncImage(url: quizItem.author?.photo?.url)
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .shadow(radius: 15)
            Image(quizItem.favourite ? "estrellaDorada" : "estrellaGris")
                .scaledToFill()
                .frame(width: 30, height: 30, alignment: .center)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.black, lineWidth: 1))
                .shadow(radius: 15)
        }
    }
                         
}

struct QuizPlayView_Previews: PreviewProvider {
                    
    static var qm: QuizzesModel = {
        var qm = QuizzesModel()
        qm.load()
        return qm
    }()
                    
    static var previews: some View {
        QuizPlayView(quizItem: qm.quizzes[0])
            .environmentObject(ScoresModel())
    }
}
