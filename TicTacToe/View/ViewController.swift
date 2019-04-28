
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gameCollectionView: UICollectionView!
    private var viewModel: GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setCollectionViewDataSource()
    }
    
    func displayAlert(winner: String) {
        let alert = UIAlertController(title: "Congratulations!!", message: winner + " wins", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
            @unknown default:
                print("")
            }}))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setCollectionViewDataSource() {
        self.gameCollectionView.dataSource = self
        self.gameCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.size.width / CGFloat(self.viewModel.dimensions) - 10.0, height: collectionView.bounds.size.width / CGFloat(self.viewModel.dimensions) - 10.0)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.dimensions
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.dimensions
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameTileCollectionViewCell.identifier, for: indexPath) as! GameTileCollectionViewCell
        cell.setValueToTileLabel(value: viewModel.titleValueFor(indexPath: indexPath))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = self.viewModel.updateGameState(indexPath: indexPath)
        if result == .Finished {
            self.displayAlert(winner: viewModel.winner()!)
        }
        collectionView.reloadData()
    }
}
