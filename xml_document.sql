DROP TABLE xml_database;
CREATE TABLE xml_database(
id        NUMBER,
  xml_data  XMLTYPE
);

DECLARE
  airplane XMLTYPE;
  airport XMLTYPE;
  carrier XMLTYPE;
  clients XMLTYPE;
  country XMLTYPE;
  flight XMLTYPE;
  passenger XMLTYPE;
  payment XMLTYPE;
  reservation XMLTYPE;
  db          XMLTYPE;
  
BEGIN
SELECT XMLELEMENT("airplanes",
          XMLAGG(
            XMLELEMENT("airplane",
              XMLFOREST(
              a.ID AS "ID",
              a.BRAND AS "BRAND",
              a.MODEL AS "MODEL",
              a.SEATSNO AS "SEATSNO"
              )
            )
          )
        )
  INTO airplane
  FROM airplane a;
  
SELECT XMLELEMENT("airports",
          XMLAGG(
            XMLELEMENT("airport",
              XMLFOREST(
              a.ID AS "ID",
              a.COUNTRYID AS "COUNTRYID",
              a.NAME AS "NAME",
              a.CITY AS "CITY"
              )
            )
          )
        )
  INTO airport
  FROM airport a;
  
SELECT XMLELEMENT("carriers",
          XMLAGG(
            XMLELEMENT("carrier",
              XMLFOREST(
              a.ID AS "ID",
              a.NAME AS "NAME",
              a.RATING AS "RATING"
              )
            )
          )
        )
  INTO carrier
  FROM carrier a;

 SELECT XMLELEMENT("clients",
          XMLAGG(
            XMLELEMENT("client",
              XMLFOREST(
              c.ID AS "ID",
              c.COUNTRYID AS "COUNTRYID",
              c.FIRSTNAME AS "FIRSTNAME",
              c.LASTNAME AS "LASTNAME",
              c.CITY AS "CITY",
              c.STREET AS "STREET",
              c.HOUSENO AS "HOUSENO",
              c.FLATNO AS "FLATNO",
              c.TELNUMBER AS "TELNUMBER",
              c.EMAIL AS "EMAIL"
              )
            )
          )
        )
  INTO clients
  FROM client c;
  
SELECT XMLELEMENT("countries",
          XMLAGG(
            XMLELEMENT("country",
              XMLFOREST(
              c.ID AS "ID",
              c.NAME AS "NAME"
              )
            )
          )
        )
  INTO country
  FROM country c;
  
SELECT XMLELEMENT("flights",
          XMLAGG(
            XMLELEMENT("flight",
              XMLFOREST(
              f.ID AS "ID",
              f.CARRIERID AS "CARRIERID",
              f.AIRPLANEID AS "AIRPLANEID",
              f.DEPAIRPORTID AS "DEPAIRPORTID",
              f.DESTAIRPORTID AS "DESTAIRPORTID",
              f.DEPDATE AS "DEPDATE",
              f.ARRDATE AS "ARRDATE"
              )
            )
          )
        )
  INTO flight
  FROM flight f;
  
SELECT XMLELEMENT("passengers",
          XMLAGG(
            XMLELEMENT("passenger",
              XMLFOREST(
              p.ID AS "ID",
              p.CLIENTID AS "CLIENTID",
              p.FAVCARRIERID AS "FAVCARRIERID",
              p.LOYALTYPOINTS AS "LOYALTYPOINTS",
              p.FLIGHTSNO AS "FLIGHTSNO"
              )
            )
          )
        )
  INTO passenger
  FROM passenger p;
  
  SELECT XMLELEMENT("payments",
          XMLAGG(
            XMLELEMENT("payment",
              XMLFOREST(
              p.ID AS "ID",
              p.AMOUNTPAID AS "AMOUNTPAID",
              p.PAYMENTDATE AS "PAYMENTDATE",
              p.ISCARDPAYMENT AS "ISCARDPAYMENT"
              )
            )
          )
        )
  INTO payment
  FROM payment p;
  
  
  SELECT XMLELEMENT("reservations",
          XMLAGG(
            XMLELEMENT("reservation",
              XMLFOREST(
              r.ID AS "ID",
              r.FLIGHTID AS "FLIGHTID",
              r.PASSENGERID AS "PASSENGERID",
              r.PAYMENTID AS "PAYMENTID",
              r.SEATNO AS "SEATNO"
              )
            )
          )
        )
  INTO reservation
  FROM reservation r;
  
  SELECT XMLAGG(XMLCONCAT(airplane, airport))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, carrier))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, clients))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, country))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, flight))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, passenger))
  INTO airplane FROM DUAL;
  SELECT XMLAGG(XMLCONCAT(airplane, payment))
  INTO airplane FROM DUAL;
  SELECT XMLELEMENT("base", XMLAGG(XMLCONCAT(airplane, reservation)))
  INTO db FROM DUAL;
  INSERT INTO xml_database VALUES (1,db);
  
END;
/