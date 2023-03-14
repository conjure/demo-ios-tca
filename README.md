# Demo Project using The Composable Architecture  
The primary objective of this project was to acquire knowledge and insight into the Composable Architecture framework, its advantages, and to determine if it is a viable option for future use. This framework was developed by [Point-Free](https://www.pointfree.co/collections/composable-architecture) and its main feature is the management of an application's state. The project involves fetching JSON data on London's buses through the use of Transport for London's API.

Furthermore, the project involves the implementation of the Composable Architecture (TCA) and the Model-View-ViewModel (MVVM) to gain a better understanding of the differences between the two architectures.

To run the project in the simulator utilizing the MVVM approach in the MyApp, one should uncomment the BusStopViewMVVM() class while commenting out the BusStopView() class. Conversely, to view the project utilizing TCA, one should reverse the process.


## Requirments
This projcect requires that you enable location services on your devices. Also you will neeed to get a Transport for Londond API id and key's from their developer's [webpage](https://api.tfl.gov.uk/). 

Once yopu have the API id and key please enter them in the `Constant.swift` file in the Xcode project. 

```swift
    struct Constants {
        static let transportForLondonKey = "ENTER_TFL_API_KEY"
        static let transportForLondonAppID = "ENTER_TFL_API_ID"
    }
```

