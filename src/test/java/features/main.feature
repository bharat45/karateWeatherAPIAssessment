Feature: Weather api feature
  
Scenario: invalid api id
* def query = {q:'Delhi', APPID: '18b857c628d65b99d31'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 401

Scenario: successful call
* def query = {q:'Delhi', APPID: '18b857c628d65b99d3178a7e59ffee41'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 200

Scenario: schema validation for the response
* def query = {q:'Delhi', APPID: '18b857c628d65b99d3178a7e59ffee41'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 200
* print response
* def jsonSchemaExpected = 
"""
{
   "coord":{
      "lon":'#number',
      "lat":'#number'
   },
   "weather":[
      {
         "id":'#number',
         "main":'#string',
         "description":'#string',
         "icon":'#string'
      }
   ],
   "base":'#string',
   "main":{
      "temp":'#number',
      "feels_like":'#number',
      "temp_min":'#number',
      "temp_max":'#number',
      "pressure":'#number',
      "humidity":'#number'
   },
   "visibility":'#number',
   "wind":{
      "speed":'#number',
      "deg":'#number'
   },
   "clouds":{
      "all":'#number'
   },
   "dt":'#number',
   "sys":{
      "type":'#number',
      "id":'#number',
      "country":'#string',
      "sunrise":'#number',
      "sunset":'#number'
   },
   "timezone":'#number',
   "id":'#number',
   "name":'#string',
   "cod":'#number'
}
"""
* match response == jsonSchemaExpected

Scenario: dt attribute returned in response represents current date and time
* def query = {q:'Delhi,in', APPID: '18b857c628d65b99d3178a7e59ffee41'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 200
* def JavaDemo = Java.type('supportingjson.supportingjson')
* def result = JavaDemo.unixTime()
* print result
* print response.dt
* assert response.dt > result - 1000
* assert response.dt < result

Scenario: delhi current temprature < 35 degree celsius
* def query = {q:'Delhi,in', APPID: '18b857c628d65b99d3178a7e59ffee41'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 200
* assert response.main.temp - 273.15 < 35

Scenario: humidity is > 50 for Guwahati
* def query = {q:'Delhi,in', APPID: '18b857c628d65b99d3178a7e59ffee41'}
Given url 'http://api.openweathermap.org/data/2.5/weather'
And params query
When method GET
Then status 200
* assert response.main.humidity > 50