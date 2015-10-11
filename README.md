#TCGridFlowLayout
TCGridFlowLayout calculates the size of its UICollectionView cells based on the given columns, gutter and inset values.

Works in Portrait and Landscape!

##Usage

TCGridFlowLayout's properties are IBInspectable, so you can customize them in Interface Builder
![IBInspectable](https://raw.githubusercontent.com/Marcocanc/TCGridFlowLayout/master/Screenshots/IBInspectable.png)


Alternatively you can setup the layout programmatically

    let layout = TCGridFlowLayout(columns: 3, gutter: 1, inset: 0)
    self.collectionView.collectionViewLayout = layout

##Screenshots

###Portrait
![Portrait](https://raw.githubusercontent.com/Marcocanc/TCGridFlowLayout/master/Screenshots/portrait.png)
###Landscape
![Landscape](https://raw.githubusercontent.com/Marcocanc/TCGridFlowLayout/master/Screenshots/landscape.png)
