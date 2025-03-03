//
//  HomeViewController.swift
//  loginformyapp
//
//  Created by Nayla Rosihan on 30/4/2024.
//


import UIKit

class HomeViewController: UIViewController {
    var hadiths: [Hadith] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hadiths = loadHadiths() ?? []
        print("Loaded hadiths: \(hadiths)")  // Debug print
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showHadithSegue",
           let destinationVC = segue.destination as? QuoteDisplayViewController {
            let randomHadith = hadiths.randomElement()
            destinationVC.hadith = randomHadith
            print("Passing hadith: \(String(describing: randomHadith))")  // Debug print
        }
    }
    

    @IBAction func dailyIslamicQuotesTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "showHadithSegue", sender: self)

    }

}

func loadHadiths() -> [Hadith]? {
    guard let url = Bundle.main.url(forResource: "ahadith", withExtension: "json") else {
        print("Could not find ahadith.json")
        return nil
    }
    
    do {
        let data = try Data(contentsOf: url)
        let decoder = JSONDecoder()
        let hadiths = try decoder.decode([Hadith].self, from: data)
        return hadiths
    } catch {
        print("Error loading or parsing JSON: \(error)")
        return nil
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

