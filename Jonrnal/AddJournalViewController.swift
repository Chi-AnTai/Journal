//
//  AddJournalViewController.swift
//  Jonrnal
//
//  Created by 戴其安 on 2017/8/4.
//  Copyright © 2017年 戴其安. All rights reserved.
//

import UIKit
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


class AddJournalViewController: UIViewController {
    
    @IBOutlet weak var secondImageView: UIImageView!
    
    @IBOutlet weak var ArticleImageView: UIImageView!
    
    @IBOutlet weak var articleTitleTextField: UITextField!

    @IBOutlet weak var articleContentTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ArticleImageView.addGradientLayer(frame: ArticleImageView.frame)
        ArticleImageView.tintColor = UIColor.white
        secondImageView.tintColor = UIColor.white

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
