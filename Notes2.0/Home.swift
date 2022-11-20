//
//  ContentView.swift
//  Notes2.0
//
//  Created by Valentineejk on 18/11/2022.
//

import SwiftUI

struct Home: View {
    
    @State var notes = [Note]()
    @State var showAdd = false

    var body: some View {
        NavigationView {
            List(self.notes) { note in
                Text(note.note)
                    .padding()
            }
            
            .sheet(isPresented: $showAdd, onDismiss: getNotes, content: {
                AddNoteView()
            })
            .onAppear(perform: {
                getNotes()
            })
            .navigationTitle("Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        self.showAdd.toggle()
                    } label: {
                        Text("Add")
                            .foregroundColor(.black)
                    }

                }
            }

        }

    }
    
    func getNotes(){
        let url = URL(string: "https://notes-api1x.herokuapp.com/notes")!
        let task = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let data = data else { return }
            do {
                let notes = try JSONDecoder().decode([Note].self, from: data)
                self.notes = notes
            } catch  {
                print(error)
            }
        }
        task.resume()
    }
}

struct Note: Identifiable, Codable {
    var id: String { _id }
    var _id: String
    var note: String
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
