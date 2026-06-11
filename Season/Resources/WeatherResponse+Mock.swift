//
//  WeatherResponse+Mock.swift
//  Season
//
//  Created by Bayoumi on 05/06/2026.
//

extension WeatherResponse {
    static var mockPreviewData: WeatherResponse {
        WeatherResponse(
            location: Location(
                name: "`Izbat Yusif Barradah",
                region: "Al Jizah",
                country: "Egypt",
                lat: 30.112,
                lon: 31.046,
                localtime: "2026-06-05 11:36"
            ),
            current: CurrentWeather(
                tempC: 32.1,
                feelslikeC: 30.7,
                condition: WeatherCondition(text: "Sunny", icon: "//cdn.weatherapi.com/weather/64x64/day/113.png"),
                humidity: 21,
                visKm: 10.0,
                pressureMb: 1014.0,
                isDay: 1,
                uv: 8.0,
                windKph: 11.2,
                windDir: "NE",
                gustKph: 12.9,
                precipMm: 0.0,
                airQuality: AirQuality(pm25: 13.4, pm10: 27.1, epaIndex: 1)
            ),
            forecast: Forecast(
                forecastday: [
                    ForecastDay(
                        date: "2026-06-05",
                        day: DayInfo(
                            maxtempC: 37.0,
                            mintempC: 21.8,
                            condition: WeatherCondition(text: "Sunny", icon: ""),
                            dailyChanceOfRain: 0,
                            totalprecipMm: 0.0
                        ),
                        astro: Astro(sunrise: "05:54 AM", sunset: "07:54 PM", moonPhase: "Last Quarter"),
                        hour: [
                            Hour(timeEpoch: 1780646400, time: "2026-06-05 11:00", tempC: 32.1, condition: WeatherCondition(text: "Sunny", icon: "")),
                            Hour(timeEpoch: 1780650000, time: "2026-06-05 12:00", tempC: 32.5, condition: WeatherCondition(text: "Sunny", icon: ""))
                        ]
                    ),
                    ForecastDay(
                        date: "2026-06-06",
                        day: DayInfo(
                            maxtempC: 39.3,
                            mintempC: 23.8,
                            condition: WeatherCondition(text: "Sunny", icon: ""),
                            dailyChanceOfRain: 0,
                            totalprecipMm: 0.0
                        ),
                        astro: Astro(sunrise: "05:54 AM", sunset: "07:54 PM", moonPhase: "Last Quarter"),
                        hour: []
                    ),
                    ForecastDay(
                        date: "2026-06-07",
                        day: DayInfo(
                            maxtempC: 38.0,
                            mintempC: 20.4,
                            condition: WeatherCondition(text: "Sunny", icon: ""),
                            dailyChanceOfRain: 0,
                            totalprecipMm: 0.0
                        ),
                        astro: Astro(sunrise: "05:54 AM", sunset: "07:55 PM", moonPhase: "Last Quarter"),
                        hour: []
                    )
                ]
            )
        )
    }
}
