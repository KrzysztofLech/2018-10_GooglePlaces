//
//  FirstTabViewController.swift
//  MoveApp
//
//  Created by Krzysztof Lech on 25/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

class FirstTabViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var noDataView: UIView!
    
    //MARK: - Properties
    
    private var viewModel = GooglePlaceViewModel()
    private var placeType: String = "hotel"
    
    //MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        downloadData()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//    }
    
    //MARK: - Other Methods
    
    private func setupTableView() {
        tableView.register(UINib(nibName: PlaceTableViewCell.toString(), bundle: nil),
                           forCellReuseIdentifier: PlaceTableViewCell.toString())
        setupBackgroundTableView()
    }
    
    private func setupBackgroundTableView() {
        let placesCount = viewModel.placesCount
        tableView.backgroundView = placesCount > 0 ? nil : noDataView
    }

    private func downloadData() {
        viewModel.fetchData(withLocation: Constants.warsawLocation, andType: placeType) { [weak self] in
            self?.setupBackgroundTableView()
            self?.tableView.reloadData()
        }
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
