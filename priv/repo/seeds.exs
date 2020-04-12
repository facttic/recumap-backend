alias Recumap.Accounts
alias Recumap.Resources
alias Recumap.Orgs
alias Recumap.Houses

{:ok, user} =
  Accounts.create_user(%{
    name: "recumap",
    email: "recumap@gmail.com",
    password: "abcd1234",
    password_confirmation: "abcd1234"
  })

Houses.create_house(user, %{
  address_between_streets: "some address_between_streets",
  address_locality: "some address_locality",
  address_neighborhood: "some address_neighborhood",
  address_number: 42,
  address_street: "some address_street",
  responsible_dni: "some responsible_dni",
  responsible_name: "some responsible_name",
  responsible_phone: "some responsible_phone",
  responsible_surname: "some responsible_surname",
  lat: -34.603722,
  long: -58.381592,
  attends_community_dining_room: true,
  benefited_by_social_plan: true,
  earnings_affected_isolation: true,
  earnings_formal_economy: true,
  family_emergency_plan: true,
  food_help: true,
  healh_issues: true,
  number_of_members: 42,
  number_of_minor_members: 42,
  number_of_older_members: 42
})

Orgs.create_org(user, %{
  address: "some address",
  lat: -34.603722,
  long: -58.381592,
  description: "some description",
  name: "some name",
  public: true,
  user_id: user.id
})

{:ok, resource_type} =
  Resources.create_resource_type(user, %{
    description: "some description",
    name: "some name"
  })

{:ok, resource} =
  Resources.create_resource(resource_type, user.id, %{
    description: "some description",
    name: "some name",
    details: "some details",
    address_between_streets: "some address_between_streets",
    address_locality: "some address_locality",
    address_neighborhood: "some address_neighborhood",
    address_number: 42,
    address_street: "some address_street",
    responsible_dni: "some responsible_dni",
    responsible_name: "some responsible_name",
    responsible_phone: "some responsible_phone",
    responsible_surname: "some responsible_surname",
    lat: -34.603722,
    long: -58.381592
  })
