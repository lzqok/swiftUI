//
//  ContentView.swift
//  TestSwiftUI
//
//  Created by 柳宗青 on 2022/5/11.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @Published
    @State private var showingImagePicker = false
    var body: some View {
        VStack {
            Text("Hello, world!").font(.title).foregroundColor(.red)
                .padding()
            Button("Select Image"){
                self.showingImagePicker = true
            }.sheet(isPresented: $showingImagePicker, content: {
                FirstVCUI(text: "VCTITLE")
            })
            MapView()
        }
        
    }
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 34.011_286, longitude: 116.166_868), latitudinalMeters: 0.2, longitudinalMeters: 0.2)
    
    var body: some View {
        Map(coordinateRegion: $region)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImagePicker:UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.modalPresentationStyle = .fullScreen
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    typealias UIViewControllerType = UIImagePickerController
}

struct FirstVCUI:UIViewControllerRepresentable {
    var text = ""
    typealias UIViewControllerType = CustomPageVC
    func makeUIViewController(context: Context) -> CustomPageVC {
        let firstVC = CustomPageVC()
//        firstVC.text = text
        return firstVC
    }
    
    func updateUIViewController(_ uiViewController: CustomPageVC, context: Context) {
//        uiViewController.text = text
    }
    
}
