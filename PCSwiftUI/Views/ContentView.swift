//
//  ContentView.swift
//  PCSwiftUI
//
//  Created by Yuki Okudera on 2022/01/01.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var store: RepositoryListStore = .shared
    private var actionCreator: RepositoryListActionCreator

    init(actionCreator: RepositoryListActionCreator = .init()) {
        self.actionCreator = actionCreator
    }

    var body: some View {
        NavigationView {
            List(store.repositories) { repository in
                RepositoryListRow(repository: repository)
            }
            .alert(isPresented: $store.isErrorShown) { () -> Alert in
                Alert(title: Text("Error"), message: Text(store.errorMessage))
            }
            .navigationBarTitle(Text("Repositories"))
        }
        .onAppear(perform: { self.actionCreator.onAppear() })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
