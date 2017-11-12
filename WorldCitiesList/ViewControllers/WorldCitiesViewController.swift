//
//  WorldCitiesViewController.swift
//  WorldCitiesList
//
//  Created by Ibrahim on 09/11/17.
//  Copyright © 2017 Ibrahim. All rights reserved.
//

import UIKit
import FlagKit

// MARK: - WorldCitiesListView Constants
struct WorldCitiesListViewConstants {
    static let shadowOpacity = 1.0
    static let shadowRadius = 2.0
    static let shadowOffset = 2.0
    static let cornerRadius = 10.0
    static let defaultPopulationLabel = "0"
    static let emptyStringValue = " "
}

class WorldCitiesViewController: UIViewController {

    @IBOutlet weak var sortingSegmentControl: UISegmentedControl!
    @IBOutlet weak var cityNameSearchBar: UISearchBar!
    @IBOutlet weak var worldCitiesListView: UITableView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    // Reference of the VIEWMODEL. The VIEWCONTROLLER should hold the reference of the VIEWMODEL alone. Any iteractions with the MODEL will be done by the VIEWMODEL indeed. Business Logic will be in VIEWMODEL which will be suitable for writing testing cases. The service calls should be made in VIEWMODEL Layer. The VIEWMODEL should never return any objects of MODEL to VIEWCONTROLLER which will break the architecture of MVVM.
    let worldCityViewModel: WorldCityViewModel = WorldCityViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupWorldCitiesService()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup Service
    func setupWorldCitiesService() {
        let worldCitiesServiceDelegateBlock: () -> Void = {
            //Sort the population - Descending
            self.worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.populationKey, sortingType: GlobalConstants.SortingType.descendingOrder)
            self.worldCitiesListView.reloadData()
        }
        worldCityViewModel.getWorldCitiesResponse(delegateBlock: worldCitiesServiceDelegateBlock)
    }
    
    // MARK: - Setup views
    func setupTableView() {
        // register table view for custom cells
        worldCitiesListView.register(UINib(nibName: NibNameConstants.worldCityDetailsTableViewCellNibName, bundle: nil), forCellReuseIdentifier: IdentifierConstants.worldCityDetailsTableViewCellIdentifier)
        
        //Border and styling for TableView
        let containerView:UIView = UIView(frame:CGRect(x: worldCitiesListView.frame.origin.x, y: worldCitiesListView.frame.origin.y, width: worldCitiesListView.frame.size.width, height: worldCitiesListView.frame.size.height))
        containerView.backgroundColor = UIColor.clear
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: WorldCitiesListViewConstants.shadowOffset, height: WorldCitiesListViewConstants.shadowOffset)
        containerView.layer.shadowOpacity = Float(WorldCitiesListViewConstants.shadowOpacity)
        containerView.layer.shadowRadius = CGFloat(WorldCitiesListViewConstants.shadowRadius)
        worldCitiesListView.layer.cornerRadius = CGFloat(WorldCitiesListViewConstants.cornerRadius)
        worldCitiesListView.layer.masksToBounds = true
        view.addSubview(containerView)
        containerView.addSubview(worldCitiesListView)
    
        //Bringing No Results label infront of the superview.
        view.bringSubview(toFront: noResultsLabel)
    }
    
    @IBAction func segmentedControlAction(sender: AnyObject) {
        if(sortingSegmentControl.selectedSegmentIndex == 0) {
            //Sort the population - Descending
            worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.populationKey, sortingType: GlobalConstants.SortingType.descendingOrder)
        } else if(sortingSegmentControl.selectedSegmentIndex == 1) {
            //Sort the population - Ascending
            worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.populationKey, sortingType: GlobalConstants.SortingType.ascendingOrder)
        } else if(sortingSegmentControl.selectedSegmentIndex == 2) {
            //Sort the City Name - Descending
            worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.cityNameKey, sortingType: GlobalConstants.SortingType.descendingOrder)
        } else if(sortingSegmentControl.selectedSegmentIndex == 3) {
            //Sort the City Name - Ascending
            worldCityViewModel.sortWorldCitiesListBy(key: JsonKeyConstants.cityNameKey, sortingType: GlobalConstants.SortingType.ascendingOrder)
        }
        //Reload the table view and scroll to top of the table(first cell)
        worldCitiesListView.reloadData()
        if worldCitiesListView.numberOfRows(inSection: 0) > 0 {
            worldCitiesListView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        }
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension WorldCitiesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        if worldCityViewModel.getCitiesCount() > 0 {
            noResultsLabel.isHidden = true
        } else {
            noResultsLabel.isHidden = false
        }
        return worldCityViewModel.getCitiesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cityDetails : WorldCityModel = worldCityViewModel.getCityDetails(atIndex: indexPath.row)
        let cell : WorldCityDetailsTableViewCell! = tableView.dequeueReusableCell(withIdentifier: IdentifierConstants.worldCityDetailsTableViewCellIdentifier, for: indexPath) as! WorldCityDetailsTableViewCell
        // Retrieve the styled image for customized use
        let flag = Flag(countryCode: (cityDetails.countryCode?.uppercased())!)
        cell.countryFlagImageView.image = flag?.image(style: .circle)
        cell.cityNameLabel.text = cityDetails.cityName?.capitalized
        cell.populationLabel.text = (cityDetails.population != nil) ? getFormatedPopulationString(value: cityDetails.population!) : WorldCitiesListViewConstants.defaultPopulationLabel
        cell.setUIAttributes()
        cell.backgroundColor = getTableViewCellColor(rowIndex: indexPath.row)
        return cell as WorldCityDetailsTableViewCell
    }
}

// MARK: - UISearchBarDelegate Delegate
extension WorldCitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        worldCityViewModel.filterworldCitiesListBy(searchText: searchText)
        //Sort the filtered list
        segmentedControlAction(sender: sortingSegmentControl)
        //Reload the table view and scroll to top of the table(first cell)
        worldCitiesListView.reloadData()
        if worldCitiesListView.numberOfRows(inSection: 0) > 0 {
            //Reload the table view and scroll to top of the table(first cell)
            worldCitiesListView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: false)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        cityNameSearchBar.resignFirstResponder()
    }
 
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //Restricting user from entering the first character as Empty Space
        if (cityNameSearchBar.text?.isEmpty)!, text == WorldCitiesListViewConstants.emptyStringValue {
            return false
        } else {
            return true
        }
    }
}

extension WorldCitiesViewController {
    // function to get tableViewCell color
    // white color for odd rows and groupTableViewBackground color for even rows
    func getTableViewCellColor(rowIndex: Int) -> UIColor {
        if rowIndex % 2 == 0 {
            return UIColor.white
        } else {
            return UIColor.groupTableViewBackground
        }
    }
    
    // function to get population digit formated
    func getFormatedPopulationString(value : Int) -> String! {
        let largeNumber = value
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        return numberFormatter.string(from: NSNumber(value:largeNumber))
    }
}
