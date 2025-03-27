//
//  MockWeatherUseCase.swift
//  EasyBreezy
//
//  Created by Phanvit Chevamongkolnimit on 27/3/2568 BE.
//

import XCTest
import Combine
@testable import EasyBreezy

class MockWeatherUseCase: WeatherUseCaseProtocol {
    var shouldSucceed = true
    var mockWeatherModel: WeatherModel?
    var mockError: Error?

    func execute(lat: Double, lon: Double) -> AnyPublisher<WeatherModel, Error> {
        if shouldSucceed {
            if let model = mockWeatherModel {
                return Just(model)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.unexpectedResponse)
                    .eraseToAnyPublisher()
            }
        } else {
            if let error = mockError {
                return Fail(error: error)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NetworkError.unknown(NSError(domain: "Mock", code: 0, userInfo: nil)))
                    .eraseToAnyPublisher()
            }
        }
    }
}


final class WeatherNetworkServiceTests: XCTestCase {

    var mockSession: MockURLSession!
    var networkService: WeatherNetworkService!

    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        // Since the provided code uses URLSession.shared, we can't directly inject our mock session
        // For proper unit testing of URLSession interactions, consider creating your own NetworkService
        // that accepts a URLSession as a dependency.
        // For this example, we'll focus on the EndPoint creation.
        networkService = WeatherNetworkService()
    }

    func testWeatherEndPointCreation() {
        let endPoint = WeatherNetworkService.WeatherEndPoint.weather(lat: 10.0, lon: 100.0)
        XCTAssertEqual(endPoint.baseURL, "https://api.weatherapi.com/v1/")
        XCTAssertEqual(endPoint.path, "forecast.json")
        XCTAssertEqual(endPoint.method, .get)
        XCTAssertEqual(endPoint.headers, ["Accept": "application/json"])
        XCTAssertEqual(endPoint.params["key"], "6c4a3ad7ef15474c8e9160743252203")
        XCTAssertEqual(endPoint.params["q"], "10.0,100.0")
        XCTAssertEqual(endPoint.params["days"], "3")
        XCTAssertEqual(endPoint.params["aqi"], "yes")
        XCTAssertNil(try endPoint.body())
    }

    // Note: Testing the actual network call with URLSession.shared is more of an integration test.
    // For a pure unit test of WeatherNetworkService's call function, you'd need to mock URLSession.
}

final class WeatherRepositoryTests: XCTestCase {

