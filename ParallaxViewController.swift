import UIKit
 
public class ParallaxViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private var images: [String] = [
        "mountain",
        "ocean",
        "valley",
        "canyon"
    ]
    
    override public func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    override public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:ParallaxCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("parallaxCellId", forIndexPath: indexPath) as! ParallaxCollectionViewCell
        cell.backgroundImage = UIImage(named: "\(images[indexPath.row])_background.png")!
        cell.foregroundImage = UIImage(named: "\(images[indexPath.row])_alpha.png")!
        
        return cell
    }
    
    override public func scrollViewDidScroll(scrollView: UIScrollView) {
        for cell in collectionView!.visibleCells() {
            var cell:ParallaxCollectionViewCell = cell as! ParallaxCollectionViewCell
            let yOffset:CGFloat = ((collectionView!.contentOffset.y - cell.frame.origin.y) / cell.backgroundImageView.bounds.height) * ParallaxConstants.OffsetSpeed
            cell.setBackgroundImageOffset(CGPointMake(0, yOffset))
        }
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(self.view.bounds.width, self.view.bounds.height / ParallaxConstants.CellsPerCollectionView)
    }
}

