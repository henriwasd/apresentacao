import 'package:search_cep/search_cep.dart';

class CepService {
  void searchCep(cep) async {
    final viaCepSearchCep = ViaCepSearchCep();
    final infoCepJSON = await viaCepSearchCep.searchInfoByCep(cep: cep);
    print(infoCepJSON);
  }
}
