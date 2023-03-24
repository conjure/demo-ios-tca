# Demo Project using The Composable Architecture
The primary objective of this project was to acquire knowledge and insight into the Composable Architecture framework, its advantages, and to determine if it is a viable option for future use. This framework was developed by Point-Free and its main feature is the management of an application's state. The project involves fetching JSON data on London's buses through the use of Transport for London's API.

## Requirements
This project requires that you enable location services on your device. Also, you will need to get a Transport for London API id and key from their developer's webpage.

Once you have the API id and key, please enter them in the Constants.swift file in the Xcode project.

```swift
    struct Constants {
        static let transportForLondonKey = "ENTER_TFL_API_KEY"
        static let transportForLondonAppID = "ENTER_TFL_API_ID"
    }
```



