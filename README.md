### Parallax Scrolling in Swift UICollectionViewController
##### Parallax scrolling using moving background and static foreground (alpha) images

[Parallax scrolling](https://en.wikipedia.org/wiki/Parallax_scrolling) is a big UI design trend these days. Is a technique 
where background images move by the camera slower than foreground images, creating an illusion of depth in a 2D scene and 
adding to the immersion.

In this example we are using [UICollectionView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionView_class/index.html) which is subclass of a [UIScrollView](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIScrollView_Class/index.html) and two images per CollectionView cell [UICollectionViewCell](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UICollectionViewCell_class/index.html):

1. Background image which we going to use for parallax scrolling effect. The image here can be an image of some scenery
2. Foreground alpha image which remains static on top of the background image. The foreground can be a transparent image with some text 

```
override public func collectionView(collectionView: UICollectionView, 
            cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
   let cell:ParallaxCollectionViewCell = 
            collectionView.dequeueReusableCellWithReuseIdentifier("parallaxCellId", 
                                                               forIndexPath: indexPath) as! ParallaxCollectionViewCell
   cell.backgroundImage = UIImage(named: "\(images[indexPath.row])_background.png")!
   cell.foregroundImage = UIImage(named: "\(images[indexPath.row])_alpha.png")!
        
   return cell
}
```


### Inspired By

1. [Rikin Desai](https://ios8programminginswift.wordpress.com/2014/08/24/collection-view-with-parallax-scrolling/)
2. [Venkat Palivela](http://venkatpalivela.com/)
3. [Cyril Wei](https://cn.linkedin.com/pub/cyril-wei/52/22/a89)
