//
//  MeView.swift
//  HotProspects
//
//  Created by Eric Liu on 12/3/20.
//

import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymous"
    @State private var emailAddress = "you@yoursite.com"
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()

    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                    .padding(.horizontal)
                
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                    .padding([.horizontal, .bottom])
                
                Image(uiImage: generateQRCode(from:"\(name)\n\(emailAddress)"))
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                
                Spacer()
            }
            .navigationBarTitle("Your code")
        }
    }
    
    func generateQRCode(from string: String) -> UIImage {
        let data = Data(string.utf8) // converting data to string
        filter.setValue(data, forKey: "inputMessage") // gives filter input data
        // unwraps filter output image (CIImage)
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                // creates a cgimage, and then turns it into an UIImage.
                // CIImage -> CGImage -> UIImage
                return UIImage(cgImage: cgimg)
            }
        }
        // if anythign fails we'll return default symbol, and if that doesn't work, we will return UIImage.
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
