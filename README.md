# 🌦️ Season

A modern weather forecasting application built with SwiftUI that provides real-time weather conditions, hourly forecasts, and multi-location support. The project was developed as part of the Native Mobile App Development Track at the Information Technology Institute (ITI).

## Features

### Current Weather

* Real-time weather information for the selected location.
* Current temperature and weather condition.
* Daily high and low temperatures.
* Weather condition icon.

### Dynamic Day & Night Experience

* Automatically switches between morning and evening themes based on the current time.
* Adaptive background images and text colors for improved user experience.

### 3-Day Forecast

* Today's forecast.
* Tomorrow's forecast.
* Day-after-tomorrow forecast.
* Weather condition icons and temperature ranges for each day.

### Hourly Forecast

* Detailed hourly weather updates.
* Displays forecast starting from the current hour.
* Easy navigation from the forecast list to hourly details.

### Weather Highlights

* Visibility.
* Humidity.
* Feels Like temperature.
* Atmospheric pressure.

### Multi-Location Support

* Search for weather information in any city worldwide.
* Save favorite locations for quick access.
* Navigate directly to detailed weather information for saved locations.

## Architecture

The application follows the **MVVM (Model-View-ViewModel)** architecture to ensure clean code organization, maintainability, and scalability.

```text
Season
├── Models
├── Views
├── ViewModels
├── Services
├── Utilities
└── Resources
```

## Technologies

* SwiftUI
* SwiftData
* Core Location
* MVVM Architecture
* Async/Await
* WeatherAPI
* Xcode

## API Integration

Weather data is powered by WeatherAPI.

Documentation:
https://www.weatherapi.com/docs/


## Getting Started

### Prerequisites

* Xcode 16 or later
* iOS 18 or later
* WeatherAPI API Key

### Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/Season.git
```

2. Open the project in Xcode.

3. Add your WeatherAPI key.

4. Build and run the application on a simulator or physical device.

## Learning Outcomes

This project demonstrates:

* SwiftUI application development.
* API integration and networking.
* State management in SwiftUI.
* Location-based services.
* Clean architecture using MVVM.
* Asynchronous programming with Async/Await.
* Data persistence using SwiftData.

## Author

**Mahmoud Bayoumi**

Native Mobile App Development Track
Information Technology Institute (ITI)

## License

This project was developed for educational purposes as part of the ITI Native Mobile App Development Track.
