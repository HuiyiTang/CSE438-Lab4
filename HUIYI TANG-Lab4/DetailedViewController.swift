//
//  DetailedViewController.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 10/23/21.
//

import UIKit

class DetailedViewController: UIViewController, UIDocumentInteractionControllerDelegate {
    
    var image: UIImage?
    var imageName: String!
    var releaseTime: String!
    var score: Double!
    var voteCount: Int!
    var imagePath: String!
    var overview: String!
    let defaults = UserDefaults.standard
    let num: Float = 0.0
    let shareView = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = imageName
        view.backgroundColor = UIColor.white
        
        //image background
        let theImageBackgroundFrame = CGRect(x: 0, y: 0, width: view.frame.width, height: 380)
        let imageBackgroundView = UIImageView(frame: theImageBackgroundFrame)
        imageBackgroundView.backgroundColor = UIColor.lightGray
        view.addSubview(imageBackgroundView)
        
        //image
        let theImageFrame = CGRect(x: 95, y: 80, width: 200, height: 300)
        let imageView = UIImageView(frame: theImageFrame)
        if imagePath != nil {
            let url = URL(string: "https://image.tmdb.org/t/p/original" + imagePath)
            let data = try? Data(contentsOf: url!)
            let image = UIImage(data:data!)
            imageView.image = image
            self.image = image
        }
        view.addSubview(imageView)
        
        //overview
        let theOverviewFrame = CGRect(x: view.frame.midX - 165, y: 400, width: 340, height: 80)
        let overviewView = UITextView(frame: theOverviewFrame)
        if overview != nil {
            overviewView.text = overview
        }
        else {
            overviewView.text = "Overview not existed"
        }
        overviewView.font = overviewView.font?.withSize(16)
        view.addSubview(overviewView)
        
        //release time
        let theTimeFrame = CGRect(x: 70, y: 520, width: 250, height: 17)
        let timeView = UILabel(frame: theTimeFrame)
        if releaseTime != nil {
            timeView.text = "Releasing Time: " + releaseTime
        }
        else {
            timeView.text = "Releasing Time not existed"
        }
        timeView.textAlignment = .center
        view.addSubview(timeView)
        
        //score
        let theSocreFrame = CGRect(x: 125, y: 570, width: 150, height: 17)
        let scoreView = UILabel(frame: theSocreFrame)
        if score != nil {
            scoreView.text = "Score: " + String(score)
        }
        else {
            scoreView.text = "Score not existed"
        }
        scoreView.textAlignment = .center
        view.addSubview(scoreView)
        
        //vote count
        let theCountFrame = CGRect(x: 120, y: 620, width: 150, height: 17)
        let countView = UILabel(frame: theCountFrame)
        if voteCount != nil {
            countView.text = "Vote Count: " + String(voteCount)
        }
        else {
            countView.text = "Vote Count not existed"
        }
        countView.textAlignment = .center
        view.addSubview(countView)
        
        //favotite btn
        let theFavoriteFrame = CGRect(x: 26, y: 680, width: 140, height: 22)
        let favoriteView = UIButton(frame: theFavoriteFrame)
        favoriteView.setTitle("Add to Favorites", for: .normal)
        favoriteView.setTitleColor(UIColor.blue, for: .normal)
        favoriteView.layer.borderWidth = 1
        favoriteView.layer.borderColor = UIColor.blue.cgColor
        favoriteView.layer.cornerRadius = 10
        favoriteView.addTarget(self, action: #selector(addFav(_:)), for: .touchUpInside)
        view.addSubview(favoriteView)
        
        //share btn
        let theShareFrame = CGRect(x: 186, y: 680, width: 60, height: 22)
        let shareView = UIButton(frame: theShareFrame)
        shareView.setTitle("Share", for: .normal)
        shareView.setTitleColor(UIColor.blue, for: .normal)
        shareView.layer.borderWidth = 1
        shareView.layer.borderColor = UIColor.blue.cgColor
        shareView.layer.cornerRadius = 10
        shareView.addTarget(self, action: #selector(share(_:)), for: .touchUpInside)
        view.addSubview(shareView)
        
        //download btn
        let theDownloadFrame = CGRect(x: 266, y: 680, width: 100, height: 22)
        let downloadView = UIButton(frame: theDownloadFrame)
        downloadView.setTitle("Download", for: .normal)
        downloadView.setTitleColor(UIColor.blue, for: .normal)
        downloadView.layer.borderWidth = 1
        downloadView.layer.borderColor = UIColor.blue.cgColor
        downloadView.layer.cornerRadius = 10
        downloadView.addTarget(self, action: #selector(imageSaved(_:)), for: .touchUpInside)
        view.addSubview(downloadView)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc private func addFav(_ sender: UIButton) {
        var arrayPath = defaults.object(forKey: "imagePath") as? [String] ?? [String]()
        arrayPath.append(imagePath)
        defaults.set(arrayPath, forKey: "imagePath")
        
        var arrayTitle = defaults.object(forKey: "imageName") as? [String] ?? [String]()
        arrayTitle.append(imageName)
        defaults.set(arrayTitle, forKey: "imageName")
        
        var arrayOverview = defaults.object(forKey: "overview") as? [String] ?? [String]()
        arrayOverview.append(overview)
        defaults.set(arrayOverview, forKey: "overview")
        
        var arrayReleaseTime = defaults.object(forKey: "time") as? [String] ?? [String]()
        arrayReleaseTime.append(releaseTime)
        defaults.set(arrayReleaseTime, forKey: "time")
        
        var arrayScore = defaults.object(forKey: "score") as? [String] ?? [String]()
        arrayScore.append(String(score))
        defaults.set(arrayScore, forKey: "score")
        
        var arrayVote = defaults.object(forKey: "vote") as? [String] ?? [String]()
        arrayVote.append(String(voteCount))
        defaults.set(arrayVote, forKey: "vote")
        
        alert(title: "Favorite", message: "This movie has been added into your favorite list!")
    }

    func alert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func share(_ sender: UIButton) {
        let theInfo = imageName! + overview! + releaseTime! + String(score!) + String(voteCount!)
        
        let activityVC = UIActivityViewController(activityItems: [theInfo], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view

        self.present(activityVC, animated: true, completion: nil)
        //Cite: https://www.youtube.com/watch?v=do1EF3CoO8M
    }
    
    @objc func errorMsg(theImage: UIImage!, didFinishSavingWithError error: NSError?, contextInfo: AnyObject?) {
        if (error != nil) {
            print("error")
        }
    }
    
    @objc private func imageSaved(_ sender: UIButton) {
        let theImage = UIImage(view: view!)
        
        UIImageWriteToSavedPhotosAlbum(theImage, self, #selector(errorMsg(theImage:didFinishSavingWithError:contextInfo:)), nil)
        alert(title: "Saved", message: "This poster has been saved to Photo Library!")
    }
}

extension UIImage{
    convenience init(view: UIView) {

    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
    view.drawHierarchy(in: view.bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    self.init(cgImage: (image?.cgImage)!)
    /*
         Cite:https://stackoverflow.com/questions/40980863/how-can-i-save-a-picture-in-the-photo-library-swift?rq=1
    */
  }
}

