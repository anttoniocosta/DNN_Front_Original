abstract class PagesEnum {
  //Editar dados
  static const String editUserData = 'editUserData';
  //Configurações
  static const String profileSettings = 'userConfigs';
  //Redefinir senha
  static const String changePassword = 'changePassword';
  //Esqueci minha senha
  static const String forgetPassword = 'forgetPassword';

  //Ajudas gerais
  static const String helpers = 'helpers';
  //Termos de uso
  static const String useTerms = 'useTerms';

  //Escolher dependente
  static const String choiceDependent = 'choiceDependent';

  /* ----------- REGISTRO CLIENTE --------------------- */
  //Dados pessoais
  static const String personalInfos = 'personalInfos';
  //Meu endereço
  static const String personalLocation = 'personalLocation';
  //Dados pessoais do dependente
  static const String dependentInfos = 'dependentInfos';
  //Endereço do dependente
  static const String dependentLocation = 'dependentLocation';

  /* ----------- CONTRACTS --------------------- */
  // Meus contratos
  static const String myPlans = 'myPlans';
  // Detalhes de pagamento
  static const String paymentDetails = 'paymentDetails';
  // Solicitação de reembolso
  static const String refundContract = 'refundContract';
  // Validação de Telefone
  static const String otpValidation = 'otpValidation';

  /* ----------- PLANS PAGE --------------------- */
  //Planos
  static const String planPage = 'planPage';
  //Contratos disponíveis
  static const String consultAvailable = 'consultAvaiable';

  /* ----------- PARCEIRO --------------------- */
  //Dados da empresa
  static const String businessCompanyInfos = 'businessCompanyInfos';
  //Endereço da empresa
  static const String businessCompanyLocation = 'businessCompanyLocation';
  //Dados do dependente do associado
  static const String businessDependentInfos = 'businessDependentInfos';
  //Endereço do dependente do associado
  static const String businessDependentLocation = 'businessDependentLocation';
  //Dados do associado
  static const String businessEmployeeInfos = 'businessEmployeeInfos';
  //Endereço do associado
  static const String businessEmployeeLocation = 'businessEmployeeLocation';

  //Comissões mensais
  static const String partnerComissionMonth = 'partnerComissionMonth';
  //Comissões geriais
  static const String partnerComissions = 'partnerComissions';
  //Documentos pendentes
  static const String partnerDocuments = 'partnerDocuments';
  //Criar novo time
  static const String partnerNewTeam = 'partnerNewTeam';

  //Endereço do parceiro
  static const String partnerRegisterAddress = 'partnerRegisterAddress';
  //Dados do parceiro
  static const String partnerRegisterInfos = 'partnerRegisterInfos';
  //Senha do parceiro
  static const String partnerRegisterPassword = 'partnerRegisterPassword';
  //Time do parceiro
  static const String partnerRegisterTeamName = 'partnerRegisterTeamName';

  //Vendas completas
  static const String partnerSalesCompleted = 'partnerSalesCompleted';
  //Vendas pendentes
  static const String partnerSalesUncompleted = 'partnerSalesUncompleted';

  //Convite de diretor
  static const String partnerInviteDirector = 'partnerInviteDirector';
  //Convite de gerente
  static const String partnerInviteManager = 'partnerInviteManager';
  //Convite de vendedor
  static const String partnerInviteSeller = 'partnerInviteSeller';
  //Trocar nome da equipe
  static const String partnerChangeName = 'partnerChangeName';
  //Configurações do time
  static const String partnerTeamConfigs = 'partnerTeamConfigs';
  //Meu time
  static const String partnerMyTeam = 'partnerMyTeam';
  //Menu de perfis
  static const String partnerSigninProfiles = 'partnerSigninProfiles';

  //Aceitar iniciar chamada pelo app parceiro
  static const String partnerAgreeCall = 'partnerAgreeCall';

  /* ----------- PAGAMENTO --------------------- */
  //Como deseja pagar?
  static const String paymentGatewayChoice = 'paymentGatewayChoice';
  //Como deseja renovar
  static const String renewalGatewayChoice = 'renewalGatewayChoice';
  //Confirmar escolha
  static const String gatewayConfirm = 'gatewayConfirm';

  //Resumo do boleto
  static const String resumeBillet = 'resumeBillet';
  //Resumo do pix
  static const String resumePix = 'resumePix';
  //Resumo do cartão de crédito
  static const String resumeCreditCard = 'resumeCreditCard';

  //Informações do cartão
  static const String creditCardInfos = 'creditCardInfos';
  //Endereço para fatura
  static const String addressForPayment = 'addressForPayment';
  //Escolher endereço para fatura
  static const String choiceAddressForPayment = 'choiceAddressForPayment';
  //Parcelas
  static const String creditCardInstallments = 'creditCardInstallments';
  //Lista de cartões
  static const String creditCardMyCards = 'creditCardMyCards';
  //Inserir CVV do cartão
  static const String creditCardCVV = 'creditCardCVV';

  // Botão iniciar atendimento
  static const String startCallNow = 'startCallNow';

  //Quero este plano
  static const String wantThisPlan = 'bt_want_this_plan';

  //Comprar Consulta
  static const String buyConsultation = 'bt_buy_consultation';
}
