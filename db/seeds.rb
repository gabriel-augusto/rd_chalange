contact_list = [
    [ "Lucas",    "lucas@email.com",    18,   "DF",   "trainee" ],
    [ "Júlia",    "julia@email.com",    25,   "SC",   "Jr. Developer" ],
    [ "Mateus",   "mateus@email.com",   30,   "MG",   "Manager" ],
    [ "Renata",   "renata@email.com",   47,   "BA",   "CEO"]
]

contact_list.each do |name, email, age, state, position|
  Contact.create( name: name, email: email, age: age, state: state, position: position )
end