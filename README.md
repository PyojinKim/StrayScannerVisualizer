# StrayScannerVisualizer

A set of MATLAB scripts to work with data collected using [Stray Scanner](https://apps.apple.com/us/app/stray-scanner/id1557051662).

![results](https://github.com/PyojinKim/StrayScannerVisualizer/blob/main/result.png)


## Usage

To access the data from your iOS device, see [this wiki entry](https://github.com/kekeblom/StrayVisualizer/wiki/Accessing-Data).
It is noteworthy that the reliable (effective) depth range is up to about 4.5 m as described [here](https://www.it-jim.com/blog/iphones-12-pro-lidar-how-to-get-and-interpret-data/).
In my personal experience, iPhone/iPad LiDAR (depth map) shows much better depth quality than Intel RealSense L515.


## Notes on Data Acquisition

- Lock the screen orientation on iPhone/iPad (Rotation Lock button)
- Turn the charging port to the right side (x-axis towards the bottom where the lightning cable is)


## Reference

- Introduction to the [Stray Scanner](https://apps.apple.com/us/app/stray-scanner/id1557051662) (https://keke.dev/blog/2021/03/10/Stray-Scanner.html)
- Registration (Alignment) between color and depth images (https://developer.apple.com/forums/thread/663995)
- Depth image resolution (256 x 192) (https://developer.apple.com/forums/thread/688791)
- Access depth data purely from LiDAR only (https://developer.apple.com/forums/thread/653539)
