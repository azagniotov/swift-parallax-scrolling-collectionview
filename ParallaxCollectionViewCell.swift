class ParallaxCollectionViewCell: UICollectionViewCell {
    
    var backgroundImageView: UIImageView!
    var foregroundImageView: UIImageView!
    
    var backgroundImageOffset: CGPoint!
    var foregroundImageOffset: CGPoint!
    
    var backgroundImage:UIImage! {
        didSet {
            self.backgroundImageView.image = backgroundImage
            if backgroundImageOffset != nil {
                setBackgroundImageOffset(backgroundImageOffset)
            } else {
                setBackgroundImageOffset(CGPointZero)
            }
        }
    }
    
    var foregroundImage:UIImage! {
        didSet {
            self.foregroundImageView.image = foregroundImage
            self.foregroundImageOffset = CGPointZero
            let frame:CGRect = foregroundImageView.bounds
            let offsetFrame:CGRect = CGRectOffset(frame, self.foregroundImageOffset.x, self.foregroundImageOffset.y)
            foregroundImageView.frame = offsetFrame
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupBackgroundImageView()
        setupForegroundImageView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupBackgroundImageView()
        setupForegroundImageView()
    }
    
    func setupBackgroundImageView() {
        self.clipsToBounds = true
        backgroundImageView = UIImageView(frame: CGRectZero)
        backgroundImageView.contentMode = UIViewContentMode.ScaleAspectFill
        backgroundImageView.clipsToBounds = false
        self.addSubview(backgroundImageView)
    }
    
    func setupForegroundImageView() {
        self.clipsToBounds = true
        foregroundImageView = UIImageView(frame: CGRectZero)
        foregroundImageView.contentMode = UIViewContentMode.ScaleAspectFit
        foregroundImageView.clipsToBounds = false
        self.addSubview(foregroundImageView)
    }
    
    func setBackgroundImageOffset(imageOffset:CGPoint) {
        self.backgroundImageOffset = imageOffset
        let frame:CGRect = backgroundImageView.bounds
        let offsetFrame:CGRect = CGRectOffset(frame, self.backgroundImageOffset.x, self.backgroundImageOffset.y)
        backgroundImageView.frame = offsetFrame
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.backgroundImageView?.frame = CGRectMake(0, 0, self.bounds.width, self.bounds.height + ParallaxConstants.OffsetSpeed)
        
        // Have to left re-align the foreground image (the alpha text) per iDevice
        if let imageSize = self.foregroundImageView?.image?.size {
            let imageWidth = self.bounds.height * imageSize.width / imageSize.height
            self.foregroundImageView?.frame = CGRectMake(0, 0, imageWidth, self.bounds.height)
        }
        
        self.setBackgroundImageOffset(self.backgroundImageOffset)
    }
}

