//
//  DetailHeaderCollectionReusableView.swift
//  MovieRoomApp
//
//  Created by Vasif Mehdi on 01.10.22.
//

import UIKit
import WebKit

class DetailHeaderCollectionReusableView: UICollectionReusableView, WKUIDelegate {
    
    // MARK: Variables
    
    var viewModel = DetailViewModel()
    
    var variable = HomePageController()
    
    var viewm = HeaderCollectionReusableView()
    
    var categorySelectionCallBack: ((String)->())?
    
    var selectionIdCallBack: ((Int)->())?

    var webView1: WKWebView!
    
    // MARK: IBOutlets
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var bookmarkIcon: UIButton!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var genresCollectionView: UICollectionView!
    @IBOutlet weak var descriptinLabelItself: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
     func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView1 = WKWebView(frame: .zero, configuration: webConfiguration)
        webView1.uiDelegate = self
        webView = webView1
    }
    
    func values(){
        movieName.text = viewModel.moviesDetails?.originalTitle
    }
    
    override func layoutSubviews() {
        genresCollectionView.register(UINib(nibName: "GenresCell", bundle: nil), forCellWithReuseIdentifier: "GenresCell")
    }
    
    func config() {
        configurationViewModel()
    }

    private func configurationViewModel() {
        showLoader()
//        viewModel.moviesCasts()
        viewModel.errorCallback = { message in
            self.dismissLoader()
            self.showAlert(message: message) {}
        }

        viewModel.successCallback = {
            self.dismissLoader()
            self.genresCollectionView.reloadData()
        }
    }
    
}

extension DetailHeaderCollectionReusableView : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.moviesDetails?.genres.count ?? 0
//        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenresCell", for: indexPath) as! GenresCell
        cell.genresLabel.text = viewModel.moviesDetails?.genres[indexPath.row].name
        
        return cell
    }
    
}
