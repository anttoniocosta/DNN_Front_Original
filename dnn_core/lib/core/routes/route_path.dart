import 'package:dnn_dependencies/get_export.dart';
import 'package:flutter/foundation.dart';

Transition transitionPage({Transition? transition = Transition.cupertino}) {
  return kIsWeb ? Transition.noTransition : transition!;
}

abstract class Routes {
  static const String basePage = '/';
  static const String splashPage = '/apresentacao';
  static const String errorPage = '/erro';

  /// [SETUP] ***********************************************************
  static const String environment = '/ambiente';
  static const String noInternet = '/perda-de-conexao';
  static const String badInternet = '/internet-instavel';
  static const String initialize = '/inicializacao';

  /// [AUTHORIZATION] ***********************************************************
  static const String authPage = '/entrar';
  static const String forgetPassword = '/entrar/recuperar-senha';
  static const String otpValidation = '/autenticacao-de-telefone';

  ///[TERMOS] ***********************************************************
  static const String useTerms = '/termos-de-uso';
  static const String payTerms = '/termos-de-compra';

  ///[ATENDIMENTO] ***********************************************************
  static const String serviceCall = '/atendimento';
  static const String streammingPage = '/streamming';

  ///[REGISTRAR_SE] ***********************************************************
  static const String registerZipcode = '/register/endereco';
  static const String registerPersonal = '/register/dados-iniciais';
  static const String registerCompany = '/register/dados-da-empresa';
  static const String registerClinic = '/register/dados-da-clinica';
  static const String registerType = '/register/tipo-de-registro';

  ///[FLUXO_DE_COMPRA] ***********************************************************
  static String _payPath = '/contratacao';
  static String _creditPath = '/cartao-de-credito';
  static String paymentChoice =
      '${_payPath}/compra/escolher-metodo-de-pagamento';
  static String renewalChoice =
      '${_payPath}/renovacao/escolher-metodo-de-pagamento';

  static String paymentError = '${_payPath}/pagamento-invalido';
  static String paymentChoiceAddress = '${_payPath}/endereco-para-faturamento';

  static String creditCardInfos = '${_payPath}${_creditPath}/dados-do-cartao';
  static String creditCardList = '${_payPath}${_creditPath}/meus-cartoes';
  static String indentifyCCV =
      '${_payPath}${_creditPath}/validar-cartao-selecionado';
  static String addressForPayment = '${_payPath}${_creditPath}/meu-endereco';
  static String creditInstallmentsPage = '${_payPath}${_creditPath}/parcelas';
  static String creditResumeFinishPage = '${_payPath}${_creditPath}/confirmar';
  static String paymentStatus = '${_payPath}/conclusao';
  static String paymentResumePix = '${_payPath}/pagamento-com-pix';
  static String paymentResumeBoleto = '${_payPath}/pagamento-com-boleto';
  static String serviceChoiceDependent = '${_payPath}/meus-dependentes';

  /// [INVOICES] *******************************************************************
  static String _invPath = '/minhas-faturas/contrato';
  static String _myPlanPath = '/meus-planos/detalhes';
  static const String myInvoices = '/minhas-faturas';
  static String myInvoiceRecover = '${_invPath}/recuperar-pagamento';
  static String myContractsInvoices = '${_invPath}/detalhes';
  static String myContractsInvoicesResume = '${_invPath}/detalhes/resumo';
  static String myPlansDetails = '${_myPlanPath}';
  static String myPlansPaymentDetail = '${_myPlanPath}/pagamento';
  static String refundPlanPage = '${_myPlanPath}/pagamento/solicitar-reembolso';

  /// [PROFILE] ***********************************************************
  static const String myEditData = '/perfil/editar-dados';
  static const String myUpdatePassword = '/perfil/alterar-senha';
  static const String profile = '/perfil';
  static const String profileSettings = '/perfil/configuracoes';

