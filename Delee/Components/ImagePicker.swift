//
//  Untitled.swift
//  Delee
//
//  Created by Шабнам Шарипова on 22/10/26.
//

import SwiftUI
import UIKit

struct ImagePicker :  UIViewControllerRepresentable{
    @Binding var image:UIImage?
    @Environment(\.dismiss) private var dismiss
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = context.coordinator
        return picker
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent:self)
    }
    class Coordinator:NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        let parent:ImagePicker
        init(parent: ImagePicker) {
            self.parent = parent
        }
        func imagePickerController(_ picker:UIImagePickerController,
                                   didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey:Any]){
            if let uiImage = info[.originalImage] as? UIImage{
                parent.image = uiImage
            }
            parent.dismiss()
        }
    }
 
}
