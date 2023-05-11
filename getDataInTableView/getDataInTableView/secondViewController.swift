//
//  secondViewController.swift
//  getDataInTableView
//
//  Created by Demo 01 on 15/03/23.
//  Copyright © 2023 scs. All rights reserved.
//

import UIKit

class secondViewController: UIViewController {

    @IBOutlet weak var imgview: UIImageView!
    
    @IBOutlet weak var idlbl: UILabel!
    
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var feeslbl: UILabel!

    var course = ""
    var fees = ""
    var duration = ""
    var img = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: img)!
        if let data = try? Data(contentsOf: url)
        {
            imgview.image = UIImage(data: data)
        }
        
        idlbl.text = course
        namelbl.text = duration
        feeslbl.text = fees

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
