//
//  YearViewController.swift
//  HUIYI TANG-Lab4
//
//  Created by Huiyi Tang on 11/2/21.
//

import UIKit

class YearViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,  UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
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
    
    var movies: [Movie] = []
    var theImageCache: [Int:UIImage] = [:]
    let defaults = UserDefaults.standard
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.title = "Upcoming Movie"
        
        setupCollectionView()
        
        self.collectionView.reloadData()
        fetchUpcomingDataForCollectionView()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedVC = DetailedViewController()
        detailedVC.imageName = movies[indexPath.row].title
        detailedVC.releaseTime = movies[indexPath.row].release_date
        detailedVC.imagePath = movies[indexPath.row].poster_path
        detailedVC.score =  movies[indexPath.row].vote_average
        detailedVC.overview = movies[indexPath.row].overview
        detailedVC.voteCount = movies[indexPath.row].vote_count
        
        navigationController?.pushViewController(detailedVC, animated: true)
    }
    
    //setupCollectionView
    func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.allowsSelection = true

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width/CGFloat(3)-10
        let height = width * 1.5
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionCell
        let index = indexPath.section * 3 + indexPath.row
        
        let width = cell.frame.width
        let height = cell.frame.height
        //image view
        let imageFrame = CGRect(x: 0, y: 0, width: width, height: height)
        let imageView = UIImageView()
        imageView.frame = imageFrame
        
        //label
        let label = UILabel()
        let labelSize: CGFloat = 40
        let labelFrame = CGRect(x: 0, y: height-labelSize, width: width, height: labelSize)
        label.frame = labelFrame
        label.textColor = UIColor.white
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        
        let item: Movie = movies[index]
        var image: UIImage? = UIImage(named: "none")
        if theImageCache[item.id] != nil {
            image = theImageCache[item.id]!
        }
        
        label.text = item.title
        imageView.image = image
        
        cell.image.image = theImageCache[movies[indexPath.row].id]
        cell.title.text = movies[indexPath.row].title
        
        cell.addSubview(imageView)
        cell.addSubview(label)
        
        return cell
    }
        
    func fetchUpcomingDataForCollectionView() {
        let urlPopular = URL(string: "https://api.themoviedb.org/3/movie/upcoming?api_key=f37970f052856742371d3453baf5bf09&language=en-US")
        let dataPopular = try! Data(contentsOf: urlPopular!)
        self.movies = try! JSONDecoder().decode(APIResults.self, from: dataPopular).results

        self.cacheImages()
        self.collectionView.reloadData()
    }
    
    //cacheImages
    func cacheImages() {
        for item in movies {
            if item.poster_path != nil {
                let id = item.id
                let url = URL(string: "https://image.tmdb.org/t/p/w500" + item.poster_path!)
                let data = try? Data(contentsOf: url!)
                let image = UIImage(data: data!)
                theImageCache[id!] = image!
            }
        }
    }
}
