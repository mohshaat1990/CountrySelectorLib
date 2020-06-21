
public protocol CounterySelectorDelegate: class  {
    func selectCountery(country: Country)
    func selectCountery(regionCode: String, country: Country?)
}
