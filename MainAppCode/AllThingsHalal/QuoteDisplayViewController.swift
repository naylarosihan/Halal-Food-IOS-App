//
//  QuoteDisplayViewController.swift
//  AllThingsHalal
//
//  Created by PettaMarukka on 8/6/2024.
//

import UIKit

class QuoteDisplayViewController: UIViewController {
    
    
    @IBOutlet weak var quoteLabel: UILabel!
    
    var hadith: Hadith?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        if let hadith = hadith {
            quoteLabel.text = hadith.hadithEnglish
            print("Displaying hadith: \(hadith.hadithEnglish)")  // Debug print
        } else {
            print("No hadith to display")  // Debug print
        }
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
