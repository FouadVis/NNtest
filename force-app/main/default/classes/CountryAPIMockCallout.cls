@isTest
global class CountryAPIMockCallout  implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setStatusCode(200);
        res.setBody('[{"name":"España","alpha2Code":"ES","alpha3Code":"ESP","capital":"Madrid","region":"Europa","subregion":"Peninsula Iberica"},{"name":"Portugal","alpha2Code":"PT","alpha3Code":"PORT","capital":"Lisboa","region":"Europa","subregion":"Peninsula Iberica"}]');
        return res;
    }
}