    var mockNetworkService: MockWeatherNetworkService!
    var weatherRepository: WeatherRepository!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockNetworkService = MockWeatherNetworkService()
        weatherRepository = WeatherRepository(networkService: mockNetworkService)
    }

    func testFetchWeatherSuccess() {
        let expectedResponse = WeatherResponseModel(
            location: LocationModel(name: "Test", region: "Test", country: "Test", lat: 0.0, lon: 0.0, tzId: "Test", localtimeEpoch: 0.0, localtime: "Test"),
            current: ForecastModel(tempC: 0.0, tempF: 0.0, isDay: .day, condition: ConditionModel(text: "Test", icon: "Test", code: 0), windMph: 0.0, windKph: 0.0, windDegree: 0, windDir: .s, pressureMb: 0.0, pressureIn: 0.0, precipMm: 0.0, precipIn: 0.0, humidity: 0, cloud: 0, feelslikeC: 0.0, feelslikeF: 0.0, windchillC: 0.0, windchillF: 0.0, heatindexC: 0.0, heatindexF: 0.0, dewpointC: 0.0, dewpointF: 0.0, visKm: 0.0, visMiles: 0.0, uv: 0.0, gustMph: 0.0, gustKph: 0.0, airQuality: nil),
            forecast: WeatherResponseModel.Forecast(forecastday: [])
        )
        mockNetworkService.shouldSucceed = true
        mockNetworkService.mockWeatherResponse = expectedResponse

        let expectation = XCTestExpectation(description: "Fetch weather success")

        weatherRepository.fetchWeather(lat: 0.0, lon: 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.location.name, "Test")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testFetchWeatherFailure() {
        let expectedError = NetworkError.invalidURL
        mockNetworkService.shouldSucceed = false
        mockNetworkService.mockError = expectedError

        let expectation = XCTestExpectation(description: "Fetch weather failure")

        weatherRepository.fetchWeather(lat: 0.0, lon: 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but finished successfully")
                case .failure(let error):
//                    XCTAssertEqual(error as? NetworkError, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

final class WeatherUseCaseTests: XCTestCase {

    var mockWeatherRepository: MockWeatherRepository!
    var weatherUseCase: WeatherUseCase!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockWeatherRepository = MockWeatherRepository(networkService: MockWeatherNetworkService())
        weatherUseCase = WeatherUseCase(weatherRepository: mockWeatherRepository)
    }

    func testExecuteSuccess() {
        let mockResponse = WeatherResponseModel(
            location: LocationModel(name: "TestCity", region: "TestRegion", country: "TestCountry", lat: 0.0, lon: 0.0, tzId: "Test", localtimeEpoch: 0.0, localtime: "Test"),
            current: ForecastModel(tempC: 25.0, tempF: 77.0, isDay: .day, condition: ConditionModel(text: "Sunny", icon: "Test", code: 1000), windMph: 5.0, windKph: 8.0, windDegree: 0, windDir: .s, pressureMb: 1000.0, pressureIn: 29.53, precipMm: 0.0, precipIn: 0.0, humidity: 60, cloud: 0, feelslikeC: 25.0, feelslikeF: 77.0, windchillC: 25.0, windchillF: 77.0, heatindexC: 25.0, heatindexF: 77.0, dewpointC: 17.0, dewpointF: 62.6, visKm: 10.0, visMiles: 6.0, uv: 7.0, gustMph: 7.0, gustKph: 11.3, airQuality: nil),
            forecast: WeatherResponseModel.Forecast(forecastday: [
                ForecastDayModel(
                    date: "2025-03-27",
                    dateEpoch: 1648310400,
                    forecastDay: ForecastDayModel.Forecast(maxtempC: 30.0, maxtempF: 86.0, mintempC: 20.0, mintempF: 68.0, avgtempC: 25.0, avgtempF: 77.0, maxwindMph: 10.0, maxwindKph: 16.1, totalprecipMm: 0.0, totalprecipIn: 0.0, totalsnowCm: 0.0, avgvisKm: 10.0, avgvisMiles: 6.0, avghumidity: 70, dailyWillItRain: 0, dailyChanceOfRain: 0, dailyWillItSnow: 0, dailyChanceOfSnow: 0, condition: ConditionModel(text: "Sunny", icon: "Test", code: 1000), uv: 7.0),
                    astro: AstroModel(sunrise: "06:00 AM", sunset: "06:00 PM", moonrise: "07:00 PM", moonset: "07:00 AM", moonPhase: "Full Moon", moonIllumination: 100, isMoonUp: 1, isSunUp: 1),
                    forecastHours: [
                        ForecastModel(timeEpoch: Int(Date().timeIntervalSince1970) + 3600, time: "08:00", tempC: 26.0, tempF: 78.8, isDay: .day, condition: ConditionModel(text: "Sunny", icon: "Test", code: 1000), windMph: 6.0, windKph: 9.7, windDegree: 0, windDir: .s, pressureMb: 1000.0, pressureIn: 29.53, precipMm: 0.0, precipIn: 0.0, humidity: 60, cloud: 0, feelslikeC: 26.0, feelslikeF: 78.8, windchillC: 26.0, windchillF: 78.8, heatindexC: 26.0, heatindexF: 78.8, dewpointC: 17.0, dewpointF: 62.6, visKm: 10.0, visMiles: 6.0, uv: 7.0, gustMph: 8.0, gustKph: 12.9, airQuality: nil)
                    ]
                )
            ])
        )
        mockWeatherRepository.shouldSucceed = true
        mockWeatherRepository.mockWeatherResponse = mockResponse

        let expectation = XCTestExpectation(description: "Execute use case success")

        weatherUseCase.execute(lat: 0.0, lon: 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure(let error):
                    XCTFail("Expected success, but received error: \(error)")
                }
            }, receiveValue: { weatherModel in
                XCTAssertEqual(weatherModel.name, "TestCity")
                XCTAssertEqual(weatherModel.currentForecast.tempC, 25.0)
                XCTAssertFalse(weatherModel.hourlyForecast.isEmpty)
                XCTAssertFalse(weatherModel.dailyForecast.isEmpty)
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }

    func testExecuteFailure() {
        let expectedError = NetworkError.responseCode(400)
        mockWeatherRepository.shouldSucceed = false
        mockWeatherRepository.mockError = expectedError

        let expectation = XCTestExpectation(description: "Execute use case failure")

        weatherUseCase.execute(lat: 0.0, lon: 0.0)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but finished successfully")
                case .failure(let error):
//                    XCTAssertEqual(error as? NetworkError, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but received value")
            })
            .store(in: &cancellables)

        wait(for: [expectation], timeout: 1.0)
    }
}

