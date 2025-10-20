// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClinicViewModel {
  final String id;
  final String name;
  final String street;
  final String number;
  final String neighborhood;
  final String city;
  final String state;
  final String zipCode;

  ClinicViewModel({
    required this.id,
    required this.name,
    required this.street,
    required this.number,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.neighborhood,
  });

  ClinicViewModel.test()
      : this(
          id: 'id',
          name: 'Clínica Lavoisier',
          street: 'Rua das Flores',
          number: '123',
          city: 'São Paulo',
          state: 'SP',
          neighborhood: 'Jardim Primavera',
          zipCode: '12345678',
        );
}
