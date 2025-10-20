class SpecialistViewModel {
  final String id;
  final String name;
  final String specialty;
  final String crm;
  final String consultValue;
  final String clinica;
  final String consultType;

  SpecialistViewModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.crm,
    required this.consultValue,
    required this.consultType,
    required this.clinica,
  });

  SpecialistViewModel.test()
      : this(
          id: 'id',
          name: 'Dra. Ana SIlva Bertani Araujo',
          specialty: 'Ginecologista',
          crm: '54.302',
          consultValue: '70.00',
          consultType: 'Online',
          clinica: 'Clínica Lavoisier',
        );
}
