// function to covert Celsius
// to Fahrenheit
function celsiusToFahrenheit(celsius) {
    return (celsius * 9/5) + 32;
}
// Driver Code
let celsius = 25;
console.log(celsius + "°C is equal to " + celsiusToFahrenheit(celsius) + "°F");

// function to covert Fahrenheit
// to Celsius
function fahrenheitToCelsius(fahrenheit) {
    return (fahrenheit - 32) * 5/9;
}
// Driver Code
fahrenheit = 77;
console.log(fahrenheit + "°F is equal to " + fahrenheitToCelsius(fahrenheit) + "°C");

