//
//  SettingsScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI

struct SettingsView: View {

    @State var selectionOrder = Privacy.modified
    @State var selectionBool = PrivacyBool.false
    @State var showingAlert = false
    @State var showingAlert2 = false
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 15) {
                HStack {
                    
                    Button {
                        self.showingAlert = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingAlert) {
                        let title = ""
                        let message = "Order the result set by a field or fields.   Add a - to the value sort in descending order. Multiple values are given priority in the order in which they are passed."
                        return Alert(title: Text("\(title)"), message: Text("\(message)"))
                    }
                    
                    Text("Order by:")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                    Menu {
                        Picker(selection: $selectionOrder) {
                            ForEach(Privacy.allCases) { value in
                                Text(value.rawValue)
                                    .tag(value)
                            }
                        } label: {
                        }
                    } label: {
                        HStack{
                            Spacer()
                            Text(selectionOrder.rawValue)
                                .foregroundColor(.red)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.red))
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                    }.id(selectionOrder)
                }
                
                HStack{
                    
                    Button {
                        self.showingAlert2 = true
                    } label: {
                        Image(systemName: "info.circle")
                            .resizable()
                            .frame(width: 20 , height: 20)
                            .foregroundColor(.red)
                    }
                    .alert(isPresented: $showingAlert2) {
                        let title = ""
                        let message = "Ascending"
                        return Alert(title: Text("\(title)"), message: Text("\(message)"))
                    }
                    
                    Text("Ascending:")
                        .font(.system(size: 25))
                        .fontWeight(.semibold)
                    Menu {
                        Picker(selection: $selectionBool) {
                            ForEach(PrivacyBool.allCases) { value in
                                Text(value.rawValue)
                                    .tag(value)
                            }
                        } label: {
                        }
                    } label: {
                        HStack{
                            Spacer()
                            Text(selectionBool.rawValue)
                                .foregroundColor(.red)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                            Image(systemName: "chevron.down")
                                .foregroundColor(.red)
                            Spacer()
                        }
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.red))
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                    }.id(selectionBool)
                    
                }
                Spacer()
            }
            .padding(.all)
            .navigationBarTitle("Settings",displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