final class WeatherViewModelTests: XCTestCase {

    var mockWeatherUseCase: MockWeatherUseCase!
    var viewModel: WeatherViewModel!
    var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        super.setUp()
        mockWeatherUseCase = MockWeatherUseCase()
        viewModel = WeatherViewModel(weatherUseCase: mockWeatherUseCase)
    }

    func testLoadWeatherSuccess() {
        let mockModel = WeatherModel(
            name: "TestCity",
            isDay: .day,
            astrio: nil,
            currentForecast: ForecastModel(tempC: 25.0, tempF: 77.0, isDay: .day, condition: ConditionModel(text: "Sunny", icon: "Test", code: 1000), windMph: 5.0, windKph: 8.0, windDegree: 0, windDir: .s, pressureMb: 1000.0, pressureIn: 29.53, precipMm: 0.0, precipIn: 0.0, humidity: 60, cloud: 0, feelslikeC: 25.0, feelslikeF: 77.0, windchillC: 25.0, windchillF: 77.0, heatindexC: 25.0, heatindexF: 77.0, dewpointC: 17.0, dewpointF: 62.6, visKm: 10.0, visMiles: 6.0, uv: 7.0, gustMph: 7.0, gustKph: 11.3, airQuality: nil),
            hourlyForecast: [],
            dailyForecast: []
        )
        mockWeatherUseCase.shouldSucceed = true
        mockWeatherUseCase.mockWeatherModel = mockModel

        let expectation = XCTestExpectation(description: "Load weather success")

        viewModel.loadWeather(lat: 0.0, lon: 0.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow time for the publisher to emit
            XCTAssertNotNil(self.viewModel.weather)
            XCTAssertEqual(self.viewModel.weather?.name, "TestCity")
            XCTAssertNil(self.viewModel.error)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }

    func testLoadWeatherFailure() {
        let expectedError = NetworkError.responseCode(404)
        mockWeatherUseCase.shouldSucceed = false
        mockWeatherUseCase.mockError = expectedError

        let expectation = XCTestExpectation(description: "Load weather failure")

        viewModel.loadWeather(lat: 0.0, lon: 0.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // Allow time for the publisher to emit
            XCTAssertNil(self.viewModel.weather)
            XCTAssertNotNil(self.viewModel.error)
//            XCTAssertEqual(self.viewModel.error as? NetworkError, expectedError)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
}

// MARK: - Helper Mock for URLSession (for more comprehensive NetworkService testing)

class MockURLProtocol: URLProtocol {
    static var mockResponseData: Data?
    static var mockError: Error?
    static var mockResponse: HTTPURLResponse?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.mockError {
            client?.urlProtocol(self, didFailWithError: error)
        } else if let data = MockURLProtocol.mockResponseData, let response = MockURLProtocol.mockResponse {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            client?.urlProtocol(self, didLoad: data)
        } else {
            client?.urlProtocol(self, didFailWithError: NSError(domain: "Mock", code: 0, userInfo: nil))
        }
        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {
        // Required method, but no implementation needed for this mock.
    }
}

class MockURLSession: URLSession {
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return MockURLSessionDataTask(request: request, completionHandler: completionHandler)
    }
}

class MockURLSessionDataTask: URLSessionDataTask {
    let request: URLRequest
    let completionHandler: (Data?, URLResponse?, Error?) -> Void

    init(request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        self.request = request
        self.completionHandler = completionHandler
    }

    override func resume() {
        completionHandler(MockURLProtocol.mockResponseData, MockURLProtocol.mockResponse, MockURLProtocol.mockError)
    }
}
