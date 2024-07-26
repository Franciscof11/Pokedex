# Decisão de Arquitetura: Clean Architecture

Ao decidir a arquitetura para o projeto, optei por implementar a Clean Architecture, utilizando as camadas de Data, Domain e Presentation, pois ao meu ver combina com a utilização do Flutter Bloc como gerenciador de estado. Essa escolha foi guiada pela necessidade de estruturar o código de forma modular, escalável e de fácil manutenção.


# Bibliotecas Utilizadas

- **bloc** -> Gerenciador de estado.
- **dio** -> Pacote de rede para efetuar requisições http.
- **freezed** -> Gerador de código para classes de estados e eventos do bloc.
- **sqflite** -> Banco de dados SQL utilizado para realizar o cashe de dados na memória do aparelho.
- **google_fonts** -> Utilização de fontes nativa do Google.
- **flutter_launcher_icons** -> Customização e configuração do ícone do applicativo.
- **flutter_native_splash** -> Criação da Splash Screen nativa do aplicativo.
- **device_preview** -> Testes em diversos tamanhos de tela, para melhor responsividade para a aplicação.
- **percent_indicator** -> Biblioteca de animações.
- **cached_network_image** -> Biblioteca para mostrar imagens e mantê-las no diretório de cache do aparelho.


# Documentação da Arquitetura
A Clean Architecture é uma abordagem de design de software proposta por Robert C. Martin, que visa criar sistemas modulares, escaláveis e testáveis, mantendo uma separação clara entre as preocupações de alto e baixo nível. Essa arquitetura promove a independência das camadas e facilita a manutenção, testabilidade e evolução do código.


### Camadas da Clean Architecture

1. **Data:**
   - **Repositórios (Repositories):** Responsáveis pela comunicação com fontes de dados externas, como bancos de dados, APIs ou caches. Nesta camada, são definidas classes que serão implementadas nas camadas externas.

2. **Domain:**
   - **Models:** Contêm as representações abstrata de dados das requisições feitas á serviços externos. Estrutura que define como os dados são organizados, armazenados e manipulados no sistema

3. **Presentation:**
   - **Interface de Usuário (UI):** Responsável por apresentar as informações ao usuário e capturar as interações. No contexto do Flutter Bloc, a camada de UI é implementada utilizando widgets Flutter que respondem aos estados emitidos pelo bloc, como tambem possui a organização dos bloc's de cada página/feature.


### Vantagens da Combinação

- **Desacoplamento:** A Clean Architecture com as camadas de Data, Domain e Presentation permite que o Flutter Bloc e a lógica de negócios coexistam independentemente. Isso facilita a substituição ou atualização de uma camada sem afetar a outra.

- **Testabilidade:** A separação de responsabilidades facilita a criação de testes unitários para as camadas de lógica de negócios, garantindo a robustez e confiabilidade do código.

- **Manutenção:** A estrutura clara e modular da Clean Architecture simplifica a manutenção do código ao longo do tempo. As mudanças em uma camada não afetam diretamente as outras, promovendo uma base sólida para a evolução do projeto.


### Clean Architecture no Projeto

Nesse projeto, optei pela utilização das 3 camadas, onde:

**Data:** Possui todos os arquivos de repositórios, os quais fazem requisições à serviços externos como a api disponibilizada.

**Domain:** Contém o arquivo de modelagem dos dados das entidades. Também responsável pela serialização e desserialização dos objetos

**Presentation:** Camada responsável por armazenar toda a parte da UI do projeto, telas e arquivos bloc. Cada pasta possui sua tela e pasta bloc com seus respectivos arquivos do gerenciamento de estado. 
