//
//  MovieViewController.swift
//  movie
//
//  Created by Taewon Yoon on 2023/06/27.
//

import UIKit

class MovieViewController: UITableViewController {
    
    var mov: [Show] = []
    var movieManager = MovieManager()
    
    override func viewDidLoad() {
        print("이건")
        super.viewDidLoad()
        print("이건")
        tableView.register(UINib(nibName: "MovieViewCell", bundle: nil), forCellReuseIdentifier: "ori")
        tableView.delegate = self
        tableView.dataSource = self
        movieManager.delegate = self
        movieManager.fetchMovie(movieName: "꽃")
        
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return mov.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ori", for: indexPath) as! MovieViewCell
        cell.movieTitle.text = mov[indexPath.row].show.name
        if let average = mov[indexPath.row].show.rating.average {
            cell.movieRate.text! += String(describing: average)
        } else {
            cell.movieRate.text = "평점:정보없음"
        }
        
        let sum = removeHTMLTags(from: mov[indexPath.row].show.summary!)
        cell.movieSummery.text = sum
        
        if let url = URL(string: mov[indexPath.row].show.image.medium){
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error == nil {
                    if let data = try? Data(contentsOf: url){
                        if let image = UIImage(data: data){
                            DispatchQueue.main.async {
                                cell.movieImage.image = image
                            }
                        }
                    }
                } else {
                    print("어 왜 여기가 안돼지?!!?!?ㅣㅏㅓㅣ라언럔ㅇ런애럼ㅇ낼")
                }
            }
            task.resume()
        }
                
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "no", sender: mov[indexPath.row].show.url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let secondView = segue.destination as! WebViewController
        let object = sender as! String
        secondView.http = object
    }
    
}

extension MovieViewController: MovieManagerDelegate {
    func didUpdateMovie(_ movieManager: MovieManager, movie: [Show]) {
        DispatchQueue.main.async {
            self.mov = movie
            for i in self.mov {
                print(i.show.name)
            }
            self.tableView.reloadData()
        }
    }
    
}

extension MovieViewController {
    func removeHTMLTags(from htmlString: String) -> String {
        let regex = try! NSRegularExpression(pattern: "<[^>]+>")
        let range = NSRange(location: 0, length: htmlString.utf16.count)
        let plainText = regex.stringByReplacingMatches(in: htmlString, range: range, withTemplate: "")
        return plainText
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        movieManager.fetchMovie(movieName: searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            movieManager.fetchMovie(movieName: "")
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
            
        }
    }
}
