//
//  CountryInfoController.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

class CountryInfoController: UITableViewController, CountryInfoViewInput {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    private var countryInfo: CountryWithImages?
    lazy var countryTableView: UITableView = self.tableView
    var presenter: CountryInfoViewOutput?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = countryInfo?.images?.count ?? 0
        if pageControl.numberOfPages == 1 {
            pageControl.isHidden = true
        }
        
    }
    
    func countryDidLoad(countryInfo: CountryWithImages) {
        self.countryInfo = countryInfo
        self.tableView.reloadData()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.sizeToFit()
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.tintColor = .white
        tableView.contentInsetAdjustmentBehavior = .never
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        guard let countryData = countryInfo else { return cell }
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as? TitleCell
            cell?.titleLabel.text = countryData.country.name
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
            cell?.titleLabel.text = "Capital"
            cell?.nameLabel.text = countryData.country.capital
            cell?.iconImageView.image = UIImage(named: "i-star")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
            cell?.titleLabel.text = "Population"
            cell?.nameLabel.text = "\(countryData.country.population)"
            cell?.iconImageView.image = UIImage(named: "i-face")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "InfoCell", for: indexPath) as? InfoCell
            cell?.titleLabel.text = "Continent"
            cell?.nameLabel.text = countryData.country.continent
            cell?.iconImageView.image = UIImage(named: "i-earth")
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as? DescriptionCell
            cell?.descriptionLabel.text = countryData.country.countryDescription
            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        default:
            return cell
        }
        
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let midPointOfVisibleRect = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = collectionView.indexPathForItem(at: midPointOfVisibleRect) {
            pageControl.currentPage = visibleIndexPath.row
        }
    }
    
    
    
}

extension CountryInfoController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        countryInfo?.images?.count ?? 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        guard let countryData = countryInfo else { return cell }
        if countryData.images == nil {
            cell.imageView.image = countryData.flagImage
        } else {
            cell.imageView.image = countryData.images?[indexPath.row]
        }
        
        return cell
    }
    
}

extension CountryInfoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
