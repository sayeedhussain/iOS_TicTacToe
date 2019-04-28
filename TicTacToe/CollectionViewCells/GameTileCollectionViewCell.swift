
import UIKit

class GameTileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "GameCollectionViewCellIdentifier";
   
    @IBOutlet weak var tileLabel: UILabel!
    
    func setValueToTileLabel(value: String) {
        self.tileLabel.text = value
    }
}
