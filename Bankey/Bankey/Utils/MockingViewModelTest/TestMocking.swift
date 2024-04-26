//
//  TestMocking.swift
//  Bankey
//
//  Created by Nikos Galinos on 26/4/24.
//

import Foundation
import SwiftUI

// Create ApiServices classes - protocols -mocks
protocol ApiServicesProtocol {

}
class ApiService: ApiServicesProtocol {
}

class MockApiService: ApiServicesProtocol {
}

// MARK: - 1st way (ViewModel protocol with encapsulated ObservableObject)
class StateViewModel: ObservableObject {
    @Published var array: [String] = []
}

protocol ViewModelProtocol {
    var state: StateViewModel { get }
}

// this is the real ViewModel with a Dependency on the call service
class ViewModel: ViewModelProtocol {
    var state: StateViewModel
    let apiService: ApiServicesProtocol
    init(state: StateViewModel = StateViewModel(),
         apiService: ApiServicesProtocol = ApiService() ) {
        self.state = state
        self.apiService = apiService
    }
}
// We can create a MockViewModel explicitly for mocking our view
class MockViewModel: ViewModelProtocol {
    var state: StateViewModel
    init(state: StateViewModel = StateViewModel()) {
        self.state = state
    }
}
// Demo View
struct DemoView: View {
    @ObservedObject var state: StateViewModel
    // Gains we can Mock the ViewModel without depending on mock Services
    init(viewModel: ViewModelProtocol = ViewModel()){
        self.state = viewModel.state
    }
    var body: some View {
        Text("")
    }
}
#Preview {
    DemoView(viewModel: MockViewModel())
}

// MARK: - 2nd way (ViewModel with Dependency on the Services without ViewModel Protocol)
class ViewModel2: ObservableObject {
    @Published var array: [String] = []
    // ... viewmodel properties and logic
    var apiService: ApiServicesProtocol
    init(apiService: ApiServicesProtocol = ApiService()){
        self.apiService = ApiService()
    }
}

// Demo View (there is no DI on the view side)
struct DemoView2: View {
    @StateObject var viewModel = ViewModel2()
    var body: some View {
        Text("")
    }
}

#Preview {
    DemoView2(viewModel: ViewModel2(apiService: MockApiService()))
}


