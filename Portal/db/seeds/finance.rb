ShareHolder.find_or_create_by(name: "GOPINATH", percentage: 3)
ShareHolder.find_or_create_by(name: "SARAVANAN", percentage: 2)
ShareHolder.find_or_create_by(name: "OFFICE", percentage: 5)

TransactionVium.find_or_create_by(name: "OFFICE")
TransactionVium.find_or_create_by(name: "GOPINATH")
TransactionVium.find_or_create_by(name: "SARAVANAN")
TransactionVium.find_or_create_by(name: "OTHERS")