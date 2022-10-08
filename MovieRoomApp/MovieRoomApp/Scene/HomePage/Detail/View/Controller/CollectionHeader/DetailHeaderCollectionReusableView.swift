//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import WebKit

class DetailHeaderCollectionReusableView: UICollectionReusableView, WKUIDelegate {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkIcon: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptinLabelItself: UILabel!
    
    @IBOutlet weak var view: UIView!
    
    // MARK: Variables
    
    var variable = HomePageController()
        
    var categorySelectionCallBack: ((String)->())?
    
    var selectionIdCallBack: ((Int)->())?
    
    var data: Detail?
    
    func viewDidAppear(animated: Bool) {
        webView = WKWebView()
        view = webView
        let request = NSURLRequest(URL: NSURL(string: data?.posterPath))
        webView.loadRequest(request)
    }
    
    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
    func config(data: Detail?) {
        self.data = data
        movieName.text = data?.originalTitle
        starImage.image = UIImage(named: "Star")
        descriptinLabelItself.text = "Description"
        descriptionLabel.text = data?.overview
        genresCollectionView.reloadData()
        let a = data?.voteAverage ?? 0
        let y = Double(round(10 * a) / 10)
        imdbLabel.text = "\(y)/10 IMDb"
    }
}

extension DetailHeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data?.genres?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCell
        cell.genresLabel.text = data?.genres?[indexPath.row].name
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width / 4 - 10, height: 28)
    }
}
