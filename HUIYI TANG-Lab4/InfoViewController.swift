//
//  InfoViewController.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 10/30/21.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Info"
        
        let theInfoFrame1 = CGRect(x: 120, y: 250, width: 200, height: 40)
        let infoView1 = UILabel(frame: theInfoFrame1)
        infoView1.textAlignment = .left
        infoView1.text = "POWERED BY"
        infoView1.font = infoView1.font?.withSize(25)
        view.addSubview(infoView1)
        
        let theInfoFrame2 = CGRect(x: 120, y: 300, width: 200, height: 40)
        let infoView2 = UILabel(frame: theInfoFrame2)
        infoView2.textAlignment = .left
        infoView2.text = "THE"
        infoView2.font = UIFont.boldSystemFont(ofSize: 50)
        view.addSubview(infoView2)
        
        let theInfoFrame3 = CGRect(x: 120, y: 350, width: 200, height: 40)
        let infoView3 = UILabel(frame: theInfoFrame3)
        infoView3.textAlignment = .left
        infoView3.text = "MOVIE"
        infoView3.font = UIFont.boldSystemFont(ofSize: 50)
        view.addSubview(infoView3)
        
        let theInfoFrame4 = CGRect(x: 120, y: 400, width: 200, height: 40)
        let infoView4 = UILabel(frame: theInfoFrame4)
        infoView4.textAlignment = .left
        infoView4.text = "DB"
        infoView4.font = UIFont.boldSystemFont(ofSize: 50)
        view.addSubview(infoView4)
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