  /// [HELPERS] ***********************************************************
  static const String helpers = '/ajudas';
  static const String helpersList = '/ajudas/como-podemos-te-ajudar';
  static const String helpersDetails = '/ajudas/como-podemos-te-ajudar/detalhe';

  /// [QA] ***********************************************************
  static const String qaTest = '/perfis-de-teste';

  /// [PORTAL_WEBVIEW] ***********************************************************
  static const String portalWebView = '/portal';

  /// [OFFERS] ***********************************************************
  static const String offersPage = '/ofertas';
  static const String offersPageDetails = '/ofertas/detalhes';

  /// [CAMPAIGNS] ***********************************************************
  static String _campaignBase = '/campanha/planos';
  static String campaignMainOffers = '${_campaignBase}/principais';
  static String campaignMainOffersForDependent =
      '${_campaignBase}/principais/dependente';
  static String campaignComplementsOffers = '${_campaignBase}/complementos';
  static String campaignComplementsOffersForDependent =
      '${_campaignBase}/complementos/dependente';
  static String campaignPersonalInfos = '${_campaignBase}/register/dados';
  static String campaignLocationInfos = '${_campaignBase}/register/endereco';
  static String campaignDependentPersonalInfos =
      '${_campaignBase}/registrar/dependente/dados';
  static String campaignDependentLocationInfos =
      '${_campaignBase}/registrar/dependente/endereco';
  static String campaignHireForDependent =
      '${_campaignBase}/adicionar-dependente';
  static String campaignCartResume = '${_campaignBase}/carrinho/resumo';
  static String campaignCartConfirm = '${_campaignBase}/carrinho/confirmar';
  static String campaignCartPlansWithFidelity =
      '${_campaignBase}/carrinho/planos-com-fidelidade';

  /// [VENDEDOR] ******************************************************************
  static String sellerLinks = '/revendedor/links-de-revenda';

  ///[AGENDAR_CONSULTA] ***********************************************************
  static String scheduleType = '/agendar/escolher-modalidade';
  static String scheduleGeneralFilters = '/agendar/filtros-gerais';
  static String scheduleCityFilter = '/agendar/filtros-gerais/cidade';
  static String scheduleClinicFilter = '/agendar/clinica/filtros';
  static String scheduleSpecialtyFilter = '/agendar/especialidade/filtros';
  static String scheduleSpecialistFilter = '/agendar/especialista/filtros';
  static String scheduleSpecialistAble =
      '/agendar/especialista/horas-para-disponiveis';
  static String scheduleSpecialtyAble =
      '/agendar/especialidade/horas-para-disponiveis';
  static String scheduleSelectSpecialist =
      '/agendar/especialista/selecionar-especialista';
  static String scheduleConfirm = '/agendar/agora-e-so-confirmar';
  static String scheduleConclusion = '/agendar/finalizado-com-sucesso';
  static String scheduleOtherPatient = '/agendar/para-outra-pessoa-ou-nao';
  static String schedulePatientZipcode = '/agendar/dados-enderenco-do-paciente';
  static String schedulePatientInfos = '/agendar/dados-pessoais-do-paciente';

  ///[MY_ADS] ***********************************************************
  static String adSelectSpecialist = '/meus-anuncios/selecionar-especialista';
  static String adSelectDay =
      '/meus-anuncios/selecionar-especialista/selecionar-dia';
  static String adSelectHour =
      '/meus-anuncios/selecionar-especialista/selecionar-horario';
  static String adSelectConclusion =
      '/meus-anuncios/anuncio-postado-com-sucesso';

