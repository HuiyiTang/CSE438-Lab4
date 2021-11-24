//
//  FavoriteViewController.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 10/26/21.
//

import UIKit

class FavoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String] = []
    var imageName: [String] = []
    var imagePath: [String] = []
    var overview: [String] = []
    var releaseTime: [String] = []
    var score: [String] = []
    var vote: [String] = []
    let defaults = UserDefaults.standard
    @IBOutlet weak var tableView: UITableView!
    
    struct APIResults:Decodable {
        let page: Int
        let total_results: Int
        let total_pages: Int
        let results: [Movie]
    }
    struct Movie: Decodable {
        let id: Int!
        let poster_path: String?
        let title: String
        let release_date: String?
        let vote_average: Double
        let overview: String
        let vote_count:Int!
    }
    
    @IBAction func cleanAll(_ sender: Any) {
        imageName = defaults.object(forKey: "imageName") as? [String] ?? [String]()
        imagePath = defaults.object(forKey: "imagePath") as? [String] ?? [String]()
        overview = defaults.object(forKey: "overview") as? [String] ?? [String]()
        releaseTime = defaults.object(forKey: "time") as? [String] ?? [String]()
        score = defaults.object(forKey: "score") as? [String] ?? [String]()
        vote = defaults.object(forKey: "vote") as? [String] ?? [String]()
        imageName = []
        imagePath = []
        overview = []
        releaseTime = []
        score = []
        vote = []
        defaults.set(imageName, forKey: "imageName")
        defaults.set(imagePath, forKey: "imagePath")
        defaults.set(overview, forKey: "overview")
        defaults.set(releaseTime, forKey: "time")
        defaults.set(score, forKey: "score")
        defaults.set(vote, forKey: "vote")
        refreshList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshList()
    }
    
    func refreshList() {
        self.fetchData()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        
        let arrayPath = defaults.object(forKey:"imagePath") as? [String] ?? [String]()
        let arrayTitle = defaults.object(forKey: "imageName") as? [String] ?? [String]()
        let arrayOverview = defaults.object(forKey: "overview") as? [String] ?? [String]()
        let arrayReleaseTime = defaults.object(forKey: "time") as? [String] ?? [String]()
        let arrayScore = defaults.object(forKey: "score") as? [String] ?? [String]()
        let arrayVote = defaults.object(forKey: "vote") as? [String] ?? [String]()
        
        detailedVC.imageName = arrayTitle[indexPath.row]
        detailedVC.releaseTime = arrayReleaseTime[indexPath.row]
        detailedVC.imagePath = arrayPath[indexPath.row]
        detailedVC.score = Double(arrayScore[indexPath.row])
        detailedVC.overview = arrayOverview[indexPath.row]
        detailedVC.voteCount = Int(arrayVote[indexPath.row])
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        cell.textLabel?.text = data[indexPath.row]
        
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Favorite List"
        
        setupTableView()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            imageName = defaults.object(forKey: "imageName") as? [String] ?? [String]()
            imagePath = defaults.object(forKey: "imagePath") as? [String] ?? [String]()
            overview = defaults.object(forKey: "overview") as? [String] ?? [String]()
            releaseTime = defaults.object(forKey: "time") as? [String] ?? [String]()
            score = defaults.object(forKey: "score") as? [String] ?? [String]()
            vote = defaults.object(forKey: "vote") as? [String] ?? [String]()
            imageName.remove(at: indexPath.row)
            imagePath.remove(at: indexPath.row)
            overview.remove(at: indexPath.row)
            releaseTime.remove(at: indexPath.row)
            score.remove(at: indexPath.row)
            vote.remove(at: indexPath.row)
            defaults.set(imageName, forKey: "imageName")
            defaults.set(imagePath, forKey: "imagePath")
            defaults.set(overview, forKey: "overview")
            defaults.set(releaseTime, forKey: "time")
            defaults.set(score, forKey: "score")
            defaults.set(vote, forKey: "vote")
            refreshList()
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
    }
    
    func fetchData() {
        data = []
        imageName = defaults.object(forKey: "imageName") as? [String] ?? [String]()
        
        for fav in imageName {
            data.append(fav)
        }
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
