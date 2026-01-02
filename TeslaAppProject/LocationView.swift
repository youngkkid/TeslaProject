import SwiftUI
import MapKit

struct CarLocation: Identifiable {
    let id = UUID()
    let latitude: Double
    let longitude: Double
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

let carLocations = [CarLocation(latitude: 40.7484, longitude: -73.7484)]

struct LocationView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State private var location: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.7484, longitude: -73.7484),
            span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        )
    )
    
    var body: some View {
        ZStack {
            Map(position: $location ) {
                ForEach(carLocations) { location in
                    Annotation("", coordinate: location.coordinate) {
                        CarPin()
                    }
                }
            }
            
            CarLocationPannel()
            
            LinearGradient(gradient: Gradient(colors: [.darkGray, .clear, .clear]), startPoint: .top, endPoint: .bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .allowsHitTesting(false)
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        GeneralButton(icon: "chevron.left")
                    }
                    Spacer()
                    Button(action: {}) {
                        GeneralButton(icon: "speaker.wave.3.fill")
                    }
                }
                .padding()
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.darkGray)
        .foregroundStyle(Color.white)
        .navigationTitle("Mach Five")
        .navigationBarHidden(true)
    }
}

struct CarPin: View {
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: "car.fill")
                .frame(width: 36, height: 36, alignment: .center)
                .background(Color.fRed)
                .foregroundColor(.white)
                .clipShape(Circle())
            Text("Mach Five")
                .font(.footnote)
                .fontWeight(.medium)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .continuous))
                .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous).stroke(Color.black.opacity(0.1), lineWidth: 1))
        }
    }
}

#Preview {
    LocationView()
}

struct CarLocationPannel: View {
    var body: some View {
        VStack {
            Spacer()
            VStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("Location")
                        .font(.title2)
                        .fontWeight(.semibold)
                    CustomDivider()
                    Label("20 W 34th St, New York, NY 10001", systemImage: "location.fill")
                        .font(.footnote)
                        .opacity(0.5)
                }
                VStack(alignment: .leading, spacing: 10) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("Summon")
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("Press and hold controls to move vehicle")
                            .opacity(0.5)
                            .font(.footnote)
                    }
                        CustomDivider()
                        FullButton(text: "Go tot Target")
                        HStack {
                            FullButton(text: "Forward", icon: "arrow.up")
                            FullButton(text: "Backwards", icon: "arrow.down")
                        }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.darkGray)
            .foregroundStyle(Color.white)
        }
    }
}
