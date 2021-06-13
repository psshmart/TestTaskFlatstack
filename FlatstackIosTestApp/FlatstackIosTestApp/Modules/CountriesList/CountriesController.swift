//
//  ViewController.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 12.06.2021.
//

import UIKit

class CountriesController: UITableViewController, CountriesViewInput {
    @IBOutlet weak var refreshCountries: UIRefreshControl!
    
    lazy var countriesTableView: UITableView = self.tableView
    private var countriesData: [CountryWithImages] = []
    private var presenter: CountriesViewOutput = CountriesPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.view = self
        presenter.loadData(isRefreshing: false)
        title = "Countries"
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.hidesBarsOnSwipe = false
    }
    
    @objc private func refresh() {
        countriesData = []
        presenter.loadData(isRefreshing: true)
        self.refreshControl?.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "CountryInfoController") as! CountryInfoController
        viewController.presenter = CountryInfoPresenter(countryData: self.countriesData[indexPath.row])
        viewController.presenter?.view = viewController.self
        viewController.presenter?.didLoad()
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countriesData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "country", for: indexPath) as! CustomCountryCell
        cell.countryNameLabel.text = countriesData[indexPath.row].country.name
        cell.countryCapitalLabel.text = countriesData[indexPath.row].country.capital
        cell.descriptionLabel.text = countriesData[indexPath.row].country.descriptionSmall
        cell.imageFlagView.image = countriesData[indexPath.row].flagImage
        return cell
    }


    func dataDidLoad(data: [CountryWithImages]) {
        self.countriesData.append(contentsOf: data)
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
           if scrollView == tableView {
               if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
               {
                presenter.loadData(isRefreshing: false)
               }
           }
       }

}

