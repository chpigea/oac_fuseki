# SPARQL

## Insert items if not already existing
```console
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT {
  ?term rdfs:label ?label .
}
WHERE {
  VALUES (?term ?label) {
    (<http://example.org/vocabulary/OperaDArte> "Obra de arte"@es)
    (<http://example.org/vocabulary/Dipinto> "Cuadro"@es)
    (<http://example.org/vocabulary/Scultura> "Escultura"@es)
  }
  FILTER NOT EXISTS {
    ?term rdfs:label ?label .
  }
}
```

### with broader's attribute

```console
PREFIX crm: <http://www.cidoc-crm.org/cidoc-crm/>
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

INSERT {
  ?term a crm:E55_Type ;
        rdfs:label ?label ;
        crm:P127_has_broader_term ?broader .
}
WHERE {
  VALUES (?term ?label ?broader) {
    (<http://diagnostica/vocabularies/condizioni-ambientali/ambiente> "Ambiente"@it <http://diagnostica/vocabularies/condizioni-ambientali>)
    (<http://diagnostica/vocabularies/condizioni-ambientali/interno> "Interno"@it <http://diagnostica/vocabularies/condizioni-ambientali>)
    (<http://diagnostica/vocabularies/condizioni-ambientali/esterno> "Esterno"@it <http://diagnostica/vocabularies/condizioni-ambientali>)
  }

  FILTER NOT EXISTS {
    ?term rdfs:label ?label .
  }
}
```

## List items

```console
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>

SELECT ?term ?label ?lang
WHERE {
  ?term rdfs:label ?label .
  FILTER(
    STRSTARTS(STR(?term), "http://example.org/vocabulary/") &&
    LANG(?label) = "it"
  )
  BIND(LANG(?label) AS ?lang)
}
ORDER BY ?term ?lang
```