workspace {

    model {
        // Modèle
        customer = person "Web customer" "Client de la boutique en ligne"

        payment = softwareSystem "Payment & Billing" "Gestion des paiements et de la facturation"
        logistics = softwareSystem "Logistics & Delivery" "Gestion des stocks et acheminement des commandes"
        store = softwareSystem "Web Store" "Permet aux clients de passer des commandes en ligne" {
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
        systemcontext store "StoreContext" {
            include *
            autoLayout
        }

        container store "StoreContainers" {
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
                icon "./icons/angular-icon.png"
            }

            element "Backend" {
                icon "./icons/spring-boot-icon.png"
            }
        }
    }
}