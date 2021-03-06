//
//  FirstTabViewController.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit
import CoreLocation

class FirstTabViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var noDataView: NoDataView!
    
    //MARK: - Properties
    
    private var viewModel = GooglePlaceViewModel()
    private var placeType: String = "hotel"
    
    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        findUserLocation()
    }
    
    //MARK: - Other Methods
    
    private func findUserLocation() {
        viewModel.findUserLocation { [weak self] in
            self?.downloadData()
        }
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: PlaceTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: PlaceTableViewCell.toString())
        noDataView.state = .waitingForGPS
        tableView.backgroundView = noDataView
    }
    
    private func downloadData() {
        noDataView.state = .waitingForDownloading
        viewModel.fetchData(withLocation: viewModel.userLocation, andType: placeType) { [weak self] in
            self?.setupBackgroundTableView()
            self?.tableView.reloadData()
        }
    }
    
    private func setupBackgroundTableView() {
        let placesCount = viewModel.placesCount
        noDataView.state = placesCount > 0 ? NoDataViewState.hidden : NoDataViewState.waitingForDownloading
    }
    
    @IBAction func typeButtonAction(_ sender: UIButton) {
        guard
            let buttonTitle = sender.titleLabel?.text?.lowercased(),
            placeType != buttonTitle
            else { return }
        
        placeType = buttonTitle
        viewModel.removeData()
        setupBackgroundTableView()
        tableView.reloadData()
        downloadData()
    }
}

//MARK: - TableView Data Source Methods

extension FirstTabViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.placesCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PlaceTableViewCell.toString(),
                                                       for: indexPath) as? PlaceTableViewCell else { return UITableViewCell() }
        let placeData = viewModel.getPlaceData(withIndex: indexPath.row)
        cell.update(name: placeData.name, photoReference: placeData.photoReference)
        
        if placeData.photoReference == "" {
            cell.thumbnailImageView.image = UIImage(named: "NoImageFound")
            cell.activityIndicator.stopAnimating()
        } else {
            viewModel.fetchImage(withWidth: 450, andPlaceIndex: indexPath.row) { image in
                if cell.photoReference == placeData.photoReference {
                    cell.activityIndicator.stopAnimating()
                    cell.thumbnailImageView.image = image
                }
            }
        }
        
        return cell
    }
}
