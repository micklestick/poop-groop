//
//  InfoView.swift
//  KnightsMaps
//
//  Created by Sean Hall on 3/24/19.
//  Copyright © 2019 Alec. All rights reserved.
//

import UIKit

class InfoView: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.testLabel.text = "true"
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
