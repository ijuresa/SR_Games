import VPlay 2.0
import QtQuick 2.0

import "scenes"
import "common"

Item {
    id: mainItem

    property alias entityManager : entityManager

    MenuScene {
        id: menuScene
    }
}


/*
  Signal:
    Ako nema parametre () zagrade su opcionalne

  Property:
    Dodijeljivanje vrijednosti prilikom inicijalizacije koristi se:
        <propertyName> : <value>
    Moze se kombinirai sa property definicijom:
        property <propertyType> <propertyName> : <value>

  Property Alias:
    To su property-ji koji drze referencu na drugi property
    Ne alocira novi prostor:
        property alias <name> : <alias reference>

*/
