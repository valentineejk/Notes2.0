//
//  AddNoteView.swift
//  Notes2.0
//
//  Created by Valentineejk on 19/11/2022.
//

import SwiftUI

struct AddNoteView: View {
    @State var text = ""
    @Environment(\..dismiss) var dismiss
    var body: some View {
        HStack{
            TextField("Enter notes...", text: $text)
                .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                .clipped()
            
            Button {
                postNotes()
            } label: {
                Text("send")
            }
            .padding(8)

        }
        
        
    }
    
    func postNotes ( ){
        let params = ["note": text] as [String:Any]
        let url = URL(string: "https://notes-api1x.herokuapp.com/notes")!
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch let error {
            print(error)
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        let task = session.dataTask(with: request) { data, res, error in
            guard error == nil else {return}
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                }
            } catch let error {
                print(error)
            }
        }
        task.resume()
        self.text = ""
        dismiss()
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        AddNoteView()
    }
}
