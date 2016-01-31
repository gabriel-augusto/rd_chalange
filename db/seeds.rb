contact_list = [
    ['Lucas', 'lucas@email.com', 18.years.ago, 'DF', 'trainee'],
    ['Júlia', 'julia@email.com', 25.years.ago, 'SC', 'Jr. Developer'],
    ['Mateus', 'mateus@email.com', 30.years.ago, 'MG', 'Manager'],
    ['Renata', 'renata@email.com', 47.years.ago, 'BA', 'CEO']
]

contact_list.each do |name, email, date_of_birth, state, position|
  Contact.create( name: name, email: email, date_of_birth: date_of_birth, state: state, position: position )
end