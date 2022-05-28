//
//  CameraView.swift
//  WellFed
//
//  Created by Pall David on 28.05.2022.
//

import Foundation
import UIKit
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = UIImagePickerController
    
    var imageCreated: ((UIImage) -> Void)?
    
    func makeUIViewController(context: Context) -> UIViewControllerType {
        let viewController = UIViewControllerType()
        viewController.delegate = context.coordinator
        viewController.sourceType = .camera
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> CameraView.Coordinator {
        return Coordinator(self, imageCreated: { image in
            imageCreated?(image)
        })
    }
}

extension CameraView {
    class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: CameraView
        var imageCreated: ((UIImage) -> Void)?
        
        init(_ parent: CameraView, imageCreated: ((UIImage) -> Void)?) {
            self.parent = parent
            self.imageCreated = imageCreated
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            print("Cancel pressed")
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                imageCreated?(image)
            }
        }
    }
}