  ///[MY_SPECIALISTS] ***********************************************************
  static String mySpecialistList = '/meus-especialistas';
  static String addSpecialistInfos =
      '/meus-especialistas/adicionar/dados-pessoais';
  static String addSpecialistLocation =
      '/meus-especialistas/adicionar/endereco';
  static String addSpecialistSpecialty =
      '/meus-especialistas/adicionar/especialidades';
  static String addSpecialistDuration = '/meus-especialistas/adicionar/duracao';
  static String addSpecialistType =
      '/meus-especialistas/adicionar/forma-de-atendimento';
  static String addSpecialistPrice =
      '/meus-especialistas/adicionar/valor-da-consulta';
  static String addSpecialistPhoto =
      '/meus-especialistas/adicionar/foto-de-perfil';
  static String addSpecialistConclusion =
      '/meus-especialistas/adicionar/conclusao-do-cadastro';

  ///[PUBLISH_AGENDA] ***********************************************************
  static String publishSpecialist = '/minha-agenda/especialistas';
  static String publishSelectDay = '/minha-agenda/publicar/selecionar-dia';
  static String publishSelectHour = '/minha-agenda/publicar/selecionar-hora';
  static String publishSelectConclusion =
      '/minha-agenda/publicar/agenda-publicada-com-sucesso';

  ///[CLINIC_DATA] ***********************************************************
  static String clinicaData = '/dados-da-clinica';
  static String clinicaDataChanged =
      '/dados-da-clinica/dados-alterados-com-sucesso';

  ///[MY_APPOINTMENTS_CLINIC] ***********************************************************
  static String appointmentSpecialistList =
      '/minhas-consultas/selecionar-especialista';
  static String appointmentSelectType =
      '/minhas-consultas/selecionar-agendar-desejada';

  static String appointmentedSelectDay =
      '/minhas-consultas/agendadas/selecionar-dia';
  static String appointmentedSelectHour =
      '/minhas-consultas/agendadas/selecionar-hora';
  static String appointmentedConfirm =
      '/minhas-consultas/agendadas/confirmar-escolha';
  static String appointmentedConclusion =
      '/minhas-consultas/agendadas/reagendado-com-sucesso';

  static String reappoinmentSelectDay =
      '/minhas-consultas/reagendar/selecionar-dia';
  static String reappoinmentSelectHour =
      '/minhas-consultas/reagendar/selecionar-hora';
  static String reappoinmentConfirm =
      '/minhas-consultas/reagendar/confirmar-escolha';
  static String reappoinmentConclusion =
      '/minhas-consultas/reagendar/reagendado-com-sucesso';

  static String onReappoinmentSelectDay =
      '/minhas-consultas/aguardando-reagendamento/selecionar-dia';
  static String onReappoinmentSelectHour =
      '/minhas-consultas/aguardando-reagendamento/selecionar-hora';

  static String canceledSelectDay =
      '/minhas-consultas/canceladas/selecionar-dia';
  static String canceledSelectHour =
      '/minhas-consultas/canceladas/selecionar-hora';

  static String finishedSelectDay =
      '/minhas-consultas/finalizadas/selecionar-dia';
  static String finishedSelectHour =
      '/minhas-consultas/finalizadas/selecionar-hora';

  ///[startAppointment] ***********************************************************
  static String startAppointment = '/iniciar-consulta';
  static String screenProntuaryClient = '/consulta/meu-prontuario';
  static String triagemQueueDoctor = '/consultsa/triagem';
  static String scheduledQueueDoctor = '/consultas/agendadas';
  static String screenTriagemQueue = '/consulta/fila-de-triagem';
  static String streammingPatient = '/consulta/paciente/consulta-em-andamento';
  static String streammingTriagem = '/consulta/triagem/consulta-em-andamento';
  static String streammingDoctor = '/consulta/doutor/consulta-em-andamento';

  ///[MY_APPOINTMENTS_CLIENT] ***********************************************************
  static String myAppointments = '/minhas-consultas';
  static String myAppointmentsCancel = '/minhas-consultas/cancelar';
  static String myAppointmentsCancelConfirm =
      '/minhas-consultas/cancelar/confirmar';
  static String myAppointmentsReappoint =
      '/minhas-consultas/reagendar/confirmar';
  static String myAppointmentsReappointConfirm =
      '/minhas-consultas/reagendar/confirmar';
}
