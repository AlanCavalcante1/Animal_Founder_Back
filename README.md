<h1>Animal Founder</h1> 
<b>Endpoints para a requisicao na API</b>
<br>
<b>Usuarios</b>

"/sign_up": Requisicao Post para essa rota, cria um novo usuario no banco de dados com o seguinte JSON

```
{
	"user":{
		"name": string,
		"password": string,
		"password_confirmation": string,
		"email": string,
		"cellphone": string //(XX)XXXXX-XXXX
	}
}
```

“/login”: Requisições POST para essa rota com o seguinte JSON cria uma sessão para o usuário pedido, e retorna um token que deve ser armazenado para fazer as demais requisições, usando-o para autorizar as mesmas. 
```
{
	"user":{
		"email":string,
		"password":string
	}
}
```
"/users/:id": 
	-Requisicao PUT via Json, ira atualizar o usuario, com os novos dados, passando no headers "Authorization" com o valor do token recebido ao realizar login, e no parametro o ID do Usuario que deseja atualizar.
	-Requisicao Delete ira deletar o usuario, do nosso banco de dados, passando no headers "Authorization" com o valor do token recebido ao realizar login, e no parametro o ID do Usuario que deseja atualizar.
	

“/password/forgot”: Requisições POST para essa rota via JSON, passando email do usuário, envia um email para o usuário com link para redefinir a senha.
```
{
    "email": “example@email.com”
}
```
"/recover_password/:token": Requisições POST para essa rota via Json, com o token de um usuário. Esse :token, será um token gerado pelo "/forgot" e que ficara salvo no user.validation_token, esse validation_token será o nosso :token

```
{
 "password": string,
 "password_confirmation": string
}
```

"/authentication/confirm/:validation_token": Requisicao GET para essa rota, ira confirmar o usuario que ele tem acesso ao email cadasstrado no sistema. O :token sera o valor de user.validation_token

"/authentication/repeat_token": Requisicao Post para essa rota via Json, irá reenviar o token necessario para confirmar acesso do usuario ao email cadastrado.
```
{
	"email": string
}
```
"/users/animals": Requisicao GET para essa rota, passando no headers "Authorization" com o valor do token recebido ao realizar login, irá retornar todos Animais cadastrados que o usuario do "Auhtorization" cadastrar e respostas de outros Usuarios sobre o post

<b>Animais</b>
"/animals": requisicao Post via MultiPart, passando no headers "Authorization" com o valor do token recebido ao realizar login, ira cadastrar um novo animal no Banco de Dados
```
"photo": file,
"name": string,
"user_id": integer, //references a algum usuario
"age":integer,
"state":integer, //variando de 0 a 27
"city":string,
"description": string
```

"/animals/:id": requisicao PUT via MultiPart, passando no headers "Authorization" com o valor do token recebido ao realizar login, irá atualizar o animal pelo seu id, passado no parametro
```
"photo": file,
"name": string,
"user_id": integer, //references a algum usuario
"age":integer,
"state":integer, //variando de 0 a 27
"city":string,
"description": string
```
"/animals/:id": requisicao Destroy, passando no headers "Authorization" com o valor do token recebido ao realizar login, irá destruir o cadastro do Animal passado pelo ID do parametro da URL

"/answer/:animal": Requisicao Post via Json, passando no headers "Authorization" com o valor do token recebido ao realizar login, irá criar um Answer, notificando o dono do animal perdido que temos noticias do animal
```
{
	"message":string
}
```

"/animals/page/:page": Requisições GET para essa rota, passando a página que você deseja obter como parametro, retornando os 15 últimos Animais criados, sendo page:1 à página inicial.
