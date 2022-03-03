//
//  ContentView.swift
//  AppendArraySw
//
//  Created by Elliot Knight on 03/03/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var addPlayerNumber = ""
    @State private var addPlayer = ""
    @State private var players = [Player]()
    
    @FocusState var isInputActive: Bool
    var body: some View {
        NavigationView {
            List {
                Section {
                    TextField("Add a player", text: $addPlayer)
                        .focused($isInputActive)
                    TextField("Number player", text: $addPlayerNumber)
                        .keyboardType(.decimalPad)
                        .focused($isInputActive)
                    Button(action: {
                        self.addPayer(name: addPlayer, number: addPlayerNumber)
                    }, label: {
                        Text("Add player")
                            .buttonStyle(.bordered)
                    })
                }
                Section {
                    ForEach(topPlayers) { topPlayer in
                        HStack {
                            Text(topPlayer.name)
                                .font(.headline)
                            Text(topPlayer.number)
                                .foregroundColor(.red)
                        }
                    }
                    .onDelete(perform: deletPlayer)
                    .onMove(perform: moveTopPLayer)
                }
                Section {
                    ForEach(players) { player in
                        HStack {
                            Text(player.name)
                            Text(player.number)
                                .foregroundColor(.green)
                        }.font(.title2.bold())
                    }
                    .onMove(perform: movePlayer)
                    .onDelete(perform: deletPlayer)
                }
            }
            .navigationTitle("BasketBall players")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                
                ToolbarItemGroup(placement: .keyboard) {
                    Button("Done") {
                    isInputActive = false
                    }
                    Spacer()
                    EditButton()
                }
            }
        }
    }
    
    func addPayer(name: String, number: String) {
        if addPlayer.count != 0 && addPlayerNumber.count != 0  {
            self.players.append(Player(name: addPlayer, number: addPlayerNumber))
            addPlayer = ""
            addPlayerNumber = ""
        } else {
            print("fail")
        }
    }
    
    func deletPlayer(at offsets: IndexSet) {
        topPlayers.remove(atOffsets: offsets)
    }
    
    func movePlayer(from source: IndexSet, to destination: Int) {
        players.move(fromOffsets: source, toOffset: destination)
    }
    
    func moveTopPLayer(from source: IndexSet, to destination: Int) {
        topPlayers.move(fromOffsets: source, toOffset: destination)
    }
    
    func deletBestPlayer(at offsets: IndexSet) {
        players.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Player: Hashable, Identifiable {
    var id = UUID()
    let name: String
    var number: String
}

var topPlayers: [Player] = [
    Player(name: "Kobe", number: "23"),
    Player(name: "Shaq", number: "22")
]
