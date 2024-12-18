import SwiftUI

struct CityList: View {
    @StateObject var climaViewModel = ClimaModel()
    @State private var searchText = ""
    @State private var selectedCity: String?
    
    private var filteredCities: [String] {
        if searchText.isEmpty {
            return previewCiudades.cities
        } else {
            return previewCiudades.cities.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredCities, id: \.self) { city in
                NavigationLink(destination: CityDetails(ciudad: city, climaViewModel: climaViewModel)) {
                    CityRow(ciudad: city)
                        .accessibilityLabel("City: \(city)")
                        .accessibilityHint("Double-tap to view weather details for \(city)")
                }
                .onTapGesture {
                    selectedCity = city
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .accessibilityLabel("Search for a city")
            .accessibilityHint("Enter the city name to filter results")
            .navigationTitle("Cities")
            .accessibilityLabel("City List")
            .accessibilityHint("Navigate through the list of cities")
        } detail: {
            if let city = selectedCity {
                CityDetails(ciudad: city, climaViewModel: climaViewModel)
            } else {
                Text("Choose a city")
                    .foregroundColor(.secondary)
                    .accessibilityLabel("No city selected")
                    .accessibilityHint("Select a city from the list to view its details")
            }
        }
    }
}

struct CityList_Previews: PreviewProvider {
    static var previews: some View {
        CityList()
    }
}
