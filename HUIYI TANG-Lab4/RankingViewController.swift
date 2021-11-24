//
//  RankingViewController.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 10/28/21.
//

import UIKit

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var movies: [Movie] = []
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath)
        movies.sort(by: {$0.vote_average > $1.vote_average})
        
        let index = indexPath.section + indexPath.row
        let height = cell.frame.height
        
        //label
        let label = UILabel()
        let labelFrame = CGRect(x: 0, y: 0, width: 80, height: height)
        label.frame = labelFrame
        label.textColor = UIColor.red
        label.textAlignment = .center
        label.numberOfLines = 0
        if indexPath.row<3 {
            label.font = UIFont.boldSystemFont(ofSize: 25)
        }
        else {
            label.font = UIFont.systemFont(ofSize: 15)
        }
        
        //title
        let title = UILabel()
        let titleFrame = CGRect(x: height+10, y: 0, width: 275, height: height)
        title.frame = titleFrame
        title.textColor = UIColor.black
        title.textAlignment = .left
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 13)
        
        //score
        let score = UILabel()
        let scoreFrame = CGRect(x: height+10+275+10, y: 0, width: 25, height: height)
        score.frame = scoreFrame
        score.textColor = UIColor.purple
        score.textAlignment = .left
        score.numberOfLines = 0
        score.font = UIFont.systemFont(ofSize: 15)
        
        
        let item: Movie = movies[index]
        label.text = String(indexPath.row+1)
        title.text = item.title
        score.text = String(item.vote_average)
        
        cell.addSubview(label)
        cell.addSubview(title)
        cell.addSubview(score)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        detailedVC.imageName = movies[indexPath.row].title
        detailedVC.releaseTime = movies[indexPath.row].release_date
        detailedVC.imagePath = movies[indexPath.row].poster_path
        detailedVC.score =  movies[indexPath.row].vote_average
        detailedVC.overview = movies[indexPath.row].overview
        detailedVC.voteCount = movies[indexPath.row].vote_count
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "rankingCell")
    }
    
    func fetchDataFromTableView() {
        let url = URL(string:"https://api.themoviedb.org/3/discover/movie?api_key=f37970f052856742371d3453baf5bf09&language=en-US")
        let data = try! Data(contentsOf: url!)
        self.movies = try! JSONDecoder().decode(APIResults.self, from: data).results
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Ranking"
        
        setupTableView()
        fetchDataFromTableView()
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
