sealed class AppStrings{

  static const String routeNotFound = 'Rota não encontrada';
  static const String appBlog = 'AppBlog';
  static const String inicio= 'Inícios';
  static const String salvos = 'Salvos';
  static const String notificacoes = 'Notificações';
  static const String conta = 'Conta';
  static const String populares = 'Populares';
  static const String topicos = 'Tópicos';
  static const String emAlta = 'Em Alta';
  static const String verMais = 'Ver Mais';
  static const String entrar = 'Entrar';
  static const String criarConta = 'Criar Conta';
  static const String seguidores = 'Seguidores';
  static const String seguindo = 'Seguindo';
  static const String artigos = 'Artigos';
  static const String criarArtgio = 'Criar Artigo';

  static const String naoLogado = 'Você não está logado, entre ou cadastre-se no app.';
  static const String jaTemConta = 'Já tem conta? ';
  static const String facaLogin = ' Faça o login';
  static const String aindaNaoTemConta = 'Ainda não tem uma conta? ';
  static const String cadastre = ' Cadastre-se';
  static const String nome = 'Nome';
  static const String email = 'Email';
  static const String senha = 'Senha';
  static const String titulo = 'Título';
  static const String subTitulo = 'Subtítulo';
  static const String tituloDoArtigo = 'Título e Subtítulo do Artigo';
  static const String textoArtigo = 'Texto do Artigo';
  static const String texto = 'Texto';
  static const String esqueceuSenha = 'Esqueceu a Senha?';
  static const String editarPerfil = 'Editar Perfil';
  static const String sobre = 'Sobre';
  static const String camera = 'Câmera';
  static const String galeria = 'Galeria';
  static const String settings = 'Configurações';
  static const String next = 'Próximo';
  static const String back = 'Anterior';
  static const String salvarMudancas = 'Salvar Mudanças';

  static const String antesCriarArtigo = 'Antes de criar o seu artigo, crie uma conta ou entre na sua.';

}

sealed class ErrorStrings{
  static const String nomeValido = 'Informe um nome válido!';
  static const String emailValido = 'Informe um email válido!';
  static const String emailVazio = 'Informe um email!';
  static const String senhaCurta = 'Digite uma senha de pelo menos 6 caracteres!';
  static const String tituloVazio = 'Informe um título!';
  static const String subtituloVazio = 'Informe um subtítulo';
  static const String subtituloCurto = 'O subtítulo deve conter pelo menos 10 caracteres';

  static const String semConexao = 'Conecte-se à uma rede de internet e tente novamente!';
  static const String erroLink = 'Não foi possível enviar o link, tente novamente mais tarde.';
  static const String usuarioNaoExiste = 'Usuário não encontrado.';
  static const String naoLogin = 'Não foi possível fazer o login, verique e-mail e senha e tente novamente.';
  static const String dadosNaoAlterados = 'Não foi possível salvar as mudanças.';

  static const String naoFoiPossivelAcessarDado = 'Não foi possível acessar o dado.';

}

sealed class SuccessStrings{
  static const String linkEnviado = 'Link enviado com sucesso!';
  static const String login = 'Login feito com sucesso!';
  static const String contaCriada = 'Conta criada com sucesso!';
  static const String dadosAlterados= 'Dados alterados com sucesso!';
}
