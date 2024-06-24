workspace {

    model {
        // Modèle
        customer = person "Web customer" "Client de la boutique en ligne"

        payment = softwareSystem "Payment & Billing" "Gestion des paiements et de la facturation"
        logistics = softwareSystem "Logistics & Delivery" "Gestion des stocks et acheminement des commandes"
        store = softwareSystem "Web Store" "Permet aux clients de passer des commandes en ligne"

        // Relations depuis / vers les systèmes
        customer -> store "Uses"
        store -> payment "Uses"
        store -> logistics "Uses"
    }

    views {
        // Diagrammes
        systemcontext store "StoreContext" {
            include *
            autoLayout
        }

        // Thèmes et styles
        theme default
    }

}