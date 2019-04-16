
public protocol CounterySelectorDelegate {
    func selectCountery(country: Country)
    func selectCountery(regionCode: String, country: Country?)
}
