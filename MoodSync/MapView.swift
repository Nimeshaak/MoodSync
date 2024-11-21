import SwiftUI
import MapKit
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    @Published var location: CLLocation?
    @Published var region: MKCoordinateRegion
    
    override init() {
        self.region = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // Default to San Francisco
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let newLocation = locations.last else { return }
        self.location = newLocation
        self.region = MKCoordinateRegion(
            center: newLocation.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}

struct MapView: View {
    @ObservedObject var locationManager: LocationManager
    @State private var hospitals: [MKMapItem] = []
    @State private var userTrackingMode: MapUserTrackingMode = .follow // This is the state variable
    
    var body: some View {
        VStack {
            Map(coordinateRegion: $locationManager.region, showsUserLocation: true, userTrackingMode: $userTrackingMode)
                .edgesIgnoringSafeArea(.all)
            
            Button("Search Hospitals") {
                searchNearbyHospitals()
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
    
    private func searchNearbyHospitals() {
        guard let location = locationManager.location else { return }
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "hospital"
        request.region = MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            if let error = error {
                print("Error searching for hospitals: \(error.localizedDescription)")
                return
            }
            
            if let response = response {
                self.hospitals = response.mapItems
                // Add annotations to the map (optional)
            }
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(locationManager: LocationManager())
    }
}
