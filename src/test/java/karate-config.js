function fn() {
    var env = karate.env;
    if(!env) {
        env = 'dev'
    }
    var config = {
        env: env,
        myVarName: 'hello karate',
        baseUrl: 'http://api.openweathermap.org/data/2.5/weather',
        apiId: '18b857c628d65b99d3178a7e59ffee41'
    }
    return config
}