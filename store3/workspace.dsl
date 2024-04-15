workspace {

    model {
        // Modèle
        customer = person "Web customer" "Client de la boutique en ligne"

        payment = softwareSystem "Payment & Billing" "Gestion des paiements et de la facturation"
        logistics = softwareSystem "Logistics & Delivery" "Gestion des stocks et acheminement des commandes"
        store = softwareSystem "Devoxx Web Store" "Permet aux clients de passer des commandes en ligne" {
            webapp = container "Web Application" "Site web de la boutique en ligne" "Angular" "Frontend"
            commandBackend = container "Command service" "Gestion des commandes web" "SpringBoot" "Backend"
            catalogBackend = container "Web catalog" "Référentiel des produits de la boutique en ligne" "SpringBoot" "Backend"
            commandDb = container "Command database" "Stockage des commandes" "PostgreSQL" "Database"
            catalogDb = container "Catalog database" "Stockage du catalogue" "PostgreSQL" "Database"
        }

        // Relations depuis / vers les systèmes
        customer -> store "Uses"
        store -> payment "Uses"
        store -> logistics "Uses"

        // Relations depuis / vers les containers
        customer -> webapp "Browse web store" "HTTPS"
        webapp -> commandBackend "Manage commands through REST API" "HTTPS"
        webapp -> catalogBackend "Get products through REST API" "HTTPS"
        commandBackend -> catalogBackend "Get products through REST API" "HTTPS"
        commandBackend -> logistics "Send delivery request" "Kafka topic"
        commandBackend -> payment "Send payment request" "HTTPS"
        commandBackend -> commandDb "Reads from and writes to" "SQL/TCP"
        catalogBackend -> catalogDb "Reads from" "SQL/TCP"
    }

    views {
        // Diagrammes
        systemcontext store "DevoxxStoreContext" {
            include *
            autoLayout
        }

        container store "DevoxxStoreContainers" {
            include *
            //autoLayout
        }

        // Thèmes et styles
        theme default

        styles {
            element "Database" {
                shape Cylinder
                background #999999
            }

            element "Frontend" {
                shape WebBrowser
                icon "data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAAAXNSR0IArs4c6QAABYZJREFUWEedl31sU2UUxp9zbze2MRjjYzA+lSEqDNha1k7I5kKC4Dq2IaGGEBSUGIMkBIOJQQf7AP7AEGJQAfkIIooI60ZcBE0IqJgYCZR1BQTGWNuxOcEhH1th7b1Heu+6rV3btbz/3fue57y/+9zzvvdcwlOMlkzDFA+x6SGjuEFy18vMVa52scbUcP5etOkoUkGjNvtFkXgxAyYwpnp1D1nGTcnjS9EJ4BTAZhLpeL7FcjuS3GEBbup0L4iyZjGITQClByYMAOg9LYFxlgRUipKmep7tnDMUTB+Aphn6yR6BTQIJJgDTwj1FhyjixmNXfw/KAJ8jJjMLcpWxtvZab4EC4NS+NIkheZ/Su+iM/jL65pPWrsGFw9+io+lWpBIAbPPCCDLM8y9ZasmZqf+diWZFkUEJFZKTMbqmGk0nTqKutCxauRJPzGfIrtX/RaDno82QtHoVBq94A+zx4JeihVG60LUa88/k0BpOApgXDYAwKBGpNdUQEhMVmbOqGnWl5dGkUB0AdpJda9hNwDvRqAe/tRxJ773bLZG9LhQuhOtWNLUAMPgDcmj16wHaHCkAxcUp715IHuIncZqrUVcWnQtMtIgaM7KWCoJwKFKAxCWvI3ndWiW8/Xo9EtImggQBqgvFcN1qjjQV4OFMsmdkzyaBz0aiopgYpB6vhDgyRQlvXL0GMfNfwZgCo1oL5irUlVVEkkqtgY7YJGqabhgraxDypOqdbWBxIYaWrFduuW80oN60BK2jR+HlajNIFFUXFhTD1RyRC3eMVssIYkBwag3e4yw2LLogINV8BJpx45SwtootaK2qVr4F08tLMbaoUHWh0oy68k2RuPCn0WoxKCehQ6uvBygtnCph3lwM26LaK7W1ocVYjAePHykACWPHIPd4FQSNpsuFIriaW8JCEPBdvtWyRAGwaw2nCJgTUkGEUYe/Rsxzk5SQe7v24P6efX5fw/QNH2P8oteUeUelGbZ+XGDwlgLrxY+6HDDsf8KxIhRAXG4ORmz/RJlmScI/y1dCuvsfOpjhlN3K/fjUVBj2fqnuCLdbrYWW0C4wsLLAatmnfowyDRuYEPJATzmwFwOm9fkah7XYccwMW0XoWmBJnlNwqfa0+goy9G+SQAeCZRwwU4eU3Z9HUlR+Mf264MYzxisWu+pARnYeC3w62CojvtiBOEOWMtV57TrcV3s+5x5mPGDZT5Y0ZQoGddWK41glbBVBD9nOdqslwQRICkDjdP2zgoYaAgFi06di5Ff7um+3Ll+Jzjpb93WwjmjItHTMOnRQiQnjwnWj1TLZG6MAcF6exnnf9QiA2Bti+LatiM/LVZ/+8hW0LvOv01AtWfb+vRiq06o7IogLBPyUb7XM7wZQArV6O0DjfQAxaRMx6sg3AKldW9vGcrTX/OhnUiiAlNwczNzxaS8XiuBq+btby8DOAqtlVQCA4dcnXW2OL2ropjIMfFVtE6S7d9GSXwTu9Da+PSNkU0qE3MrvkZimnm2Oo5WwbeqpBSKsy6+1bPMDsGsNBwlY5ksflzNb2dP86DGkO3eUsz9whOmKkZg2EQMnTIAYHw/IMppPePsedRCoMN964Qc/gBs6XZKGxbUAvU/AoD6rBbkRDiCE/g+W5PXe/d8DExDZrNMN98iaD0HwvqP4cCBRAFwEUYmx9kJNYL6QPya3M2ePdsFdwkRvExATDKR/AL4KmTfk22qPkrcDCzL6/TVz6HRpxJqNzLwUREJERQjYwVx6btiQQ6VnznT/uz0VgE9kn5E1VRCpgkHFvvOjjwOMFoA3t0ude0yXL/tvmRDvsl8HAnWOjKwskLAZhLk+AGL8C/BWKVb8bMH58x2RFHDIIoxUfDNjZl4HUUmjJP0W+5C2z32KX3PvWv8D8xhb0s49/X0AAAAASUVORK5CYII="
            }

            element "Backend" {
                icon "data:image/png;base64,AAABAAEAICAAAAEAIACoEAAAFgAAACgAAAAgAAAAQAAAAAEAIAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARLxoAEO6YQBFvWgARb1oOEW9aL5FvWj6Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o+kW9aLtFvWg1Rb1oAEa+aQBDvGcAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFvWgARb1oAEW9aChFvWjRRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aM5FvWglRb1oAEW9aAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARLxnAEW9aABFvWcBRb1olEW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aI9EvWcBRb1oAEW8ZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABFvWgARb1oAEW9aDRFvWjpRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o50W9aDFFvWgARb1oAAAAAAAAAAAAAAAAAAAAAAAAAAAARLxoAEW9aABFvWgDRb1om0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1ol0W9aAJFvWgARLxnAAAAAAAAAAAAAAAAAAAAAABFvWgARb1oAEW9aDtFvWjtRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjrRb1oN0W9aABFvWgAAAAAAAAAAAAAAAAARL1oAEW9aABFvWgFRb1oo0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o9UW9aNpFvWjHRb1oyUW9aN9FvWj4Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWieRb1oBEW9aABEvWgAAAAAAAAAAABFvWgARb1oAEW9aEFFvWjwRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o7EW9aJdFvWhERb1oGkW9aA1FvWgORb1oHkW9aE5FvWimRb1o9EW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aO5FvWg9Rb1oAEW9aAAAAAAARb1oAEW9aABFvWgHRb1oqkW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aMpFvWhBRL1nAUW9aABFvWgARb1oAEW9aABFvWgARb1oAEW9aAVFvWhURb1o2kW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aKVFvWgGRb1oAES9aABFvWgARb1oAEW9aEdFvWjzRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjERb1oJkW9aABEvWcBRb1oL0W9aHFFvWiVRb1okkW9aGlFvWglRb1oAEW9aABFvWg4Rb1o2EW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o8UW9aENFvWgARb1oAEW9aABFvWgJRb1osUW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o4UW9aDRFvWgARb1oD0W9aINFvWjoRb1o/0W9aP9FvWj/Rb1o/0W9aN5FvWhuRb1oB0W9aABFvWhMRb1o70W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1orUW9aAhFvWgARb1oAEW9aE5FvWj2Rb1o/0W9aP9FvWj/Rb1o/0W9aP5FvWh1Rb1oAEW9aAtFvWibRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aPpFvWiARb1oA0S9ZwFFvWiTRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj0Rb1oSkW9aABFvWgORb1otkW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o2EW9aB1FvWgARb1obEW9aPxFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aPRFvWhPRb1oAEW9aDJFvWjqRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWiyRb1oDEW9aGFFvWj2Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWiWRb1oAEW9aBlFvWjTRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aLlFvWgKRb1oBkW9aLRFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aPVFvWhcRb1ozUW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/kW9aF9FvWgARb1oUUW9aPpFvWj/Rb1o/0W9aP9FvWj/Rb1o+EW9aPpFvWj/Rb1o/0W9aP9FvWj/Rb1o70W9aDRFvWgARb1of0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aMhFvWj6Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj2Rb1oQEW9aABFvWh9Rb1o/0W9aP9FvWj/Rb1o/0W9aOFFvWhURb1oZUW9aO5FvWj/Rb1o/0W9aP9FvWj+Rb1oXEW9aABFvWhdRb1o/kW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o90W9aPpFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aPFFvWg1Rb1oAEW9aI5FvWj/Rb1o/0W9aP9FvWj/Rb1opEW9aABFvWgIRb1owUW9aP9FvWj/Rb1o/0W9aP9FvWhsRb1oAEW9aFFFvWj8Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj3Rb1ozUW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o9EW9aDtFvWgARb1ohEW9aP9FvWj/Rb1o/0W9aP9FvWidR71pAEW9aAdFvWi6Rb1o/0W9aP9FvWj/Rb1o/0W9aGJFvWgARb1oWEW9aP1FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aMhFvWhhRb1o9kW9aP9FvWj/Rb1o/0W9aP9FvWj8Rb1oVUW9aABFvWhdRb1o/kW9aP9FvWj/Rb1o/0W9aJ5HvWkARb1oB0W9aLtFvWj/Rb1o/0W9aP9FvWj0Rb1oP0W9aABFvWh0Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj1Rb1oXEW9aA5FvWi2Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWiGRb1oAEW9aCZFvWjiRb1o/0W9aP9FvWj/Rb1onke9aQBFvWgHRb1ou0W9aP9FvWj/Rb1o/0W9aMtFvWgTRb1nAUW9aKVFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aLJFvWgMRb1oAEW9aE5FvWj2Rb1o/0W9aP9FvWj/Rb1o/0W9aMhFvWgRR75pAEW9aItFvWj/Rb1o/0W9aP9FvWieR71pAEW9aAdFvWi7Rb1o/0W9aP9FvWj9Rb1oakW9aABFvWgiRb1o3kW9aP9FvWj/Rb1o/0W9aP9FvWj0Rb1oSUW9aABFvWgARb1oCUW9aLFFvWj/Rb1o/0W9aP9FvWj/Rb1o+UW9aFhFvWgARb1oG0W9aMBFvWj/Rb1o/0W9aJ5HvWkARb1oB0W9aLtFvWj/Rb1o/0W9aKZFvWgNRb1oAEW9aHVFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aKxFvWgIRb1oAEW9aABFvWgARb1oR0W9aPNFvWj/Rb1o/0W9aP9FvWj/Rb1oykW9aBtFvWgARb1oJ0W9aMpFvWj/Rb1onke9aQBFvWgHRb1ou0W9aP9FvWiyRb1oF0W9aABFvWgtRb1o3UW9aP9FvWj/Rb1o/0W9aP9FvWjxRb1oQ0W9aABFvWgARb1oAEW9aABFvWgHRb1oqkW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1on0W9aA1FvWgARb1oiEW9aP9FvWieR71pAEW9aAdFvWi7Rb1o/0W9aGBFvWgARb1oGUW9aLdFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aKVFvWgGRb1oAEW9ZwAAAAAARb1oAEW9aABFvWhBRb1o8EW9aP9FvWj/Rb1o/0W9aP9FvWj9Rb1ookW9aFxFvWjRRb1o/0W9aJ1HvWkARb1oB0W9aLpFvWj/Rb1ouEW9aFRFvWi1Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjuRb1oPUW9aABFvWgAAAAAAAAAAABEvWgARb1oAEW9aAVFvWijRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/UW9aP9FvWj/Rb1oqEa9aQBFvWgKRb1oxEW9aP9FvWj/Rb1o/EW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aJ5FvWgERb1oAES9ZwAAAAAAAAAAAAAAAABFvWgARb1oAEW9aDtFvWjtRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjnRb1oaUW9aHpFvWjzRb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjqRb1oN0W9aABFvWgAAAAAAAAAAAAAAAAAAAAAAES8aABFvWgARb1oA0W9aJtFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj+Rb1o/kW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aJZFvWgCRb1oAES9ZwAAAAAAAAAAAAAAAAAAAAAAAAAAAEW9aABFvWgARb1oNEW9aOlFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjnRb1oMUW9aABFvWgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARLxnAEW9aABFvWcBRb1olEW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aI9EvGcBRb1oAES9ZwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAARb1oAEW9aABFvWgoRb1o0UW9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWjORb1oJUW9aABFvWgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABEvGgAQ7lfAEW9aABFvWg3Rb1ovkW9aPpFvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj/Rb1o/0W9aP9FvWj6Rb1ou0W9aDVFvWgARr5pAES8ZgAAAAAAAAAAAAAAAAAAAAAA8AAAD/AAAA/gAAAH4AAAB8AAAAPAAAADgAAAAYAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAgAAAAYAAAAHAAAADwAAAA+AAAAfgAAAH8AAAD/AAAA8="
            }
        }
    }
}