# UIGraphRangeSlider
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
## Screenshot
![](https://github.com/PanPanayotov/UIGraphRangeSlider/blob/master/Screen%20Shot%202016-08-23%20at%2011.09.33.png?raw=true)

UIRangeSlider is a subclass of ```UIControl``` and you can get changes with ```UIControlValueChanged``` method.

###Init
```
let rangeSlider = UIGraphRangeSlider()
rangeSlider.graphPoints = [0,2,6,4,5,8,3,10,12,14,15,16,10,4,1,1,1,1,0]
rangeSlider.frame =CGRect(x:0, y:0, width: self.view.bounds.width, height: 120)
```

## Configuration
The range slider can be customized and information can be accessed through these properties :

  + `minimumValue` : The minimum possible value of the range
  + `maximumValue` : The maximum possible value of the range
  + `lowerValue` : The value corresponding to the left thumb current position
  + `upperValue` : The value corresponding to the right thumb current position
  + `trackTintColor` : The track color
  + `graphColor`: The color of the graph
  + `trackHighlightTintColor` : The color of the section of the track located between the two thumbs. Alpha component will be applied automatically
  + `graphPoints`: `Array<Int>` to hold the graph points. At this point `Int` works fine, but I could implement `Float` or `Double` if needed
  + `thumbTintColor`: The thumb color
  + `curvaceousness` : From 0.0 for square thumbs to 1.0 for circle thumbs