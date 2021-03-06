//
//  AddJournalViewController.swift
//  Jonrnal
//
//  Created by 戴其安 on 2017/8/4.
//  Copyright © 2017年 戴其安. All rights reserved.
//

import UIKit
import MobileCoreServices
extension UIImageView {
    func addGradientLayer(frame: CGRect) {
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = [UIColor(displayP3Red: 67/255, green: 87/255, blue: 97/255, alpha: 1).cgColor, UIColor(displayP3Red: 26/255, green: 34/255, blue: 38/255, alpha: 1).cgColor]
        gradient.locations = [0.0, 0.5]
        gradient.opacity = 0.85
        self.layer.addSublayer(gradient)
    }
}
class AddJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var articleContentTextView: UITextView!
    var articleTitle: String?
    let imagePickerController = UIImagePickerController()
    //swiftlint:disable force_cast
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    //swiftlint:enable force_cast
    @IBAction func closeButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
        })
             }
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var gradientImageView: UIImageView!
    @IBOutlet weak var selectImageLabel: UILabel!
    @IBAction func selectPhotoAction(_ sender: UIButton) {
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        imagePickerController.mediaTypes = [kUTTypeImage as NSString as String]
        present(imagePickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        gradientImageView.isHidden = true
        selectImageLabel.isHidden = true
        articleImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        secondImageView.isHidden = true
        selectImageLabel.text = nil
        self.dismiss(animated: true, completion: nil) }
    @IBOutlet weak var saveButton: UIButton!
    @IBAction func saveButtonAction(_ sender: UIButton) {
                if articleTitleTextField.text == "" {
            print(articleContentTextView.text)
        let alertController = UIAlertController(title: "錯誤", message: "沒有標題", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            return
        })
        alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil)
            return
        }
        if articleContentTextView.text == "" {
            let alertController = UIAlertController(title: "錯誤", message: "沒有內文", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                return
            })
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil)
        return}
        if articleImageView.image == nil {
            let alertController = UIAlertController(title: "錯誤", message: "沒有圖片", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
                return
            })
            alertController.addAction(okAction)
            self.present(
                alertController,
                animated: true,
                completion: nil)
        return}
        if articleTitle != nil {
            do {
                let tasks = try self.context.fetch(ArticleCoreData.fetchRequest())
                let articles = (tasks as? [ArticleCoreData])!
                for element in articles where articleTitle == element.title {
                    if let title = articleTitleTextField.text, let content = articleContentTextView.text {
                        element.title = title
                        element.content = content
                    }
                    if let articleImage = articleImageView.image {
                        if let imageData = UIImagePNGRepresentation(articleImage) {
                            element.image = NSData(data: imageData)
                        }
                    }
                 (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                }
            } catch {}
        self.dismiss(animated: true, completion: {
        })
        return
        } else {
        let task = ArticleCoreData(context: context)
            guard let title = articleTitleTextField.text, let content = articleContentTextView.text else {return}
            task.title = title
            task.content = content
        if let articleImage = articleImageView.image, let imageData = UIImagePNGRepresentation(articleImage) {
            task.image = NSData(data: imageData)
            }
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
            self.dismiss(animated: true, completion: {
            })
}
    }
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var articleTitleTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        if articleTitle == nil {
        gradientImageView.addGradientLayer(frame: articleImageView.frame)
        articleImageView.tintColor = UIColor.white
            secondImageView.tintColor = UIColor.white } else {
        do {
            let tasks = try self.context.fetch(ArticleCoreData.fetchRequest())
            let articles = (tasks as? [ArticleCoreData])!
            for element in articles where articleTitle == element.title {
                gradientImageView.isHidden = true
                selectImageLabel.isHidden = true
                secondImageView.isHidden = true
                articleTitleTextField.text = element.title
                if let content = element.content {
                    articleContentTextView.text = content }
                if let data = element.image as Data? {
                    articleImageView.image = UIImage(data: data)}
            }
        } catch {}
        }
        saveButton.layer.shadowColor = UIColor(colorLiteralRed: 247/255, green: 174/255, blue: 163/255, alpha: 1).cgColor
        saveButton.layer.cornerRadius = 22
        saveButton.layer.shadowRadius = 10
        saveButton.layer.shadowOffset = CGSize(width: 0, height: 1)
        saveButton.layer.shadowOpacity = 0.5

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
