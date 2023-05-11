//
//  ImageGallaryViewController.swift
//  getDataInTableView
//
//  Created by Demo 01 on 16/03/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

class ImageGallaryViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePic=UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(ImageGallaryViewController.operGallery(tapGesture: )))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
    }
    

    @objc func operGallery(tapGesture:UITapGestureRecognizer)
    {
        print("hello")
        self.setypImagePicker()
    }

}

extension ImageGallaryViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate
{
        func setypImagePicker()
        {
            if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
            {
                imagePic.sourceType = .savedPhotosAlbum
                imagePic.delegate = self
                imagePic.isEditing = true
                self.present(imagePic, animated: true, completion: nil)
            }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        imageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
