# Teste Marketeasy

## App simples para consumir uma API que simula um login e listagem de produtos utilizando um token.
**Documentação da API:**  http://servicosflex.rpinfo.com.br:9000/v2.0/produtounidade/listaprodutos/0/unidade/83402711000110
````
Login padrão da aplicação.
{
  "usuario": "100000"
  "senha": "123456"
}
````
### Instruções de uso:
 - Execute o arquivo **app.apk** em seu dispositivo, caso queira testar diretamente.
 - Caso contrário clone o repositório e execute o programa via linda de comando com ````flutter run```` na pasta raiz do repositório.
 -  Fica mais fácil, a análise do código utilizando o [**Android Studio**](https://developer.android.com/studio?hl=pt&gclid=Cj0KCQjw24qHBhCnARIsAPbdtlIkuQhImjihjGh0lZVjSSGsAwlBTZigNuAdw-TTInSGBCKMYLxI4IAaAoQCEALw_wcB&gclsrc=aw.ds)


### Telas
<p align="center" > 
<img src="https://user-images.githubusercontent.com/57741609/124535681-89da5000-dde4-11eb-899c-5207933f1823.png" width="600"> 
</p>

---

### Pastas
  - _**screens**_
    - Contém as duas telas do aplicativo.
  - _**backend**_
    -  Tem os arquivos com as classes relacionadas a regras de negócio.
  - _**shared_components**_
    - Possue os widgets que podem ser compartilhados em mais de uma tela 
---

### Arquivos 
- _**backend/models/produtos.dart**_ 
  - Classe responsável por armazenar os atributos requiridos no desafio que são: **_codigoInterno, descricao, valorUnitario, codigoBarras_**
- _**backend/api_controller.dart**_
  - Classe responsável por todas as manipulações da API e persistir as informações pelo token de maneira simples.
---
- _**screens/home_screen.dart**_
    - Tela em que se encontra a listagem de produtos, assim como o botão para baixar a lista de produtos novamente.
 - _**screens/login_screen.dart**_
    - Tela de login simples.
 ---
 - _**shared_components/list_view_products.dart**_
    - Widget que recebe a lista de produtos e as reproduzem separando em cards, mostrandos os atributos da classe **produtos**.
 ---
- _**main.dart**_
    - Arquivo de entrada do programa, nela que ocorre a decisão se o usuário vai direto para a tela de **_Home_ ou de _Login_**.
### Autor
---

<img style="border-radius: 50%;" src="https://media-exp3.licdn.com/dms/image/C4D03AQEET_PIFFi3Bg/profile-displayphoto-shrink_800_800/0/1615702283090?e=1631145600&v=beta&t=13BaJch4ahIM5Y5Iak5j1yawePZHCv9Gy_NxCW3dTtg" width="100px;" alt=""/>

 <br />

Feito com ❤️ por **Julio Rennan!**


<br/>


[![Linkedin Badge](https://img.shields.io/badge/-Julio-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/julio-souza-4ab63b1aa/)](https://www.linkedin.com/in/julio-souza-4ab63b1aa/) 
