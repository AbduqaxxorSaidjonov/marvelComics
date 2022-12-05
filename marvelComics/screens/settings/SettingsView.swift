//
//  SettingsScreen.swift
//  marvelComics
//
//  Created by Abduqaxxor on 3/10/22.
//

import SwiftUI

struct SettingsView: View {
    
    @Binding var tabSelection: Int
    @State var showingAlert = false
    @State var showingAlert2 = false
    @State var isExpanded = false
    @State var isExpandedBool = false
    @State var selectionBool = UserDefaults.standard.bool(forKey: "ascending")
    @State var selectionOrder = UserDefaults.standard.string(forKey: "order")
    @Environment(\.managedObjectContext) var moc
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading , spacing: 15) {
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
                    
                    DisclosureGroup(selectionOrder ?? "modified", isExpanded: $isExpanded) {
                        VStack {
                            ForEach(Privacy.allCases , id: \.self) {order in
                                HStack {
                                    Text("\(order.rawValue)")
                                        .font(.system(size: 20 , weight: .semibold))
                                        .padding(.all , 5)
                                        .onTapGesture {
                                            self.selectionOrder = order.rawValue
                                            withAnimation {
                                                self.isExpanded.toggle()
                                            }
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .accentColor(.red)
                    .font(.system(size: 20 , weight: .semibold))
                    .foregroundColor(.red)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.red))
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                HStack {
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
                    
                    DisclosureGroup(selectionBool ? "true" : "false", isExpanded: $isExpandedBool) {
                        VStack {
                            ForEach(PrivacyBool.allCases , id: \.self){ selection in
                                HStack {
                                    Text("\(selection.rawValue)")
                                        .font(.system(size: 20 , weight: .semibold))
                                        .padding(.all , 5)
                                        .onTapGesture {
                                            if selection.rawValue == "true" {
                                                self.selectionBool = true
                                            } else {
                                                self.selectionBool = false
                                            }
                                            withAnimation {
                                                self.isExpandedBool.toggle()
                                            }
                                        }
                                    Spacer()
                                }
                            }
                        }
                    }
                    .accentColor(.red)
                    .font(.system(size: 20 , weight: .semibold))
                    .foregroundColor(.red)
                    .padding(8)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.red))
                    .background(.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Button {
                    PersistenceController.shared.deleteObject(context: moc)
                    PersistenceController.shared.deleteUserdefaults()
                    viewModel.saveSettings(order: selectionOrder ?? "modified", ascending: selectionBool)
                    self.tabSelection = 0
                } label: {
                    Text("Save")
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .font(.system(size: 20))
                        .padding(15)
                        .frame(maxWidth: .infinity)
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 3).foregroundColor(.red))
                        .background(.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Spacer()
            }
            .padding(.all)
            .navigationBarTitle("Settings", displayMode: .inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(tabSelection: .constant(1))
    }
}
