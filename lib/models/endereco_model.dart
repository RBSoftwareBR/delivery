
class Endereco {
  String cidade;
  String cep;
  String bairro;
  String endereco;
  String numero;
  String complemento;
  String referencia;
  String estado;
  double lat;
  double lng;

  Endereco({
    required this.cidade,
    required this.cep,
    required this.bairro,
    required this.endereco,
    required this.numero,
    required this.complemento,
    required this.referencia,
    required this.estado,
    required this.lat,
    required this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'cidade': cidade,
      'cep': cep,
      'bairro': bairro,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'referencia': referencia,
      'estado': estado,
      'lat': lat,
      'lng': lng,
    };
  }

  factory Endereco.fromMap(dynamic map) {
    return Endereco(
      cidade: map['cidade'].toString(),
      cep: map['cep'].toString(),
      bairro: map['bairro'].toString(),
      endereco: map['endereco'].toString(),
      numero: map['numero'].toString(),
      complemento: map['complemento'].toString(),
      referencia: map['referencia'].toString(),
      estado: map['estado'].toString(),
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  @override
  String toString() {
    return 'Endereco{cidade: $cidade, cep: $cep, bairro: $bairro, endereco: $endereco, numero: $numero, complemento: $complemento, referencia: $referencia, estado: $estado, lat: $lat, lng: $lng}';
  }
}
