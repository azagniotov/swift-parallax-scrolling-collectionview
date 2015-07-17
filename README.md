#### Parallax Scrolling using UICollectionView and UICollectionViewCell in Swift
##### Parallax scrolling using a moving background and a static foreground (alpha) images

[Parallax scrolling](https://en.wikipedia.org/wiki/Parallax_scrolling) is a big UI design trend these days. It is a technique 
where background images move by the camera slower than foreground images, creating an illusion of depth in a 2D scene and 
adding to the immersion.

In this example we are using [UICollectionView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionView_class/index.html) which is subclass of a [UIScrollView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIScrollView_Class/index.html) and two images per CollectionView cell [UICollectionViewCell](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewCell_class/index.html). Each image
is contained inside an [UIImageView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImageView_Class/index.html) within the cell:

1. Background image which we are going to use for the parallax scrolling effect. The image here can be an image of some scenery
2. Foreground alpha image which remains static on top of the background image. The foreground can be a transparent image with some text 

```
override public func collectionView(collectionView: UICollectionView, 
            cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
   let cell:ParallaxCollectionViewCell = 
            collectionView.dequeueReusableCellWithReuseIdentifier(
                     "parallaxCellId", forIndexPath: indexPath) as! ParallaxCollectionViewCell
   cell.backgroundImage = UIImage(named: "\(images[indexPath.row])_background.png")!
   cell.foregroundImage = UIImage(named: "\(images[indexPath.row])_alpha.png")!
        
   return cell
}
```

The parallax scrolling is achieved by overriding `UIScrollView` delegate method `scrollViewDidScroll` where we change
the `Y` axis offset of the background image view in relation to the parent cell:

```
override public func scrollViewDidScroll(scrollView: UIScrollView) {
   for cell in collectionView!.visibleCells() {
      var cell:ParallaxCollectionViewCell = cell as! ParallaxCollectionViewCell
      let yOffset:CGFloat = ((collectionView!.contentOffset.y - cell.frame.origin.y) / 
            cell.backgroundImageView.bounds.height) * ParallaxConstants.OffsetSpeed
      cell.setBackgroundImageOffset(CGPointMake(0, yOffset))
   }
}
```
We are using delegate `collectionView:layout:sizeForItemAtIndexPath:` from [UICollectionViewDelegateFlowLayout](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewDelegateFlowLayout_protocol/index.html) to control the height of cells in our `UICollectionView`. In other words, 
how many cells should be visible to user at once:

```
public func collectionView(collectionView: UICollectionView, 
                           layout collectionViewLayout: UICollectionViewLayout, 
                           sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
   return CGSizeMake(self.view.bounds.width, self.view.bounds.height / ParallaxConstants.CellsPerCollectionView)
}
```


### Inspired By

1. [Rikin Desai](https://ios8programminginswift.wordpress.com/2014/08/24/collection-view-with-parallax-scrolling/)
2. [Venkat Palivela](http://venkatpalivela.com/)
3. [Cyril Wei](https://cn.linkedin.com/pub/cyril-wei/52/22/a89)
